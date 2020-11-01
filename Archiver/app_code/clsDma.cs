// clsDma: A set of standard utilities to perofrm repetitive tasks through a public class
// Copyright @DMA, Limited, Chicago, IL., June 2003, all rights reserved.
// Licensed on a use only basis for clients of DMA, Limited.
/* TODO ERROR: Skipped DefineDirectiveTrivia *//* TODO ERROR: Skipped DefineDirectiveTrivia */
using global::System;
using global::System.Collections;
using System.Collections.Generic;

// Imports VB = Microsoft.VisualBasic
using global::System.Configuration;
using System.Diagnostics;
using System.Drawing;
using global::System.IO;
using System.Linq;
using global::System.Net;
using global::System.Net.Sockets;
using System.Runtime.InteropServices;
using global::System.Speech.Synthesis;
using global::System.Text;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using global::Microsoft.Win32;
using MODI;

namespace EcmArchiver
{
    public class clsDma : IDisposable
    {
        public clsDma()
        {
            TempEnvironDir = getEnvVarTempDir();
            currDomain.UnhandledException += modGlobals.MYExnHandler;
            Application.ThreadException += modGlobals.MYThreadHandler;
        }

        private const int MUST_BE_LESS_THAN = 100000000; // 8 decimal digits
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        public int IXV1 = 0;
        // Dim DFLT As New clsDefaults

        // Dim owner As IWin32Window
        private const long BUFFERSIZE = 65535L;
        private long GraphicWidth = 0L;
        private long GraphicHeight = 0L;
        private long GraphicDepth = 0L;

        // image type enum
        [DllImport("urlmon", EntryPoint = "URLDownloadToFileA")]
        private static extern long URLDownloadToFile(long pCaller, string szURL, string szFileName, long dwReserved, long lpfnCB);

        private bool ddebug = false;
        private bool bb = false;
        public string TempEnvironDir;
        private string CurrHostName = "";
        private string MachineIP = "";
        private IPAddress myIPAddress, MacAddr, x;
        private IPHostEntry myIPHostEntry = new IPHostEntry();

        // Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

        private Registry oReg;
        private RegistryKey oRegKey;
        public bool RetC;
        private AppDomain currDomain = AppDomain.CurrentDomain;

        public void WildCardCharValidate(ref string StringToEval)
        {
            string S = StringToEval.Trim();
            int I = 0;
            int J = 0;
            string CH = "";
            var loopTo = S.Length;
            for (I = 0; I <= loopTo; I++)
            {
                CH = Strings.Mid(S, I, 1);
                if (CH == Conversions.ToString('"'))
                {
                    I = I + 1;
                    CH = Strings.Mid(S, I, 1);
                    while (CH != Conversions.ToString('"') & I <= S.Length)
                    {
                        CH = Strings.Mid(S, I, 1);
                        I = I + 1;
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
            // String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
            // String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
            Dirs = new string[1];
            // ReDim Files (0)
            string path = TargetDir;
            try
            {
                if (!Directory.Exists(path))
                {
                    return;
                }
                else
                {
                    Dirs = Directory.GetDirectories(path);
                    // Files = Directory.GetFiles(path)
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine(ex.Source);
                if (ddebug)
                    Console.WriteLine(ex.StackTrace);
                if (ddebug)
                    Console.WriteLine(ex.Message);
                LogThis("clsDma : getSubDirs : 27 : " + ex.Message);
                LogThis("clsDma : getSubDirs : 28 : " + ex.Message);
                LogThis("clsDma : getSubDirs : 29 : " + ex.Message);
            }
        }

        public void getDirFiles(ref string[] Files, string TargetDir)
        {
            // String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
            // String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
            // ReDim Dirs (0)
            Files = new string[1];
            string path = TargetDir;
            try
            {
                if (!Directory.Exists(path))
                {
                    return;
                }
                else
                {
                    // Dirs = Directory.GetDirectories(path)
                    Files = Directory.GetFiles(path);
                }
            }
            catch (Exception ex)
            {
                LogThis("clsDma : getDirFiles : 37 : " + ex.Message);
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
            // String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
            // String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
            Dirs = new string[1];
            Files = new string[1];
            string path = TargetDir;
            try
            {
                if (!Directory.Exists(path))
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
                if (ddebug)
                    Console.WriteLine(ex.Source);
                if (ddebug)
                    Console.WriteLine(ex.StackTrace);
                if (ddebug)
                    Console.WriteLine(ex.Message);
                LogThis("clsDma : ListDirs : 52 : " + ex.Message);
                LogThis("clsDma : ListDirs : 55 : " + ex.Message);
                LogThis("clsDma : ListDirs : 58 : " + ex.Message);
            }
        }

        public bool DownloadWebFile(string WebFqn, string ToFqn)
        {
            bool B = false;
            WebFqn = "http://www.vb-helper.com/vbhelper_425_64.gif";
            ToFqn = modGlobals.gTempDir + @"\vbhelper_425_64.gif";
            try
            {
                clsDma.URLDownloadToFile(0L, ref WebFqn, ref ToFqn, 0L, 0L);
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
                LogThis("clsDma : DownloadWebFile : 59 : " + ex.Message);
                LogThis("clsDma : DownloadWebFile : 63 : " + ex.Message);
                LogThis("clsDma : DownloadWebFile : 67 : " + ex.Message);
            }

            return B;
        }

        public void setHostName()
        {
            string shostname = "";
            shostname = Dns.GetHostName();
            if (ddebug)
                Console.WriteLine("Your Machine Name = " + shostname);
            CurrHostName = shostname;
        }

        public string getHostname()
        {
            if (string.IsNullOrEmpty(CurrHostName))
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
            server = Dns.GetHostName();
            try
            {
                var ASCII = new ASCIIEncoding();

                // Get server related information.

                // Loop on the AddressList
                var heserver = Dns.GetHostEntry(server);
                foreach (var curAdd in heserver.AddressList)
                {

                    // Display the type of address family supported by the server. If the
                    // server is IPv6-enabled this value is: InternNetworkV6. If the server
                    // is also IPv4-enabled there will be an additional value of InterNetwork.
                    // ** Console.WriteLine(("AddressFamily: " + curAdd.AddressFamily.ToString()))
                    s = "AddressFamily: " + curAdd.AddressFamily.ToString();
                    if (ddebug)
                        Console.WriteLine(s);

                    // Display the ScopeId property in case of IPV6 addresses.
                    if ((curAdd.AddressFamily.ToString() ?? "") == (ProtocolFamily.InterNetworkV6.ToString() ?? ""))
                    {
                        s = "Scope Id: " + curAdd.ScopeId.ToString();
                        if (ddebug)
                        {
                            if (ddebug)
                                Console.WriteLine(s);
                        }
                    }

                    // Display the server IP address in the standard format. In IPv4 the format will be
                    // dotted-quad notation, in IPv6 it will be in in colon-hexadecimal notation.
                    s = "Address: " + curAdd.ToString();
                    s = curAdd.ToString();
                    Console.WriteLine(s);
                    if (isFourPartIP(s))
                    {
                        MachineIP = s;
                        break;
                    }
                    // Display the server IP address in byte format.
                    // Console.Write("AddressBytes: ")
                    // s = ""
                    // Dim bytes As [Byte]() = curAdd.GetAddressBytes()
                    // Dim i As Integer
                    // For i = 0 To bytes.Length - 1
                    // Console.Write(bytes(i))
                    // s = s + bytes(i).ToString
                    // Next i
                    // Console.WriteLine(ControlChars.Cr + ControlChars.Lf)
                    // Console.WriteLine(s)
                }
            }
            catch (Exception e)
            {
                if (ddebug)
                    Console.WriteLine("[DoResolve] Exception: " + e.ToString());
                LogThis("clsDma : setIPAddr : 87 : " + e.Message);
                LogThis("clsDma : setIPAddr : 92 : " + e.Message);
                LogThis("clsDma : setIPAddr : 97 : " + e.Message);
            }

            MachineIP = s;
        }

        public bool isFourPartIP(string IP)
        {
            if (Strings.InStr(IP, ":") > 0)
            {
                return false;
            }

            var A = IP.Split('.');
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
            if (string.IsNullOrEmpty(MachineIP))
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
                if (ddebug)
                    Console.WriteLine(ex.Message);
            }

            return td;
        }

        public byte[] LoadGraphic(string filePath)
        {
            var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            var reader = new BinaryReader(stream);
            var photo = reader.ReadBytes((int)stream.Length);
            reader.Close();
            stream.Close();
            return photo;
        }

        public string CheckFileName(string tVal)
        {
            int i = Strings.Len(tVal);
            int j = 0;
            string CH = "";
            var loopTo = tVal.Length;
            for (i = 1; i <= loopTo; i++)
            {
                CH = Strings.Mid(tVal, i, 1);
                if (CH.Equals("/"))
                {
                    StringType.MidStmtStr(ref tVal, i, 1, ".");
                }
                else if (CH.Equals(":"))
                {
                    StringType.MidStmtStr(ref tVal, i, 1, ".");
                }
            }

            var loopTo1 = tVal.Length;
            for (i = 1; i <= loopTo1; i++)
            {
                CH = Strings.Mid(tVal, i, 1);
                // j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz.-@ :", CH, CompareMethod.Text)
                j = Strings.InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz-@ .", CH, CompareMethod.Text);
                if (j == 0)
                {
                    tVal = RemoveChar(tVal, CH);
                }
            }

            return tVal;
        }

        public string RemoveChar(string tVal, string CharToRemove)
        {
            int i = Strings.Len(tVal);
            string[] A;
            string S = "";
            A = tVal.Split(Conversions.ToChar(CharToRemove));
            var loopTo = Information.UBound(A);
            for (i = 0; i <= loopTo; i++)
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
            int i = Strings.Len(tVal);
            string ch = "";
            var loopTo = Strings.Len(tVal);
            for (i = 1; i <= loopTo; i++)
            {
                ch = Strings.Mid(tVal, i, 1);
                if (ch == "^")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, ",");
                }
            }

            return tVal;
        }

        public string ReplaceChar(string InputString, string CharToReplace, string ReplaceWith)
        {
            int i = Strings.Len(InputString);
            string ch = "";
            var loopTo = Strings.Len(InputString);
            for (i = 1; i <= loopTo; i++)
            {
                ch = Strings.Mid(InputString, i, 1);
                if (ch.Equals(CharToReplace))
                {
                    StringType.MidStmtStr(ref InputString, i, 1, ReplaceWith);
                }
            }

            return InputString;
        }

        // Public Function GetFileName(ByVal FQN ) As String
        // Dim fn  = ""

        // Dim i# = 0 Dim j# = 0 Dim ch = "" For i = Len(FQN) To 1 Step -1 ch = Mid(FQN, i, 1) If ch = "\"
        // Then fn = Mid(FQN, i + 1) Exit For End If If ch = "/" Then fn = Mid(FQN, i + 1) Exit For End If
        // Next If fn = "" And FQN.Length > 0 Then Return FQN Else Return fn End If

        // End Function

        public string GetFilePath(string FQN)
        {
            string fn = "";
            try
            {
                double i = 0d;
                double j = 0d;
                string ch = "";
                for (i = Strings.Len(FQN); i >= 1d; i += -1)
                {
                    ch = Strings.Mid(FQN, (int)i, 1);
                    if (ch == @"\")
                    {
                        fn = Strings.Mid(FQN, 1, (int)(i - 1d));
                        break;
                    }

                    if (ch == "/")
                    {
                        fn = Strings.Mid(FQN, 1, (int)(i - 1d));
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
                LOG.WriteToArchiveLog("(ERROR clsDma:GetFilePath: COuld not get file path - " + ex.Message + Constants.vbCrLf + ex.StackTrace);
                return fn;
            }
        }

        public void tWait(double tDelay)
        {
            double start = 0d;
            double finish = 0d;
            double totalTime = 0d;
            start = DateAndTime.Timer;
            // Set end time for 1/5-second duration.
            double mSduration = tDelay / 1000d;
            finish = start + mSduration;
            while (DateAndTime.Timer < finish)
            {
                // Do other processing while waiting for 5 seconds to elapse.
            }

            totalTime = DateAndTime.Timer - start;
        }
        // *************************************************************
        // * @Copyright:  @ DMA, Limited June 2002, all rights reserved.;
        // * @Typecall:   Function;
        // * @Name:       AddEncryptedUser;
        // * @Author:     W. Dale Miller;
        // * @Purpose:    This PUBLIC FUNCTION removes empty tArray elements

        // * @Parms:
        // * @Parms:
        // * @Return:
        // * @RC:
        // *************************************************************

        // * @Flow:
        // * @Flow:

        public bool FileExist(string fqn)
        {
            bool FileExistRet = default;
            ;
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
            /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToLabelStatement not implemented, please report this issue in 'On Error GoTo FERR' at character 17621


            Input:
                    '*************************************************************
                    '* @Copyright:  @ DMA, Limited June 2002, all rights reserved.;
                    '* @Typecall:   Function;
                    '* @Name:       AddEncryptedUser;
                    '* @Author:     W. Dale Miller;
                    '* @Purpose:    This PUBLIC FUNCTION removes empty tArray elements

                    '* @Parms:
                    '* @Parms:
                    '* @Return:
                    '* @RC:
                    '*************************************************************

                    '* @Flow:
                    '* @Flow:

                    On Error GoTo FERR

             */
            string MyFile;
            if (Strings.Len(Strings.Trim(fqn)) == 0)
            {
                FileExistRet = false;
                return FileExistRet;
            }

            MyFile = fqn;
            MyFile = FileSystem.Dir(MyFile);
            if (Strings.Len(Strings.Trim(MyFile)) > 0)
            {
                FileExistRet = true;
            }
            else
            {
                FileExistRet = false;
            }

            return FileExistRet;
            FERR:
            ;
            ;
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
            /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToZeroStatement not implemented, please report this issue in 'On Error GoTo 0' at character 18191


            Input:

                    On Error GoTo 0

             */
            FileExistRet = false;
        }

        public string getHelpFile()
        {
            string getHelpFileRet = default;
            string URL;
            URL = "WDM URL.hlp";
            // **WDM getHelpFile = App.Path & App.EXEName & ".HLP"
            getHelpFileRet = URL;
            return getHelpFileRet;
        }

        // ** Gets and returns a registry value for the current UserID
        public string CapiInterface(string Key1, string Key2)
        {
            string s = "";
            var rkCurrentUser = Registry.CurrentUser;
            var rkTest = rkCurrentUser.OpenSubKey(Key1 + ":" + Key2);
            if (rkTest is null)
            {
                s = "";
            }
            else
            {
                s = Conversions.ToString(rkTest.GetValue(Key1 + ":" + Key2));
                rkTest.Close();
                rkCurrentUser.Close();
            }

            return s;
        }

        // ** Sets a registry value for the current UserID
        public string CApiSetLocalIniValue(string Key1, string Key2, string SuppliedVal)
        {
            string RegistryKey = Key1 + ":" + Key2;
            // RegistryKey = Key1 + ":" + Key2
            var rkTest = Registry.CurrentUser.OpenSubKey("RegistryOpenSubKeyExample", true);
            if (rkTest is null)
            {
                var rk = Registry.CurrentUser.CreateSubKey("RegistryOpenSubKeyExample");
                rk.Close();
            }
            else
            {
                rkTest.SetValue(RegistryKey, SuppliedVal);
                // Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
                rkTest.Close();
            }

            return SuppliedVal;
        }

        // Modify a phone-number to the format "XXX-XXXX" or "(XXX) XXX-XXXX".
        public string xFormatPhoneNumber(string text)
        {
            long i;
            // ignore empty strings
            if (Strings.Len(text) == 0)
            {
                return "";
            }
            // get rid of dashes and invalid chars
            for (i = Strings.Len(text); i >= 1L; i += -1)
            {
                if (Strings.InStr("0123456789", Strings.Mid(text, (int)i, 1)) == 0)
                {
                    text = Strings.Mid(text, 1, (int)(i - 1L)) + Strings.Mid(text, (int)(i + 1L));
                }
            }
            // then, re-insert them in the correct position
            if (Strings.Len(text) <= 7)
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
            // This sub will get all IP addresses, the first one should be the adapters MAC
            // address, the second one the IP Address when connected to the internet.

            IPAddress myIPAddress, MacAddr;
            var myIPHostEntry = new IPHostEntry();
            myIPHostEntry = Dns.GetHostEntry(Dns.GetHostName());
            int i = 0;
            myIPAddress = null;
            MacAddr = null;
            foreach (var x in myIPHostEntry.AddressList)
            {
                // i = i + 1
                // If i = 1 Then
                // MacAddr = x.ToString()
                // End If
                // If i = 2 Then
                // myIPAddress = x.ToString()
                // End If
                // ShowMsg(owner, x.ToString())
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
            int L = Strings.Len(TgtStr);
            int I = 0;
            while (Strings.InStr(tStr, TgtStr, CompareMethod.Text) > 0)
            {
                I = Strings.InStr(tStr, TgtStr, CompareMethod.Text);
                S1 = Strings.Mid(tStr, 1, I - 1);
                S2 = Strings.Mid(tStr, I + L);
                tStr = S1 + S2;
            }

            return tStr;
        }

        public int SaveFile(string sFileName, byte[] bytFileByteArr)
        {

            // Saves a file with no file extension

            // Get the file name and set a new path to the local storage folder
            string strFile = Path.GetFileNameWithoutExtension(sFileName);

            // Dim GL As New clsGlobals
            // strFile = System.Web.Hosting.HostingEnvironment.MapPath(GL.getServerStroragePath(strFile))

            // write the file out to the storage location
            try
            {
                var stream = new FileStream(strFile, FileMode.CreateNew);
                stream.Write(bytFileByteArr, 0, bytFileByteArr.Length);
                stream.Close();
                return 0;
            }
            catch (Exception ex)
            {
                LogThis("clsDma :  : 308 : " + ex.Message);
                LogThis("clsDma :  : 313 : " + ex.Message);
                LogThis("clsDma :  : 318 : " + ex.Message);
                LogThis("clsDma :  : 959 : " + ex.Message);
                return 1;
            }
        }

        public string GetMimeType(string FileSuffix)
        {
            string MimeTypes = "application/andrew-inset | ez,application/mac-binhex40 | hqx,application/mac-compactpro | cpt,application/msword | doc,application/octet-stream | bin,application/octet-stream | dms,application/octet-stream | lha,application/octet-stream | lzh,application/octet-stream | exe,application/x-rar-compressed | rar,application/octet-stream | class,application/octet-stream | so,application/octet-stream | dll,application/oda | oda,application/pdf | pdf,application/postscript | ai,application/postscript | eps,application/postscript | ps,application/smil | smi,application/smil | smil,application/vnd.mif | mif,application/vnd.ms-excel | xls,application/vnd.ms-powerpoint | ppt,application/vnd.wap.wbxml | wbxml,application/vnd.wap.wmlc | wmlc,application/vnd.wap.wmlscriptc | wmlsc,application/x-bcpio | bcpio,application/x-cdlink | vcd,application/x-chess-pgn | pgn,application/x-cpio | cpio,application/x-csh | csh,application/x-director | dcr,application/x-director | dir,application/x-director | dxr,application/x-dvi | dvi,application/x-futuresplash | spl,application/x-gtar | gtar,application/x-hdf | hdf,application/x-javascript | js,application/x-koan | skp,application/x-koan | skd,application/x-koan | skt,application/x-koan | skm,application/x-latex | latex,application/x-netcdf | nc,application/x-netcdf | cdf,application/x-sh | sh,application/x-shar | shar,application/x-shockwave-flash | swf,application/x-stuffit | sit,application/x-sv4cpio | sv4cpio,application/x-sv4crc | sv4crc,application/x-tar | tar,application/x-tcl | tcl,application/x-tex | tex,application/x-texinfo | texinfo,application/x-texinfo | texi,application/x-troff | t,application/x-troff | tr,application/x-troff | roff,application/x-troff-man | man,application/x-troff-me | me,application/x-troff-ms | ms,application/x-ustar | ustar,application/x-wais-source | src,application/xhtml+xml | xhtml,application/xhtml+xml | xht,application/zip | zip,audio/basic | au,audio/basic | snd,audio/midi | mid,audio/midi | midi,audio/midi | kar,audio/mpeg | mpga,audio/mpeg | mp2,audio/mpeg | mp3,audio/x-aiff | aif,audio/x-aiff | aiff,audio/x-aiff | aifc,audio/x-mpegurl | m3u,audio/x-pn-realaudio | ram,audio/x-pn-realaudio | rm,audio/x-pn-realaudio-plugin | rpm,audio/x-realaudio | ra,audio/x-wav | wav,chemical/x-pdb | pdb,chemical/x-xyz | xyz,image/bmp | bmp,image/gif | gif,image/ief | ief,image/jpeg | jpeg,image/jpeg | jpg,image/jpeg | jpe,image/png | png,image/tiff | tiff,image/tiff | tif,image/vnd.djvu | djvu,image/vnd.djvu | djv,image/vnd.wap.wbmp | wbmp,image/x-cmu-raster | ras,image/x-portable-anymap | pnm,image/x-portable-bitmap | pbm,image/x-portable-graymap | pgm,image/x-portable-pixmap | ppm,image/x-rgb | rgb,image/x-xbitmap | xbm,image/x-xpixmap | xpm,image/x-xwindowdump | xwd,model/iges | igs,model/iges | iges,model/mesh | msh,model/mesh | mesh,model/mesh | silo,model/vrml | wrl,model/vrml | vrml,text/css | css,text/html | html,text/html | htm,text/plain | asc,text/plain | txt,text/richtext | rtx,text/rtf | rtf,text/sgml | sgml,text/sgml | sgm,text/tab-separated-values | tsv,text/vnd.wap.wml | wml,text/vnd.wap.wmlscript | wmls,text/x-setext | etx,text/xml | xsl,text/xml | xml,video/mpeg | mpeg,video/mpeg | mpg,video/mpeg | mpe,video/quicktime | qt,video/quicktime | mov,video/vnd.mpegurl | mxu,video/x-msvideo | avi,video/x-sgi-movie | movie,x-conference/x-cooltal | ice";
            var A = Strings.Split(MimeTypes, ",");
            int I = 0;
            string Classification = "";
            string TgtMime = "";
            var loopTo = Information.UBound(A);
            for (I = 0; I <= loopTo; I++)
            {
                var b = Strings.Split(A[I], "|");
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
            if (data is object)
            {
                var sb = new StringBuilder();
                for (int i = 0, loopTo = data.Length - 1; i <= loopTo; i++)
                    sb.Append(data[i].ToString("X2"));
                return sb.ToString();
            }
            else
            {
                return null;
            }
        }

        public static byte[] HexToBin(string s)
        {
            int arraySize = (int)(s.Length / 2d);
            var bytes = new byte[arraySize];
            var counter = default(int);
            for (int i = 0, loopTo = s.Length - 1; i <= loopTo; i += 2)
            {
                string hexValue = s.Substring(i, 2);

                // Tell convert to interpret the string as a 16 bit hex value
                int intValue = Convert.ToInt32(hexValue, 16);
                // Convert the integer to a byte and store it in the array
                bytes[counter] = Convert.ToByte(intValue);
                counter += 1;
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
                var dirInfo = new DirectoryInfo(path);
                foreach (var fileObject in dirInfo.GetFileSystemInfos())
                {
                    Application.DoEvents();
                    int iCode = (int)fileObject.Attributes;
                    string SS = fileObject.Attributes.ToString();
                    bool isDirectory = false;
                    if (Conversions.ToBoolean(Strings.InStr(SS, ", directory", CompareMethod.Text)))
                    {
                        if (ddebug)
                            Debug.Print(fileObject.Attributes.ToString());
                        isDirectory = true;
                    }

                    if (iCode == 16)
                    {
                        isDirectory = true;
                    }

                    if (isDirectory == true)
                    {
                        My.MyProject.Forms.frmMain.SB.Text = fileObject.FullName;
                        My.MyProject.Forms.frmMain.SB.Refresh();
                        Application.DoEvents();

                        // Dim tDir  = GetFilePath(fileObject.FullName)
                        dirfound = true;
                        Array.Resize(ref A, Information.UBound(A) + 1 + 1);
                        A[Information.UBound(A)] = fileObject.FullName;
                        My.MyProject.Forms.frmMain.SubDirectories.Add(fileObject.FullName);
                        RecursiveSearch(fileObject.FullName, ref A);
                    }
                }

                return dirfound;
            }
            catch (Exception ex)
            {
                LogThis("clsDma : RecursiveSearch : 422 : " + ex.Message);
                return false;
            }
        }

        /// <summary>
    /// </summary>
    /// <param name="DirName">      </param>
    /// <param name="DirFiles">     </param>
    /// <param name="IncludedTypes"></param>
    /// <param name="ExcludedTypes"></param>
    /// <param name="ckArchiveFlag"></param>
    /// <returns></returns>
    /// <remarks></remarks>
        public int getFilesInDir(string DirName, ref List<string> DirFiles, ArrayList IncludedTypes, ArrayList ExcludedTypes, bool ckArchiveFlag)
        {

            // WDM - Convert the below to use a data structure class

            int I = DirFiles.Count;
            int iFilesAdded = 0;
            string xFileName = "";
            var FilterList = new List<string>();
            bool ArchiveAttr = false;
            for (int II = 0, loopTo = IncludedTypes.Count - 1; II <= loopTo; II++)
            {
                if (Strings.InStr(Conversions.ToString(IncludedTypes[II]), ".") == 0)
                {
                    IncludedTypes[II] = Operators.AddObject(".", IncludedTypes[II]);
                }

                if (Strings.InStr(Conversions.ToString(IncludedTypes[II]), "*") == 0)
                {
                    IncludedTypes[II] = "*";
                }

                if (Strings.InStr(Conversions.ToString(IncludedTypes[II]), "*.*") > 0)
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

                FilterList.Add(Conversions.ToString(IncludedTypes[II]));
            }

            try
            {
                string FileAttributes = "";
                string strFileSize = "";
                int iFileSize = 0;
                var di = new DirectoryInfo(DirName);

                // Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
                var fi = default(FileInfo);
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
                    foreach (var currentFi in Files)
                    {
                        fi = currentFi;
                        XX += 1;
                        if (Conversions.ToBoolean((int)fi.Attributes & 32))
                        {
                            ArchiveAttr = true;
                            // frmReconMain.SB.Text = fi.Name
                            Application.DoEvents();
                        }
                        // frmReconMain.SB.Text = "Processed: -" & XX
                        else
                        {
                            ArchiveAttr = false;
                            if (ckArchiveFlag == true)
                            {
                                // frmReconMain.SB.Text = "Processed: -" & XX
                                Application.DoEvents();
                                goto NextFile;
                            }
                            else
                            {
                                // frmReconMain.SB.Text = "Processed: +" & XX
                                Application.DoEvents();
                            }
                        }

                        string fExt = fi.Extension;
                        if (Strings.InStr(fi.FullName, ".") == 0)
                        {
                            LogThis("Warning: File '" + fi.Name + "' has no extension, skipping.");
                            goto NextFile;
                        }

                        if (fExt.Length == 0)
                        {
                            fExt = getFileExtension(fi.FullName);
                        }

                        FixFileExtension(ref fExt);
                        string TempExt = fExt;
                        if (Strings.InStr(fExt, ".") == 0)
                        {
                            TempExt = "." + fExt;
                        }

                        if (Strings.InStr(fExt, "*") == 0)
                        {
                            TempExt = "*" + fExt;
                        }

                        bool bbExt = isExtIncluded(TempExt, IncludedTypes);
                        for (int IX = 0, loopTo1 = IncludedTypes.Count - 1; IX <= loopTo1; IX++)
                        {
                            if (IncludedTypes[IX].Equals("*.*") | IncludedTypes[IX].Equals("*"))
                            {
                                bbExt = true;
                            }
                        }

                        if (!bbExt)
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
                            bool bArch = isArchiveBitOn(fi.FullName);
                            if (bArch == false)
                            {
                                // This file does not need to be archived
                                goto NextFile;
                            }
                        }

                        xFileName = fi.FullName;
                        strFileSize = Math.Round(fi.Length / 1024d).ToString();
                        FileAttributes = "";
                        FileAttributes = FileAttributes + fi.Name + "|";
                        FileAttributes = FileAttributes + fi.FullName + "|";
                        FileAttributes = FileAttributes + fi.Length.ToString() + "|";
                        FileAttributes = FileAttributes + fi.Extension + "|";
                        var xdate = fi.LastAccessTime;
                        // Dim sDate As String = UTIL.ConvertDate(xdate)
                        string sDate = xdate.ToString();

                        // Console.WriteLine(xdate.ToString)
                        // Console.WriteLine(sDate)

                        // FileAttributes  = FileAttributes  + fi.LastAccessTime.ToString + "|"
                        FileAttributes = FileAttributes + xdate + "|";
                        xdate = fi.CreationTime;
                        // sDate = UTIL.ConvertDate(xdate)
                        sDate = xdate.ToString();
                        FileAttributes = FileAttributes + xdate + "|";
                        xdate = fi.LastWriteTime;
                        // sDate = UTIL.ConvertDate(xdate)
                        sDate = xdate.ToString();
                        FileAttributes = FileAttributes + xdate;
                        if (fi.Length > 0L)
                        {
                            string fn = fi.Name;
                            if (fn.Substring(1, 1).Equals("~"))
                            {
                                if (I == 0)
                                {
                                    DirFiles.Add(FileAttributes);
                                }
                                else
                                {
                                    DirFiles.Add(FileAttributes);
                                }
                            }
                        }

                        iFilesAdded += 1;
                        NextFile:
                        ;
                        I = I + 1;
                    }
                }
                catch (Exception ex)
                {
                    LogThis("ERROR - clsDma : getFilesInDir : 22012c : " + ex.Message + Constants.vbCrLf + "DIR: " + DirName + Constants.vbCrLf + "FILE: " + fi.Name);
                }
            }
            catch (Exception ex)
            {
                // messagebox.show("Error 22013: " + ex.Message)
                modGlobals.NbrOfErrors += 1;
                // 'FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                LogThis("clsDma : getFilesInDir : 471 : " + ex.Message);
            }

            return iFilesAdded;
        }

        public int getFileInDir(string DirName, ref List<string> DirFiles)
        {
            int I = 0;
            try
            {
                DirFiles.Clear();
                string FileAttributes = "";
                string strFileSize = "";
                int iFileSize = 0;
                var di = new DirectoryInfo(DirName);
                var aryFi = di.GetFiles("*.*");
                try
                {
                    foreach (var fi in aryFi)
                    {
                        strFileSize = Math.Round(fi.Length / 1024d).ToString();
                        FileAttributes = "";
                        FileAttributes = FileAttributes + fi.Name + "|";
                        FileAttributes = FileAttributes + fi.FullName + "|";
                        FileAttributes = FileAttributes + fi.Length.ToString() + "|";
                        FileAttributes = FileAttributes + fi.Extension + "|";
                        FileAttributes = FileAttributes + fi.LastAccessTime.ToString() + "|";
                        FileAttributes = FileAttributes + fi.CreationTime.ToString() + "|";
                        FileAttributes = FileAttributes + fi.LastWriteTime.ToString();
                        DirFiles.Add(FileAttributes);
                        I = I + 1;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error 22012a: " + ex.Message);
                    LogThis("clsDma : getFileInDir : 480 : " + ex.Message);
                    LogThis("clsDma : getFileInDir : 491 : " + ex.Message);
                    LogThis("clsDma : getFileInDir : 502 : " + ex.Message);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 22013: " + ex.Message);
                LogThis("clsDma : getFileInDir : 481 : " + ex.Message);
                LogThis("clsDma : getFileInDir : 493 : " + ex.Message);
                LogThis("clsDma : getFileInDir : 505 : " + ex.Message);
            }

            return I;
        }

        public int getFilesInDir(string DirName, ref List<string> DirFiles, string ExactFileName)
        {
            DirName = UTIL.RemoveSingleQuotes(DirName);
            ExactFileName = UTIL.RemoveSingleQuotes(ExactFileName);
            int I = 0;
            string FQN = DirName + @"\" + ExactFileName;
            try
            {
                DirFiles.Clear();
                string FileAttributes = "";
                string strFileSize = "";
                int iFileSize = 0;
                var di = new DirectoryInfo(DirName);
                var fInfo = new FileInfo(DirName + @"\" + ExactFileName);
                // Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName )
                // Dim fi As IO.FileInfo

                try
                {
                    // For Each fi In aryFi
                    strFileSize = Math.Round(fInfo.Length / 1024d).ToString();
                    FileAttributes = "";
                    FileAttributes = FileAttributes + fInfo.Name + "|";
                    FileAttributes = FileAttributes + fInfo.FullName + "|";
                    FileAttributes = FileAttributes + fInfo.Length.ToString() + "|";
                    FileAttributes = FileAttributes + fInfo.Extension + "|";

                    // Dim ZDate As DateTime = DateTime.Parse(fInfo.LastAccessTime.ToString)
                    // Date.ToString("ddMMyy")
                    // Date.ToString("hhmm")

                    var xDate = fInfo.LastAccessTime;
                    xDate.ToString("MM/dd/yyyy");
                    FileAttributes = FileAttributes + xDate.ToString() + "|";
                    xDate = fInfo.CreationTime;
                    xDate.ToString("MM/dd/yyyy");
                    FileAttributes = FileAttributes + fInfo.CreationTime.ToString() + "|";
                    FileAttributes = FileAttributes + fInfo.LastWriteTime.ToString();
                    if (fInfo.Length > 0L)
                    {
                        string fn = fInfo.Name;
                        if (fn.Substring(1, 1).Equals("~"))
                        {
                            if (I == 0)
                            {
                                DirFiles.Add(FileAttributes);
                            }
                            else
                            {
                                DirFiles.Add(FileAttributes);
                            }
                        }
                    }

                    I = I + 1;
                }
                // Next
                catch (Exception ex)
                {
                    MessageBox.Show("Error 22012b: " + ex.Message);
                    LogThis("clsDma : getFilesInDir : 508 : " + ex.Message);
                    LogThis("clsDma : getFilesInDir : 521 : " + ex.Message);
                    LogThis("clsDma : getFilesInDir : 534 : " + ex.Message);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 22013: " + ex.Message);
                LogThis("clsDma : getFilesInDir : 509 : " + ex.Message);
                LogThis("clsDma : getFilesInDir : 523 : " + ex.Message);
                LogThis("clsDma : getFilesInDir : 537 : " + ex.Message);
            }

            return I;
        }

        public void ReplaceStar(ref string tVal)
        {
            string CH = "";
            if (Strings.InStr(tVal, "*") == 0)
            {
                return;
            }

            if (tVal.Length > 0)
            {
                if (tVal.Length > 1)
                {
                    CH = Strings.Mid(tVal, 1, 1);
                    if (CH.Equals("*"))
                    {
                        StringType.MidStmtStr(ref tVal, 1, 1, "%");
                    }

                    CH = Strings.Mid(tVal, tVal.Length, 1);
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
            if (Strings.InStr(tVal, "'") == 0)
            {
                return;
            }

            for (int i = 1, loopTo = tVal.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(tVal, i, 1);
                if (CH.Equals("'"))
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "`");
                }
            }
        }

        public void GetStartAndStopDate(ref DateTime StartDate, ref DateTime EndDate)
        {
            // '5/14/2009 12:00:00 AM'
            string S1 = StartDate.ToString();
            string S2 = EndDate.ToString();
            int I = 0;
            I = Strings.InStr(S1, "12:00:00");
            StringType.MidStmtStr(ref S1, I, 1, "1");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, "2");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, ":");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, "0");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, "0");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, ":");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, "0");
            I += 1;
            StringType.MidStmtStr(ref S1, I, 1, "0");
            I = Strings.InStr(S2, "12:00:00");
            StringType.MidStmtStr(ref S2, I, 1, "1");
            StringType.MidStmtStr(ref S2, I, 1, "1");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "1");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, ":");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "5");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "9");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, ":");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "5");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "9");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, " ");
            I += 1;
            StringType.MidStmtStr(ref S2, I, 1, "P");
            StartDate = Conversions.ToDate(S1);
            EndDate = Conversions.ToDate(S2);
        }

        public string ckQryDate(string StartDate, string EndDate, string Evaluator, string DbColName, ref bool FirstTime)
        {

            // ** Set to false by WDM on 3/10/2010 to allow for parens and the AND operator
            FirstTime = false;
            string S = "";
            string CH = "";
            string WhereClause = "";
            if (Strings.UCase(Evaluator).Equals("OFF"))
            {
                return WhereClause;
            }
            else if (Evaluator.Equals("OFF"))
            {
                return WhereClause;
            }
            else if (Evaluator.Equals("After"))
            {
                if (FirstTime)
                {
                    WhereClause = " " + DbColName + " > '" + Conversions.ToDate(StartDate).ToString() + "'" + Constants.vbCrLf;
                    FirstTime = false;
                }
                else
                {
                    WhereClause = " AND (" + DbColName + " > '" + Conversions.ToDate(StartDate).ToString() + "')" + Constants.vbCrLf;
                }
            }
            else if (Evaluator.Equals("Before"))
            {
                if (FirstTime)
                {
                    WhereClause = " " + DbColName + " < '" + Conversions.ToDate(StartDate).ToString() + "'" + Constants.vbCrLf;
                    FirstTime = false;
                }
                else
                {
                    WhereClause = " AND (" + DbColName + " < '" + Conversions.ToDate(StartDate).ToString() + "')" + Constants.vbCrLf;
                }
            }
            else if (Evaluator.Equals("Between"))
            {
                DateTime argStartDate = Conversions.ToDate(StartDate);
                DateTime argEndDate = Conversions.ToDate(EndDate);
                GetStartAndStopDate(ref argStartDate, ref argEndDate);
                // select * from Production.Product where Sellcdate(StartDate).tostring between ‘2001-06-29′ and ‘2001-07-02′
                if (FirstTime)
                {
                    FirstTime = false;
                    WhereClause = " " + DbColName + " between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "' " + Constants.vbCrLf;
                }
                else
                {
                    WhereClause = " AND (" + DbColName + " between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                }
            }
            else if (Evaluator.Equals("Not Between"))
            {
                DateTime argStartDate1 = Conversions.ToDate(StartDate);
                DateTime argEndDate1 = Conversions.ToDate(EndDate);
                GetStartAndStopDate(ref argStartDate1, ref argEndDate1);
                // select * from Production.Product where SellStartDate between ‘2001-06-29′ and ‘2001-07-02′
                if (FirstTime)
                {
                    FirstTime = false;
                    WhereClause = " " + DbColName + " NOT between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "'" + Constants.vbCrLf;
                }
                else
                {
                    WhereClause = " AND (" + DbColName + " NOT between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                }
            }
            else if (Evaluator.Equals("On"))
            {
                DateTime argStartDate2 = Conversions.ToDate(StartDate);
                DateTime argEndDate2 = Conversions.ToDate(EndDate);
                GetStartAndStopDate(ref argStartDate2, ref argEndDate2);
                if (FirstTime)
                {
                    FirstTime = false;
                    WhereClause = " " + DbColName + " between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "'" + Constants.vbCrLf;
                }
                else
                {
                    WhereClause = " AND (" + DbColName + " between '" + Conversions.ToDate(StartDate).ToString() + "' and '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                }
            }
            else
            {
                return WhereClause;
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
            string CH = Strings.Mid(tDir, I, 1);
            if (CH == @"\")
            {
                return;
            }
            else
            {
                tDir = tDir + @"\";
            }
        }

        public void ListRegistryKeys(string FileExt, ref List<string> LB)
        {
            try
            {
                RegistryKey rootKey;
                rootKey = Registry.ClassesRoot;
                string S;
                RegistryKey regSubKey;
                RegistryKey tmp;
                rootKey = rootKey.OpenSubKey(FileExt, false);
                Debug.Print(rootKey.GetValue("").ToString());
                Debug.Print(rootKey.GetValue("Content Type").ToString());
                string ControlApp = rootKey.GetValue("Content Type").ToString();
                LB.Add("Content Type: " + rootKey.GetValue("Content Type").ToString());
                foreach (var subk in rootKey.GetSubKeyNames())
                {
                    // MessageBox.Show(subk)
                    S = subk + " : ";
                    tmp = rootKey.OpenSubKey(subk);
                    S = tmp.ToString();
                    LB.Add(S);
                }
            }
            catch (Exception ex)
            {
                Debug.Print(ex.Message);
                LogThis("clsDma : ListRegistryKeys : 595 : " + ex.Message);
                LogThis("clsDma : ListRegistryKeys : 610 : " + ex.Message);
                LogThis("clsDma : ListRegistryKeys : 625 : " + ex.Message);
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
            S = Strings.Mid((Environment.TickCount / 3600000d).ToString(), 1, 5) + " :Hours";
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
                // MessageBox.Show(fileDetail.Name & " is Archived")
                return false;
            }
            else
            {
                // MessageBox.Show(fileDetail.Name & " is NOT Archived")
                return true;
            }
        }

        public bool setFileArchiveAttributeSet(string FQN, bool SetOn)
        {
            var fileDetail = My.MyProject.Computer.FileSystem.GetFileInfo(FQN);
            if (SetOn == true)
            {
                fileDetail.Attributes = fileDetail.Attributes & FileAttributes.Archive;
            }
            else
            {
                fileDetail.Attributes = fileDetail.Attributes & ~FileAttributes.Archive;
            }

            return default;
        }

        public bool setFileArchiveBitOn(string FQN)
        {
            var fileDetail = My.MyProject.Computer.FileSystem.GetFileInfo(FQN);
            fileDetail.Attributes = (FileAttributes)((int)fileDetail.Attributes + (int)FileAttributes.Archive);
            return default;
        }

        public bool setFileArchiveBitOff(string FQN)
        {
            var fileDetail = My.MyProject.Computer.FileSystem.GetFileInfo(FQN);
            fileDetail.Attributes = (FileAttributes)((int)fileDetail.Attributes - (int)FileAttributes.Archive);
            return default;
        }

        // WDM This could be a problem
        public bool ToggleArchiveBit(string filespec)
        {
            filespec = UTIL.ReplaceSingleQuotes(filespec);
            try
            {
                object fso, f;
                fso = Interaction.CreateObject("Scripting.FileSystemObject");
                f = fso.GetFile(filespec);
                if (Conversions.ToBoolean(Operators.AndObject(f.attributes, 32)))
                {
                    f.attributes = Operators.SubtractObject(f.attributes, 32);
                    // ToggleArchiveBit = "Archive bit is cleared."
                    return true;
                }
                else
                {
                    f.attributes = Operators.AddObject(f.attributes, 32);
                    // ToggleArchiveBit = "Archive bit is set."
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogThis("clsDma : ToggleArchiveBit : 648 : " + ex.Message);
                return false;
            }
        }

        public bool isArchiveBitOn(string filespec)
        {

            // Dim skipThis As Boolean = True
            // If skipThis = True Then
            // Return False
            // End If

            bool B = false;
            try
            {
                FileAttribute MyAttr;
                // Assume file TESTFILE is normal and readonly.
                MyAttr = FileSystem.GetAttr(filespec);   // Returns vbNormal.
                                                         // Dim iAttr As Integer = GetAttr(filespec)

                // Test for Archived.
                if ((MyAttr & FileAttribute.Archive) == FileAttribute.Archive)
                {
                    // If (MyAttr And FileAttribute.Archive) = 1 Then
                    // The "A" is showing.
                    return true;
                }
                else
                {
                    return false;
                }
            }

            // Feb 7, 2010 - Set the above code in place and removed the following - WDM
            // Dim fso, f
            // fso = CreateObject("Scripting.FileSystemObject")
            // f = fso.GetFile(filespec)

            // If f.attributes And 32 Then
            // 'f.attributes = f.attributes - 32
            // 'ToggleArchiveBit = "Archive bit is cleared."
            // B = True
            // Else
            // 'f.attributes = f.attributes + 32
            // 'ToggleArchiveBit = "Archive bit is set."
            // B = False
            // End If
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning: clsDMa:isArchiveBitOn 100 - " + ex.Message);
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
                // 'Dim MyAttr As FileAttribute
                /// Assume file TESTFILE is normal and readonly.
                // 'MyAttr = GetAttr(filespec )   ' Returns vbNormal.
                // If F.Exists(filespec) Then
                // F.SetAttributes(filespec, FileAttributes.Archive)
                // 'SetAttr(filespec , FileAttribute.Archive)
                // End If

                var f = new FileInfo(filespec);
                f.Attributes = f.Attributes & ~FileAttributes.Archive;
                f = null;
            }

            // SetAttr(filespec , FileAttribute.Archive)
            // B = True
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning: clsDMa:setArchiveBitOn 100 - " + ex.Message);
                B = false;
            }

            return B;
        }

        /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped EndIfDirectiveTrivia */
                                                                                               /// <summary>
    /// OK - to anyone that reads this later... This is kind of a thought that should not be tried,
    /// but what the heck. MAybe we can pass a control in by REF and let the object modify itself. I
    /// figure if an ameba can do it, maybe a reflective object can too! Speaking of stupid, remember
    /// to wrap this in a TRY/CATCH.
    /// </summary>
    /// <param name="TT">     .NET ToolTip</param>
    /// <param name="ctrl">   Any form control</param>
    /// <param name="TipText">The Tooltip object must exist on the form or this will blow up.</param>
    /// <remarks></remarks>
        public void addToolTip(ToolTip TT, ref Control ctrl, string TipText)
        {
            // ** Holy shit, this may work!
            try
            {
                TT.SetToolTip(ctrl, TipText);
            }
            catch (Exception ex)
            {
                MessageBox.Show("You blew this idiot," + Constants.vbCrLf + ex.Message);
                LogThis("clsDma : addToolTip : 749 : " + ex.Message);
                LogThis("clsDma : addToolTip : 770 : " + ex.Message);
                LogThis("clsDma : addToolTip : 784 : " + ex.Message);
            }
        }

        // Public Sub smoLoadServers(ByRef CB As Windows.Forms.ComboBox)

        // Dim dt As DataTable = SmoApplication.EnumAvailableSqlServers(False) Dim ServersFound As Boolean
        // = False

        // If dt.Rows.Count > 0 Then
        // For Each dr As DataRow In dt.Rows
        // ServersFound = True
        // If ddebug Then Console.WriteLine(dr("Name"))
        // CB.Items.Add(dr("Name"))
        // Next
        // End If
        // If Not ServersFound Then
        // CB.Items.Add("NO SQL SERVERS FOUND")
        // End If
        // End Sub

        // Public Sub LoadServersCombo(ByRef CB As Windows.Forms.ComboBox)
        // Dim oSQLApp As SQLDMO.Application
        // Dim oNames As SQLDMO.NameList
        // Dim i As Integer
        // oSQLApp = New SQLDMO.Application    'POPULATE CBO ONLY WITH SQL SERVERS
        // oNames = oSQLApp.ListAvailableSQLServers
        // CB.Items.Clear()
        // For i = 1 To oNames.Count
        // CB.Items.Add(oNames.Item(i))
        // Next i
        // If oNames.Count = 0 Then
        // CB.Items.Add("NO SQL SERVERS FOUND")
        // End If
        // End Sub

        // Public Sub LoadDatabases(ByVal ServerName , ByVal UserID , ByVal PW , ByRef CB As Windows.Forms.ComboBox)
        // Dim oSQLServer As New SQLDMO.SQLServer
        // Dim i As Integer
        // CB.Items.Clear()
        // Try
        // If UserID = "" And PW = "" Then
        // oSQLServer.LoginSecure = True
        // End If
        // oSQLServer.Connect(ServerName, UserID, PW)
        // For i = 1 To oSQLServer.Databases.Count
        // Dim dbName  = oSQLServer.Databases.Item(i).Name.ToString
        // CB.Items.Add(dbName)
        // Next i
        // Catch ex As Exception
        // CB.Items.Clear()
        // CB.Items.Add(ex.Message.Trim)
        // End Try
        // End Sub

        public string formatTextSearch(string SearchString)
        {
            if (SearchString.Trim().Length == 0)
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
            var tStack = new ArrayList();
            var aList = new ArrayList();
            var loopTo = SearchString.Length;
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(SearchString, I, 1);
                if (CH == Conversions.ToString('"'))
                {
                    I = I + 1;
                    CH = Strings.Mid(SearchString, I, 1);
                    while (CH != Conversions.ToString('"') & I < SearchString.Length)
                    {
                        I = I + 1;
                        CH = Strings.Mid(SearchString, I, 1);
                    }
                }
                else if (CH == " ")
                {
                    var midTmp = Conversions.ToString('þ');
                    StringType.MidStmtStr(ref SearchString, I, 1, midTmp);
                }
            }

            var NewText = new ArrayList();
            var A = SearchString.Split('þ');
            var loopTo1 = Information.UBound(A);
            for (I = 0; I <= loopTo1; I++)
            {
                currWord = A[I];
                currWordIsKeyWord = ckKeyWord(currWord);
                prevWordIsKeyWord = ckKeyWord(prevWord);
                if (ddebug)
                    Console.WriteLine(SearchString);
                if (ddebug)
                    Console.WriteLine(currWord, currWordIsKeyWord);
                if (ddebug)
                    Console.WriteLine(currWord, prevWordIsKeyWord);
                if (currWordIsKeyWord == false & prevWordIsKeyWord == false)
                {
                    if (prevWord.Trim().Length > 0 & currWord.Trim().Length > 0)
                    {
                        string CH1 = Strings.Mid(currWord, 1, 1);
                        if (CH1.Equals(Conversions.ToString('"')))
                        {
                            NewText.Add("OR");
                            NewText.Add(currWord);
                        }
                        else if (Strings.InStr(1, "+-^|", CH1, CompareMethod.Text) == 0)
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
            var loopTo2 = NewText.Count - 1;
            for (I = 0; I <= loopTo2; I++)
            {
                bool isContainsDoubleQuote = false;
                bool isContainsStar = false;
                string tWord = NewText[I].ToString();
                if (Strings.InStr(tWord, "*") > 0)
                {
                    isContainsStar = true;
                }

                if (Strings.InStr(tWord, Conversions.ToString('"')) > 0)
                {
                    isContainsDoubleQuote = true;
                }

                if (isContainsDoubleQuote == false & isContainsStar == true)
                {
                    // ** Wrap this word in double quotes
                    tWord = tWord.Trim();
                    tWord = Conversions.ToString('"') + tWord + Conversions.ToString('"');
                }

                ReformattedSearch += tWord + " ";
            }

            return ReformattedSearch;
        }

        public bool ckKeyWord(string KW)
        {
            bool B = false;
            KW = Strings.UCase(KW);
            switch (KW ?? "")
            {
                case "NEAR":
                    {
                        return true;
                    }

                case "AND":
                    {
                        return true;
                    }

                case "OR":
                    {
                        return true;
                    }

                case "NOT":
                    {
                        return true;
                    }

                case "FORMSOF":
                    {
                        return true;
                    }

                case "FROM":
                    {
                        return true;
                    }

                case "ISABOUT":
                    {
                        return true;
                    }

                case "INFLECTIONAL":
                    {
                        return true;
                    }

                case "CONTAINS":
                    {
                        return true;
                    }

                case "ORDER":
                    {
                        return true;
                    }

                case "BY":
                    {
                        return true;
                    }

                case "CONTAINSTABLE":
                    {
                        return true;
                    }

                case "FREETEXT":
                    {
                        return true;
                    }

                case "WHERE":
                    {
                        return true;
                    }

                case "WITH":
                    {
                        return true;
                    }

                case "AS":
                    {
                        return true;
                    }

                case var @case when @case == "AS":
                    {
                        return true;
                    }

                case "INNER":
                    {
                        return true;
                    }

                case "JOIN":
                    {
                        return true;
                    }

                case "LEFT":
                    {
                        return true;
                    }

                case "RIGHT":
                    {
                        return true;
                    }

                case "OUTER":
                    {
                        return true;
                    }
            }

            return B;
        }

        public void ckFirstTokenKeyWord(ref string tStr)
        {
            try
            {
                string S = tStr;
                var A = Strings.Split(S, " ");
                if (Information.UBound(A) > 0)
                {
                    bool B = ckKeyWord(A[0]);
                    if (B)
                    {
                        S = "";
                        for (int i = 1, loopTo = Information.UBound(A); i <= loopTo; i++)
                            S += A[i] + " ";
                    }
                }

                tStr = S;
            }
            catch (Exception ex)
            {
                tStr = "";
                LogThis("clsDma : ckFirstTokenKeyWord : 910 : " + ex.Message);
                LogThis("clsDma : ckFirstTokenKeyWord : 934 : " + ex.Message);
                LogThis("clsDma : ckFirstTokenKeyWord : 951 : " + ex.Message);
            }
        }

        public bool getDebug(string FormID)
        {
            bool bUseConfig = true;
            string S = "";
            bool B = false;
            try
            {
                FormID = "debug_" + FormID;
                S = ConfigurationManager.AppSettings[FormID];
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
                else if (Strings.UCase(S).Equals("TRUE"))
                {
                    B = true;
                }
                else if (Strings.UCase(S).Equals("FALSE"))
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                B = false;
                LogThis("clsDma : getDebug : 928 : " + ex.Message);
                LogThis("clsDma : getDebug : 953 : " + ex.Message);
                LogThis("clsDma : getDebug : 971 : " + ex.Message);
            }

            return B;
        }

        public string getEnvironmentDir(string DirName)
        {
            // 0	Desktop			C:\Documents and Settings\Charlie\Desktop
            // 2	Programs		C:\Documents and Settings\Charlie\Start Menu\Programs
            // 5	Personal		D:\documents
            // 6	Favorites		C:\Documents and Settings\Charlie\Favorites
            // 8	Recent			C:\Documents and Settings\Charlie\Recent
            // 9	SendTo			C:\Documents and Settings\Charlie\SendTo
            // 11	StartMenu		C:\Documents and Settings\Charlie\Start Menu
            // 13	MyMusic			D:\documents\My Music
            // 16	DesktopDirectory	C:\Documents and Settings\Charlie\Desktop
            // 17:     MyComputer()
            // 26	ApplicationData		C:\Documents and Settings\Charlie\Application Data
            // 28	LocalApplicationData	C:\Documents and Settings\Charlie\Local Settings\Application Data
            // 32	InternetCache		C:\Documents and Settings\Charlie\Local Settings\Temporary Internet Files
            // 33	Cookies			C:\Documents and Settings\Charlie\Cookies
            // 34	History			C:\Documents and Settings\Charlie\Local Settings\History
            // 35	CommonApplicationData	C:\Documents and Settings\All Users\Application Data
            // 37	System			C:\WINDOWS\System32
            // 38	ProgramFiles		C:\Program Files
            // 39	MyPictures		D:\documents\My Pictures
            // 43	CommonProgramFiles	C:\Program FilesCommon Files

            string S = "";

            // Environment.SpecialFolder.ApplicationData()
            // Environment.SpecialFolder.System()
            // Environment.SpecialFolder.CommonApplicationData()
            // Environment.SpecialFolder.CommonProgramFiles()
            // Environment.SpecialFolder.Cookies()
            // Environment.SpecialFolder.Desktop()
            // Environment.SpecialFolder.DesktopDirectory()
            // Environment.SpecialFolder.Favorites()
            // Environment.SpecialFolder.History()
            // Environment.SpecialFolder.InternetCache()
            // Environment.SpecialFolder.LocalApplicationData()
            // Environment.SpecialFolder.MyComputer()
            // Environment.SpecialFolder.MyMusic()
            // Environment.SpecialFolder.MyPictures()
            // Environment.SpecialFolder.Personal()
            // Environment.SpecialFolder.ProgramFiles()
            // Environment.SpecialFolder.Programs()
            // Environment.SpecialFolder.Recent()
            // Environment.SpecialFolder.SendTo()
            // Environment.SpecialFolder.StartMenu()

            return S;
        }

        public string App_Path()
        {
            return AppDomain.CurrentDomain.BaseDirectory;
        }

        public string setHelpDir(string HelpFile)
        {
            string tDir = App_Path();
            tDir = tDir + @"HelpFiles\" + HelpFile;
            return tDir;
        }

        public bool isConnected()
        {
            bool bDebugConnection = false;
            bool B = false;
            // Returns True if connection is available Replace www.yoursite.com with a site that is
            // guaranteed to be online - perhaps your corporate site, or microsoft.com

            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 1.");
            var objUrl = new Uri("http://www.ecmlibrary.com/");
            // Setup WebRequest

            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 2.");
            WebRequest objWebReq;
            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 3.");
            objWebReq = WebRequest.Create(objUrl);
            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 4.");
            WebResponse objResp;
            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 5.");
            try
            {
                // Attempt to get response and return True
                if (bDebugConnection)
                    LogThis("clsDma: ECM Library Connection step 6.");
                objResp = objWebReq.GetResponse();
                if (bDebugConnection)
                    LogThis("clsDma: ECM Library Connection step 7.");
                objResp.Close();
                if (bDebugConnection)
                    LogThis("clsDma: ECM Library Connection step 8.");
                objWebReq = null;
                if (bDebugConnection)
                    LogThis("clsDma: ECM Library Connection step 9.");
                B = true;
            }
            catch (Exception ex)
            {
                // Error, exit and return False
                // objResp.Close()
                // objWebReq = Nothing
                B = false;
                if (bDebugConnection)
                    LogThis("clsDma: ECM Library Connection step 10.");
                LogThis("FAILED TO CONNECT clsDma : isConnected : 987 : " + ex.Message);
            }

            if (bDebugConnection)
                LogThis("clsDma: ECM Library Connection step 11.");
            return B;
        }

        // Public Sub SetSearchFields(ByVal txtSearch , ByVal txtThesaurus )
        // Try
        // frmQuickSearch.txtThesaurus.Text = txtThesaurus
        // frmQuickSearch.txtSearch.Text = txtSearch
        // Catch ex As Exception
        // Console.WriteLine(ex.Message)
        // End Try
        // Try
        // frmDocSearch.txtThesaurus.Text = txtThesaurus
        // frmDocSearch.txtSearch.Text = txtSearch
        // Catch ex As Exception
        // Console.WriteLine(ex.Message)
        // End Try
        // Try
        // frmEmailSearch.txtThesaurus.Text = txtThesaurus
        // frmEmailSearch.txtSearch.Text = txtSearch
        // Catch ex As Exception
        // Console.WriteLine(ex.Message)
        // End Try
        // End Sub

        // Only the first X bytes of the file are read into a byte array. BUFFERSIZE is X. A larger number
        // will use more memory and be slower. A smaller number may not be able to decode all JPEG files.
        // Feel free to play with this number.
        // 
        // CImageInfo
        // 
        // Author: David Crowell davidc@qtm.net http://www.qtm.net/~davidc
        // 
        // Released to the public domain use however you wish
        // 
        // CImageInfo will get the image type ,dimensions, and color depth from JPG, PNG, BMP, and GIF files.
        // 
        // version date: June 16, 1999
        // 
        // http://www.wotsit.org is a good source of file format information. This code would not have
        // been possible without the files I found there.

        // read-only properties

        // Public Function GetWidth() As Long
        // Return GraphicWidth
        // End Function
        // Public Function GetHeight() As Long
        // Return GraphicHeight
        // End Function
        // Public Function GetDepth() As Byte
        // Return graphicDepth
        // End Function
        // Public Function GetImageType() As eImageType
        // Return ImageType
        // End Function

        // Public Sub ReadImageInfo(ByVal sFileName As String)
        // ' This is the sub to call to retrieve information on a file.

        // ' Byte array buffer to store part of the file Dim bBuf(BUFFERSIZE) As Byte ' Open file number
        // Dim iFN As Integer

        // ' Set all properties to default values GraphicWidth = 0 GraphicHeight = 0 GraphicDepth = 0
        // ImageType = itUNKNOWN

        // ' here we will load the first part of a file into a byte
        // 'array the amount of the file stored here depends on
        // 'the BUFFERSIZE constant
        // iFN = FreeFile()
        // Open sFileName For Binary As iFN
        // Get #iFN, 1, bBuf()
        // Close(iFN)

        // If bBuf(0) = 137 And bBuf(1) = 80 And bBuf(2) = 78 Then ' this is a PNG file

        // m_ImageType = itPNG

        // ' get bit depth Select Case bBuf(25) Case 0 ' greyscale m_Depth = bBuf(24)

        // Case 2 ' RGB encoded m_Depth = bBuf(24) * 3

        // Case 3 ' Palette based, 8 bpp m_Depth = 8

        // Case 4 ' greyscale with alpha m_Depth = bBuf(24) * 2

        // Case 6 ' RGB encoded with alpha m_Depth = bBuf(24) * 4

        // Case Else ' This value is outside of it's normal range, so 'we'll assume ' that this is not a
        // valid file m_ImageType = itUNKNOWN

        // End Select

        // If m_ImageType Then ' if the image is valid then

        // ' get the width m_Width = Mult(bBuf(19), bBuf(18))

        // ' get the height m_Height = Mult(bBuf(23), bBuf(22)) End If

        // End If

        // If bBuf(0) = 71 And bBuf(1) = 73 And bBuf(2) = 70 Then ' this is a GIF file

        // m_ImageType = itGIF

        // ' get the width m_Width = Mult(bBuf(6), bBuf(7))

        // ' get the height m_Height = Mult(bBuf(8), bBuf(9))

        // ' get bit depth m_Depth = (bBuf(10) And 7) + 1 End If

        // If bBuf(0) = 66 And bBuf(1) = 77 Then ' this is a BMP file

        // m_ImageType = itBMP

        // ' get the width m_Width = Mult(bBuf(18), bBuf(19))

        // ' get the height m_Height = Mult(bBuf(22), bBuf(23))

        // ' get bit depth m_Depth = bBuf(28) End If

        // If m_ImageType = itUNKNOWN Then ' if the file is not one of the above type then ' check to see
        // if it is a JPEG file Dim lPos As Long

        // Do ' loop through looking for the byte sequence FF,D8,FF ' which marks the begining of a JPEG
        // file ' lPos will be left at the postion of the start If (bBuf(lPos) = &HFF And bBuf(lPos + 1) =
        // &HD8 _ And bBuf(lPos + 2) = &HFF) _ Or (lPos >= BUFFERSIZE - 10) Then Exit Do

        // ' move our pointer up lPos = lPos + 1

        // ' and continue Loop

        // lPos = lPos + 2 If lPos >= BUFFERSIZE - 10 Then Exit Sub

        // Do ' loop through the markers until we find the one 'starting with FF,C0 which is the block
        // containing the 'image information

        // Do ' loop until we find the beginning of the next marker If bBuf(lPos) = &HFF And bBuf(lPos +
        // 1) _ <> &HFF Then Exit Do lPos = lPos + 1 If lPos >= BUFFERSIZE - 10 Then Exit Sub Loop

        // ' move pointer up lPos = lPos + 1

        // Select Case bBuf(lPos) Case &HC0 To &HC3, &HC5 To &HC7, &HC9 To &HCB, _ &HCD To &HCF ' we found
        // the right block Exit Do End Select

        // ' otherwise keep looking lPos = lPos + Mult(bBuf(lPos + 2), bBuf(lPos + 1))

        // ' check for end of buffer If lPos >= BUFFERSIZE - 10 Then Exit Sub

        // Loop

        // ' If we've gotten this far it is a JPEG and we are ready ' to grab the information.

        // m_ImageType = itJPEG

        // ' get the height m_Height = Mult(bBuf(lPos + 5), bBuf(lPos + 4))

        // ' get the width m_Width = Mult(bBuf(lPos + 7), bBuf(lPos + 6))

        // ' get the color depth m_Depth = bBuf(lPos + 8) * 8

        // End If

        // End Sub
        // Private Function Mult(ByVal lsb As Byte, ByVal msb As Byte) As Long
        // Mult = lsb + (msb * CLng(256))
        // End Function

        public void SayWords(string Words)
        {
            if (modGlobals.gVoiceOn == false)
            {
                return;
            }
            /* TODO ERROR: Skipped IfDirectiveTrivia */
            var Voice = new SpeechSynthesizer();
            Voice.Rate = 0;
            Voice.Speak(Words);
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
        }

        public void ckFreetextSearchLine(ref TextBox SearchText)
        {
            string S = SearchText.Text.Trim();
            var A = S.Split(' ');
            for (int I = 0, loopTo = Information.UBound(A); I <= loopTo; I++)
            {
                string token = A[I];
                if (Strings.InStr(1, token, Conversions.ToString('"')) > 0)
                {
                    while (Strings.InStr(1, token, Conversions.ToString('"')) > 0)
                    {
                        int II = Strings.InStr(1, token, Conversions.ToString('"'));
                        StringType.MidStmtStr(ref token, II, 1, " ");
                    }
                }

                token = token.Trim();
                A[I] = token;
                if (Strings.UCase(token).Equals("AND"))
                {
                    A[I] = "";
                }
                else if (Strings.UCase(token).Equals("NOT"))
                {
                    A[I] = "";
                }
                else if (Strings.UCase(token).Equals("OR"))
                {
                    A[I] = "";
                }
            }

            S = "";
            for (int i = 0, loopTo1 = Information.UBound(A); i <= loopTo1; i++)
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
            // " FREETEXT ("
            // FREETEXT (EMAIL.*
            // freetext (subject,
            string S = SqlQuery.Trim();
            int I = 0;
            int J = 0;
            string Part1 = "";
            string Part2 = "";
            I = Strings.InStr(1, SqlQuery, LocatorPhrase, CompareMethod.Binary);
            if (I == 0)
            {
                return;
            }

            I = Strings.InStr(I + 2, SqlQuery, "'", CompareMethod.Binary);
            J = Strings.InStr(I + 1, SqlQuery, "'", CompareMethod.Binary);
            Part1 = Strings.Mid(SqlQuery, 1, I).Trim();
            Part2 = Strings.Mid(SqlQuery, J).Trim();

            // Clipboard.Clear()
            // Clipboard.SetText(Part1)

            string S2 = Strings.Mid(S, I + 1, J - I - 1).Trim();
            var A = S2.Split(' ');
            var loopTo = Information.UBound(A);
            for (I = 0; I <= loopTo; I++)
            {
                string token = A[I];
                // If InStr(1, token, Chr(34)) > 0 Then
                // Do While InStr(1, token, Chr(34)) > 0
                // Dim II As Integer = InStr(1, token, Chr(34))
                // Mid(token, II, 1) = " "
                // Loop
                // End If
                token = token.Trim();
                A[I] = token;
                if (Strings.UCase(token).Equals("OR"))
                {
                    A[I] = "";
                }
            }

            S = "";
            var loopTo1 = Information.UBound(A);
            for (I = 0; I <= loopTo1; I++)
            {
                if (A[I].Trim().Length > 0)
                {
                    S = S + A[I].Trim() + " ";
                }
            }

            S = S.Trim();
            S = Part1 + " " + S + " " + Part2;
            // Clipboard.Clear()
            // Clipboard.SetText(S)
            SqlQuery = S;
        }

        public bool SaveScreen(string theFile)
        {
            var Pic = new PictureBox();
            IDataObject data;
            data = Clipboard.GetDataObject();
            Bitmap bmap;
            if (data.GetDataPresent(typeof(Bitmap)))
            {
                bmap = (Bitmap)data.GetData(typeof(Bitmap));
                Pic.Image = bmap;
                Pic.Image.Save(theFile, System.Drawing.Imaging.ImageFormat.Jpeg);
            }

            return default;
        }

        public string getFileNameWithoutExtension(string FullPath)
        {
            return Path.GetFileNameWithoutExtension(FullPath);
        }

        public string getDirName(string FQN)
        {
            string dirName = Path.GetDirectoryName(FQN);
            return dirName;
        }

        public string getFileName(string FQN)
        {
            try
            {
                string dirName = Path.GetFileName(FQN);
                return dirName;
            }
            catch (Exception ex)
            {
                return FQN;
            }
        }

        public string getFullPath(string FQN)
        {
            string dirName = Path.GetFullPath(FQN);
            return dirName;
        }

        public string getFileExtension(string FQN)
        {
            string dirName = Path.GetExtension(FQN);
            return dirName;
        }

        /// <summary>
    /// This method starts at the specified directory, and traverses all subdirectories. It returns a
    /// List of those directories.
    /// </summary>
        public List<string> GetFilesRecursive(string initial)
        {
            // This list stores the results.
            var result = new List<string>();

            // This stack stores the directories to process.
            var stack = new Stack<string>();

            // Add the initial directory
            stack.Push(initial);

            // Continue processing for each stacked directory
            while (stack.Count > 0)
            {
                // Get top directory string
                string dir = stack.Pop();
                try
                {
                    // Add all immediate file paths

                    // Loop through all subdirectories and add them to the stack.
                    result.AddRange(Directory.GetFiles(dir, "*.*"));
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

        public bool GetSubDirs(string ParentDir, List<string> Result)
        {
            ParentDir = UTIL.ReplaceSingleQuotes(ParentDir);
            try
            {
                string MS = DateAndTime.Now.Millisecond.ToString();
                bool B = false;
                string TempDir = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
                string sCmd = "DIR " + ParentDir + @"\*.* /AD /S >" + TempDir + @"\ServiceManager.DirListing." + MS + ".txt";
                string OutputFileFQN = TempDir + @"\ServiceManager.DirListing." + MS + ".txt";
                string BatchFileName = TempDir + @"\ServiceManger.GetDirListing.bat";
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
                    LOG.WriteToArchiveLog("ERROR: GetSubDirs 200: " + Ex.Message);
                    return B;
                }

                My.MyProject.Forms.frmMain.SB2.Text = "Directory Inventory: " + DateAndTime.Now.ToString();
                var starter = new ProcessStartInfo(BatchFileName);
                var P = new Process();
                P.StartInfo = starter;
                P.Start();
                P.WaitForExit();
                int I = 0;
                while (!P.HasExited)
                {
                    I += 1;
                    System.Threading.Thread.Sleep(2000);
                    My.MyProject.Forms.frmMain.SB2.Text = "Directory Inventory:" + I.ToString() + " : " + DateAndTime.Now.ToString();
                    My.MyProject.Forms.frmMain.SB2.Refresh();
                    Application.DoEvents();
                }

                string sFileName = "";
                StreamReader srFileReader;
                string sInputLine;
                string DirToSave = "";
                File F;
                if (!File.Exists(OutputFileFQN))
                {
                    LOG.WriteToArchiveLog("ERROR - failed to create the Quick Directory List.");
                    return false;
                }

                F = null;
                sFileName = OutputFileFQN;
                srFileReader = File.OpenText(sFileName);
                sInputLine = srFileReader.ReadLine();
                while (!(sInputLine is null))
                {
                    DirToSave = "";
                    sInputLine = srFileReader.ReadLine();
                    if (sInputLine == null)
                    {
                        goto LoopOver;
                    }

                    sInputLine = sInputLine.Trim();
                    if (Conversions.ToBoolean(Strings.InStr(sInputLine, "Directory of", CompareMethod.Text)))
                    {
                        string T = Strings.Mid(sInputLine, 1, Strings.Len("Directory of"));
                        if (T.ToUpper().Equals("DIRECTORY OF"))
                        {
                            DirToSave = Strings.Mid(sInputLine, Strings.Len("Directory of") + 1);
                            DirToSave = DirToSave.Trim();
                            if (Result.Contains(DirToSave))
                            {
                            }
                            else
                            {
                                if (DirToSave.Trim().Length > 254)
                                {
                                    DirToSave = modGlobals.getShortDirName(DirToSave);
                                }

                                Result.Add(DirToSave);
                            }
                        }
                    }

                    LoopOver:
                    ;
                }

                srFileReader.Close();
                srFileReader = null;
                File F2;
                if (File.Exists(OutputFileFQN))
                {
                    File.Delete(OutputFileFQN);
                }

                F2 = null;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR GetSubDirs - 100.23.1 - " + ex.Message);
                return false;
            }

            return true;
        }

        public List<string> GetDirsRecursive(string initial)
        {
            // This list stores the results.
            var result = new List<string>();
            initial = UTIL.ReplaceSingleQuotes(initial);

            // This stack stores the directories to process.
            var stack = new Stack<string>();

            // Add the initial directory
            stack.Push(initial);

            // Continue processing for each stacked directory
            while (stack.Count > 0)
            {
                // Get top directory string
                string dir = stack.Pop();
                if (result.Contains(dir))
                {
                }
                else
                {
                    result.Add(dir);
                }

                IXV1 += 1;
                // 'FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
                Application.DoEvents();
                // Add all immediate file paths
                // result.AddRange(Directory.GetFiles(dir, "*.*"))
                // Loop through all subdirectories and add them to the stack.
                try
                {
                    My.MyProject.Forms.frmMain.SB2.Text = dir;
                    My.MyProject.Forms.frmMain.SB2.Refresh();
                    Application.DoEvents();
                    int iDirCnt = Directory.GetDirectories(dir).Count();
                    if (iDirCnt > 0)
                    {
                        foreach (var directoryName in Directory.GetDirectories(dir))
                        {
                            IXV1 += 1;
                            // 'FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
                            Application.DoEvents();
                            stack.Push(directoryName);
                            if (result.Contains(dir))
                            {
                            }
                            else
                            {
                                result.Add(directoryName);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }

            // Return the list
            return result;
        }

        public void GetAllDirs(string DirFqn, ref List<string> result)
        {
            var Root = new DirectoryInfo(DirFqn);
            var Files = Root.GetFiles("*.*");
            var Dirs = Root.GetDirectories("*.*");
            Console.WriteLine("Root Directories");
            foreach (var DirectoryName in Dirs)
            {
                try
                {
                    Console.Write(DirectoryName.FullName);
                    // Console.Write(" contains {0} files ", DirectoryName.GetFiles().Length)
                    // Console.WriteLine(" and {0} subdirectories ", DirectoryName.GetDirectories().Length)

                    My.MyProject.Forms.frmMain.SB2.Text = DirectoryName.FullName;
                    My.MyProject.Forms.frmMain.SB2.Refresh();
                    Application.DoEvents();
                    if (DirectoryName.GetDirectories().Length > 0)
                    {
                        object A = DirectoryName.GetDirectories("*.*");
                        foreach (string DirName in (IEnumerable)A)
                            GetAllDirs(DirFqn, ref result);
                    }

                    if (result.Contains(DirectoryName.FullName))
                    {
                    }
                    else
                    {
                        result.Add(DirectoryName.FullName);
                    }
                }
                catch (Exception E)
                {
                    Console.WriteLine("Error accessing");
                }
            }
        }

        public void GetFilesRecursive(string initial, List<string> List)
        {
            // This list stores the results.
            var result = new List<string>();

            // This stack stores the directories to process.
            var stack = new Stack<string>();

            // Add the initial directory
            stack.Push(initial);

            // Continue processing for each stacked directory
            while (stack.Count > 0)
            {
                // Get top directory string
                string dir = stack.Pop();
                try
                {
                    // Add all immediate file paths

                    // Loop through all subdirectories and add them to the stack.
                    result.AddRange(Directory.GetFiles(dir, "*.*"));
                    foreach (var directoryName in Directory.GetDirectories(dir))
                        stack.Push(directoryName);
                }
                catch (Exception ex)
                {
                }
            }

            // Return the list
            CombineLists(ref List, ref result);
        }

        public void CombineLists(ref List<string> ParentList, ref List<string> ChildList)
        {
            int I = 0;
            var loopTo = ChildList.Count - 1;
            for (I = 0; I <= loopTo; I++)
            {
                string S = ChildList[I];
                ParentList.Add(S);
            }

            ChildList.Clear();
        }

        public void FixFileExtension(ref string Extension)
        {
            Extension = Extension.Trim();
            Extension = Extension.ToLower();
            if (Strings.InStr(1, Extension, ".") == 0)
            {
                Extension = "." + Extension;
            }

            while (Strings.InStr(1, Extension, ",") > 0)
                StringType.MidStmtStr(ref Extension, Strings.InStr(1, Extension, ","), 1, ".");
            return;
        }

        public bool isExtIncluded(string fExt, ArrayList IncludedTypes)
        {
            fExt = Strings.UCase(fExt);
            if (fExt.Length > 1)
            {
                fExt = Strings.UCase(fExt);
                if (Strings.Mid(fExt, 1, 1) == ".")
                {
                    StringType.MidStmtStr(ref fExt, 1, 1, " ");
                    fExt = fExt.Trim();
                }
            }

            // Dim B As Boolean = False
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
            fExt = Strings.UCase(fExt);
            if (fExt.Length > 1)
            {
                fExt = Strings.UCase(fExt);
                if (Strings.Mid(fExt, 1, 1) == ".")
                {
                    StringType.MidStmtStr(ref fExt, 1, 1, " ");
                    fExt = fExt.Trim();
                }
            }

            // Dim B As Boolean = False

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
            // ** Find the starting point of the order by and start the comment there
            int X = 0;
            X = Strings.InStr(S, "order by", CompareMethod.Text);
            string S1 = Strings.Mid(S, 1, X - 1);
            string S2 = Strings.Mid(S, X);
            string S3 = S1 + Constants.vbCrLf + "  /* " + S2 + "  */";
            S = S3;
            return S;
        }

        public bool CreateMissingDir(string DirFQN)
        {
            bool B = false;
            Directory D;
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
                LogThis("ERROR 76.54.32 - Could not create restore directory. " + Constants.vbCrLf + ex.Message);
                MessageBox.Show("ERROR 76.54.32 - Could not create restore directory. " + Constants.vbCrLf + Constants.vbCrLf + "Please verify that you have authority to create this directory." + ex.Message);
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
            }
            // Return strContents
            catch (Exception Ex)
            {
                MessageBox.Show("Failed to load License file: " + Constants.vbCrLf + Ex.Message);
                LogThis("clsDatabaseARCH : LoadLicenseFile : 5914 : " + Ex.Message);
                return Conversions.ToString(false);
            }

            return strContents;
        }

        public void LogThis(string MSG)
        {
            var LOG = new clsLogging();
            LOG.WriteToArchiveLog(MSG);
            LOG = null;
        }

        public string ReadFile(string fName)
        {
            var SR = new StreamReader(fName);
            string FullText = "";
            while (!SR.EndOfStream)
            {
                string S = SR.ReadLine();
                FullText = FullText + S + Constants.vbCrLf;
            }

            SR.Close();
            return FullText;
        }

        public void WriteFile(string FQN, string sText)
        {
            try
            {
                var SW = new StreamWriter(FQN);
                string S = sText.Trim();
                if (S.Length > 0)
                {
                    SW.WriteLine(S);
                }

                SW.Close();
            }
            catch (Exception ex)
            {
                LogThis("clsDMa:WriteFile - " + ex.Message);
            }
        }

        public void ModifyAppConfig(string ServerName, string ItemToModify)
        {
            string AppConfigBody = "";
            string aPath = App_Path();
            string AppName = aPath + "EcmArchiveSetup.exe.config";
            File F;
            if (File.Exists(AppName))
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
            My.MySettingsProperty.Settings["UserDefaultConnString"] = "?";
            My.MySettingsProperty.Settings.Save();
            string S = ConfigurationManager.AppSettings["ECMREPO"];

            // *****************************************************************************
            string Str1 = "";
            string Str2 = "";
            string NewStr = ServerName;
            int NumberOfCycles = 0;
            int I = 1;
            while (Strings.InStr(I, S, "Data Source=", CompareMethod.Text) > 0)
            {
                I = Strings.InStr(I, S, "Data Source=", CompareMethod.Text);
                I = Strings.InStr(I + 1, S, "=", CompareMethod.Text);
                int J = Strings.InStr(I + 1, S, ";", CompareMethod.Text);
                Str1 = Strings.Mid(S, 1, I);
                Str2 = Strings.Mid(S, J);
                S = Str1 + sCurr + Str2;
                NumberOfCycles += 1;
                if (NumberOfCycles > 50)
                {
                    break;
                }

                I = J + 1;
            }
            // *****************************************************************************

            UTIL.setConnectionStringTimeout(ref S);
            // S = ENC.AES256DecryptString(S)

            My.MySettingsProperty.Settings.Reload();
            Console.WriteLine(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            My.MySettingsProperty.Settings["UserDefaultConnString"] = S;
            Console.WriteLine(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            My.MySettingsProperty.Settings.Save();
        }

        public void SetThesaurusConnectionStringToConfig(string ServerName)
        {
            string sCurr = ServerName;
            My.MySettingsProperty.Settings["UserThesaurusConnString"] = "?";
            My.MySettingsProperty.Settings.Save();
            string S = modGlobals.setThesaurusConnStr();

            // *****************************************************************************
            string Str1 = "";
            string Str2 = "";
            string NewStr = ServerName;
            int NumberOfCycles = 0;
            int I = 1;
            while (Strings.InStr(I, S, "Data Source=", CompareMethod.Text) > 0)
            {
                I = Strings.InStr(I, S, "Data Source=", CompareMethod.Text);
                I = Strings.InStr(I + 1, S, "=", CompareMethod.Text);
                int J = Strings.InStr(I + 1, S, ";", CompareMethod.Text);
                Str1 = Strings.Mid(S, 1, I);
                Str2 = Strings.Mid(S, J);
                S = Str1 + sCurr + Str2;
                NumberOfCycles += 1;
                if (NumberOfCycles > 50)
                {
                    break;
                }

                I = J + 1;
            }
            // *****************************************************************************

            UTIL.setConnectionStringTimeout(ref S);
            // S = ENC.AES256DecryptString(S)

            My.MySettingsProperty.Settings.Reload();
            Console.WriteLine(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            My.MySettingsProperty.Settings["UserThesaurusConnString"] = S;
            Console.WriteLine(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            My.MySettingsProperty.Settings.Save();
        }

        public void ApplyAppConfigChange(string ServerName, string ItemToModify, ref string AppConFigBody)
        {
            if (ServerName.Trim().Length == 0)
            {
                return;
            }

            string AppText = AppConFigBody;
            string Str1 = "";
            string Str2 = "";
            string NewStr = ServerName;
            int NumberOfCycles = 0;
            int I = 1;
            while (Strings.InStr(I, AppText, "Data Source=", CompareMethod.Text) > 0)
            {
                I = Strings.InStr(I, AppText, "Data Source=", CompareMethod.Text);
                I = Strings.InStr(I + 1, AppText, "=", CompareMethod.Text);
                int J = Strings.InStr(I + 1, AppText, ";", CompareMethod.Text);
                Str1 = Strings.Mid(AppText, 1, I);
                // messagebox.show(Str1)
                Str2 = Strings.Mid(AppText, J);
                // messagebox.show(Str2)
                AppText = Str1 + ServerName + Str2;
                // messagebox.show(AppText)
                NumberOfCycles += 1;
                if (NumberOfCycles > 50)
                {
                    break;
                }

                I = J + 1;
                // Clipboard.Clear()
                // Clipboard.SetText(AppText)
            }

            AppConFigBody = AppText;
        }

        public void deleteDirectoryFiles(string DirFQN)
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
                        LOG.WriteToArchiveLog("ERROR 100A clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.");
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 200A :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.");
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
                var di = new DirectoryInfo(DirName);
                var aryFi = di.GetFiles("*.*");
                try
                {
                    foreach (var fi in aryFi)
                    {
                        strFileSize = Math.Round(fi.Length / 1024d).ToString();
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

                        I = I + 1;
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("Error 22012: " + ex.Message);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Error 22013: " + ex.Message);
            }

            return I;
        }

        /* TODO ERROR: Skipped RegionDirectiveTrivia */
        private bool disposedValue; // To detect redundant calls

        // IDisposable
        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    // TODO: dispose managed state (managed objects).
                    currDomain.UnhandledException -= modGlobals.MYExnHandler;
                    Application.ThreadException -= modGlobals.MYThreadHandler;
                }

                // TODO: free unmanaged resources (unmanaged objects) and override Finalize() below.
                // TODO: set large fields to null.
            }

            disposedValue = true;
        }

        // TODO: override Finalize() only if Dispose(disposing As Boolean) above has code to free unmanaged resources.
        // Protected Overrides Sub Finalize()
        // ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
        // Dispose(False)
        // MyBase.Finalize()
        // End Sub

        // This code added by Visual Basic to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
            Dispose(true);
            // TODO: uncomment the following line if Finalize() is overridden above.
            // GC.SuppressFinalize(Me)
        }
        /* TODO ERROR: Skipped EndRegionDirectiveTrivia */
    }
}
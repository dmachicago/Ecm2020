'clsDma: A set of standard utilities to perofrm repetitive tasks through a public class
'Copyright @DMA, Limited, Chicago, IL., June 2003, all rights reserved.
'Licensed on a use only basis for clients of DMA, Limited.
#Const Offfice2007 = 1
#Const GetAllWidgets = 0

Imports Microsoft.VisualBasic
Imports Microsoft.Win32

'Imports VB = Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Net.Dns
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Security.Permissions
Imports System.Net
Imports System.Net.Sockets
Imports System.Text.RegularExpressions
Imports System.Text
Imports System.Data.Sql
Imports Microsoft.SqlServer

Imports System.Speech
Imports System.Speech.Synthesis

Imports Microsoft.SqlServer.Management.Smo
Imports Microsoft.SqlServer.Management.Common
Imports Microsoft.SqlServer.Management.Smo.Agent

Public Class clsDma : Implements IDisposable

    Const MUST_BE_LESS_THAN As Integer = 100000000 '8 decimal digits
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging
    Public IXV1 As Integer = 0
    'Dim DFLT As New clsDefaults

    'Dim owner As IWin32Window
    Private Const BUFFERSIZE As Long = 65535

    Dim GraphicWidth As Long = 0
    Dim GraphicHeight As Long = 0
    Dim GraphicDepth As Long = 0

    ' image type enum
    Private Declare Function URLDownloadToFile Lib "urlmon" _
        Alias "URLDownloadToFileA" (ByVal pCaller As Long,
        ByVal szURL As String, ByVal szFileName As String,
        ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

    Dim ddebug As Boolean = False
    Dim bb As Boolean = False
    Public TempEnvironDir As String = getEnvVarTempDir()
    Private CurrHostName As String = ""
    Private MachineIP As String = ""

    Dim myIPAddress, MacAddr, x As Net.IPAddress
    Dim myIPHostEntry As New Net.IPHostEntry()

    'Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

    Dim oReg As Microsoft.Win32.Registry
    Dim oRegKey As Microsoft.Win32.RegistryKey

    Public RetC As Boolean
    Dim currDomain As AppDomain = AppDomain.CurrentDomain

    Sub New()
        AddHandler currDomain.UnhandledException, AddressOf MYExnHandler
        AddHandler Application.ThreadException, AddressOf MYThreadHandler
    End Sub

    Public Sub WildCardCharValidate(ByRef StringToEval As String)

        Dim S As String = StringToEval.Trim
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim CH As String = ""

        For I = 0 To S.Length
            CH = Mid(S, I, 1)
            If CH = Chr(34) Then
                I = I + 1
                CH = Mid(S, I, 1)
                Do While CH <> Chr(34) And I <= S.Length
                    CH = Mid(S, I, 1)
                    I = I + 1
                Loop
            ElseIf CH = "*" Then
                Mid(S, I, 1) = "%"
            End If
        Next I

    End Sub

    Public Sub getSubDirs(ByRef Dirs As String(), ByVal TargetDir As String)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        ReDim Dirs(0)
        'ReDim Files (0)
        Dim path As String = TargetDir
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                Dirs = Directory.GetDirectories(path)
                'Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine(ex.Source)
            If ddebug Then Console.WriteLine(ex.StackTrace)
            If ddebug Then Console.WriteLine(ex.Message)

            LogThis("clsDma : getSubDirs : 27 : " + ex.Message)
            LogThis("clsDma : getSubDirs : 28 : " + ex.Message)
            LogThis("clsDma : getSubDirs : 29 : " + ex.Message)

        End Try
    End Sub

    Public Sub getDirFiles(ByRef Files As String(), ByVal TargetDir As String)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        'ReDim Dirs (0)
        ReDim Files(0)
        Dim path As String = TargetDir
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                'Dirs = Directory.GetDirectories(path)
                Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            LogThis("clsDma : getDirFiles : 37 : " + ex.Message)
        End Try
    End Sub

    Public Function ckVar2(ByRef tVal As String) As String
        If tVal = "&nbsp;" Then
            tVal = ""
        End If
        Return tVal
    End Function

    Public Sub ListDirs(ByRef Dirs As String(), ByRef Files As String(), ByVal TargetDir As String)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        ReDim Dirs(0)
        ReDim Files(0)
        Dim path As String = TargetDir
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                Dirs = Directory.GetDirectories(path)
                Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine(ex.Source)
            If ddebug Then Console.WriteLine(ex.StackTrace)
            If ddebug Then Console.WriteLine(ex.Message)
            LogThis("clsDma : ListDirs : 52 : " + ex.Message)
            LogThis("clsDma : ListDirs : 55 : " + ex.Message)
            LogThis("clsDma : ListDirs : 58 : " + ex.Message)
        End Try
    End Sub

    Public Function DownloadWebFile(ByVal WebFqn As String, ByVal ToFqn As String) As Boolean
        Dim B As Boolean = False
        WebFqn = "http://www.vb-helper.com/vbhelper_425_64.gif"
        ToFqn = gTempDir + "\vbhelper_425_64.gif"

        Try
            URLDownloadToFile(0, WebFqn, ToFqn, 0, 0)
            B = True
        Catch ex As Exception
            B = False
            LogThis("clsDma : DownloadWebFile : 59 : " + ex.Message)
            LogThis("clsDma : DownloadWebFile : 63 : " + ex.Message)
            LogThis("clsDma : DownloadWebFile : 67 : " + ex.Message)
        End Try
        Return B
    End Function

    Public Sub setHostName()
        Dim shostname As String = ""
        shostname = System.Net.Dns.GetHostName
        If ddebug Then Console.WriteLine("Your Machine Name = " & shostname)
        CurrHostName = shostname
    End Sub

    Public Function getHostname() As String
        If CurrHostName = "" Then
            setHostName()
        End If
        Return CurrHostName
    End Function

    Public Sub setIPAddr()

        Dim s As String = ""
        Dim dd As Boolean = False
        Dim server As String
        server = System.Net.Dns.GetHostName

        Try
            Dim ASCII As New System.Text.ASCIIEncoding()

            ' Get server related information.
            Dim heserver As IPHostEntry = Dns.GetHostEntry(server)

            ' Loop on the AddressList
            Dim curAdd As IPAddress
            For Each curAdd In heserver.AddressList

                ' Display the type of address family supported by the server. If the
                ' server is IPv6-enabled this value is: InternNetworkV6. If the server
                ' is also IPv4-enabled there will be an additional value of InterNetwork.
                '** Console.WriteLine(("AddressFamily: " + curAdd.AddressFamily.ToString()))
                s = "AddressFamily: " & curAdd.AddressFamily.ToString()
                If ddebug Then Console.WriteLine(s)

                ' Display the ScopeId property in case of IPV6 addresses.
                If curAdd.AddressFamily.ToString() = ProtocolFamily.InterNetworkV6.ToString() Then
                    s = "Scope Id: " + curAdd.ScopeId.ToString()
                    If ddebug Then
                        If ddebug Then Console.WriteLine(s)
                    End If
                End If

                ' Display the server IP address in the standard format. In IPv4 the format will be
                ' dotted-quad notation, in IPv6 it will be in in colon-hexadecimal notation.
                s = "Address: " + curAdd.ToString()
                s = curAdd.ToString()
                Console.WriteLine(s)
                If isFourPartIP(s) Then
                    MachineIP = s
                    Exit For
                End If
                ' Display the server IP address in byte format.
                'Console.Write("AddressBytes: ")
                's = ""
                'Dim bytes As [Byte]() = curAdd.GetAddressBytes()
                'Dim i As Integer
                'For i = 0 To bytes.Length - 1
                '    Console.Write(bytes(i))
                '    s = s + bytes(i).ToString
                'Next i
                'Console.WriteLine(ControlChars.Cr + ControlChars.Lf)
                'Console.WriteLine(s)
            Next curAdd
        Catch e As Exception
            If ddebug Then Console.WriteLine(("[DoResolve] Exception: " + e.ToString()))
            LogThis("clsDma : setIPAddr : 87 : " + e.Message)
            LogThis("clsDma : setIPAddr : 92 : " + e.Message)
            LogThis("clsDma : setIPAddr : 97 : " + e.Message)
        End Try

        MachineIP = s

    End Sub

    Function isFourPartIP(ByVal IP As String) As Boolean
        If InStr(IP, ":") > 0 Then
            Return False
        End If
        Dim A As String() = IP.Split(".")
        If A.Length = 4 Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function getIpAddr() As String
        If MachineIP = "" Then
            setIPAddr()
        End If
        Return MachineIP
    End Function

    Public Function getEnvVarTempDir() As String
        Dim td As String = ""

        Try
            td = Environ("TEMP")
            TempEnvironDir = td
        Catch ex As Exception
            td = ""
            If ddebug Then Console.WriteLine(ex.Message)
        End Try

        Return td
    End Function

    Public Function LoadGraphic(ByVal filePath As String) As Byte()
        Dim stream As FileStream = New FileStream(filePath, FileMode.Open, FileAccess.Read)
        Dim reader As BinaryReader = New BinaryReader(stream)
        Dim photo() As Byte = reader.ReadBytes(stream.Length)

        reader.Close()
        stream.Close()

        Return photo
    End Function

    Public Function CheckFileName(ByVal tVal As String) As String
        Dim i As Integer = Len(tVal)
        Dim j As Integer = 0
        Dim CH As String = ""

        For i = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            If CH.Equals("/") Then
                Mid(tVal, i, 1) = "."
            ElseIf CH.Equals(":") Then
                Mid(tVal, i, 1) = "."
            End If
        Next

        For i = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            'j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz.-@ :", CH, CompareMethod.Text)
            j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz-@ .", CH, CompareMethod.Text)
            If j = 0 Then
                tVal = RemoveChar(tVal, CH)
            End If
        Next

        Return tVal

    End Function

    Public Function RemoveChar(ByVal tVal As String, ByVal CharToRemove As String) As String
        Dim i As Integer = Len(tVal)
        Dim A As String()
        Dim S As String = ""
        A = tVal.Split(CharToRemove)
        For i = 0 To UBound(A)
            Dim Token As String = A(i).ToString
            If Token.Length > 0 Then
                S = S + A(i)
            End If
        Next
        If S.Length > 0 Then
            Return S
        Else
            Return tVal
        End If

    End Function

    Public Function ReplaceCommas(ByVal tVal As String) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "^" Then
                Mid(tVal, i, 1) = ","
            End If
        Next
        Return tVal
    End Function

    Public Function ReplaceChar(ByVal InputString As String, ByVal CharToReplace As String, ByVal ReplaceWith As String) As String
        Dim i As Integer = Len(InputString)
        Dim ch As String = ""
        For i = 1 To Len(InputString)
            ch = Mid(InputString, i, 1)
            If ch.Equals(CharToReplace) Then
                Mid(InputString, i, 1) = ReplaceWith
            End If
        Next
        Return InputString
    End Function

    'Public Function GetFileName(ByVal FQN ) As String
    '    Dim fn  = ""

    ' Dim i# = 0 Dim j# = 0 Dim ch = "" For i = Len(FQN) To 1 Step -1 ch = Mid(FQN, i, 1) If ch = "\"
    ' Then fn = Mid(FQN, i + 1) Exit For End If If ch = "/" Then fn = Mid(FQN, i + 1) Exit For End If
    ' Next If fn = "" And FQN.Length > 0 Then Return FQN Else Return fn End If

    'End Function

    Public Function GetFilePath(ByVal FQN As String) As String

        Dim fn As String = ""

        Try

            Dim i# = 0
            Dim j# = 0
            Dim ch As String = ""
            For i = Len(FQN) To 1 Step -1
                ch = Mid(FQN, i, 1)
                If ch = "\" Then
                    fn = Mid(FQN, 1, i - 1)
                    Exit For
                End If
                If ch = "/" Then
                    fn = Mid(FQN, 1, i - 1)
                    Exit For
                End If
            Next
            If fn.Length = 0 Then
                Return FQN
            Else
                Return fn
            End If
        Catch ex As Exception
            fn = ""
            LOG.WriteToArchiveLog("(ERROR clsDma:GetFilePath: COuld not get file path - " + ex.Message + Environment.NewLine + ex.StackTrace)
            Return fn
        End Try

    End Function

    Public Sub tWait(ByVal tDelay#)
        Dim start As Double = 0
        Dim finish As Double = 0
        Dim totalTime As Double = 0

        start = Microsoft.VisualBasic.DateAndTime.Timer
        ' Set end time for 1/5-second duration.
        Dim mSduration As Double = tDelay / 1000
        finish = start + mSduration
        Do While Microsoft.VisualBasic.DateAndTime.Timer < finish
            ' Do other processing while waiting for 5 seconds to elapse.
        Loop
        totalTime = Microsoft.VisualBasic.DateAndTime.Timer - start

    End Sub

    Public Function FileExist(ByVal fqn As String) As Boolean
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
        Dim MyFile As String
        If Len(Trim(fqn)) = 0 Then
            FileExist = False
            Exit Function
        End If
        MyFile = fqn
        MyFile = Dir(MyFile)
        If Len(Trim(MyFile)) > 0 Then
            FileExist = True
        Else
            FileExist = False
        End If
        Exit Function

FERR:
        On Error GoTo 0
        FileExist = False
    End Function

    Public Function getHelpFile() As String
        Dim URL As String
        URL = "WDM URL.hlp"
        '**WDM getHelpFile = App.Path & App.EXEName & ".HLP"
        getHelpFile = URL
    End Function

    '** Gets and returns a registry value for the current UserID
    Public Function CapiInterface(ByVal Key1 As String, ByVal Key2 As String) As String

        Dim s As String = ""
        Dim rkCurrentUser As RegistryKey = Registry.CurrentUser
        Dim rkTest As RegistryKey = rkCurrentUser.OpenSubKey(Key1 + ":" + Key2)

        If rkTest Is Nothing Then
            s = ""
        Else
            s = rkTest.GetValue(Key1 + ":" + Key2)
            rkTest.Close()
            rkCurrentUser.Close()
        End If

        Return s

    End Function

    '** Sets a registry value for the current UserID
    Public Function CApiSetLocalIniValue(ByVal Key1 As String, ByVal Key2 As String, ByVal SuppliedVal As String) As String
        Dim RegistryKey As String = Key1 + ":" + Key2
        'RegistryKey = Key1 + ":" + Key2
        Dim rkTest As RegistryKey = Registry.CurrentUser.OpenSubKey("RegistryOpenSubKeyExample", True)
        If rkTest Is Nothing Then
            Dim rk As RegistryKey = Registry.CurrentUser.CreateSubKey("RegistryOpenSubKeyExample")
            rk.Close()
        Else
            rkTest.SetValue(RegistryKey, SuppliedVal)
            ' Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
            rkTest.Close()
        End If
        Return SuppliedVal
    End Function

    ' Modify a phone-number to the format "XXX-XXXX" or "(XXX) XXX-XXXX".
    Function xFormatPhoneNumber(ByVal text As String) As String
        Dim i As Long
        ' ignore empty strings
        If Len(text) = 0 Then
            Return ""
        End If
        ' get rid of dashes and invalid chars
        For i = Len(text) To 1 Step -1
            If InStr("0123456789", Mid(text, i, 1)) = 0 Then
                text = Mid(text, 1, i - 1) & Mid(text, i + 1)
            End If
        Next
        ' then, re-insert them in the correct position
        If Len(text) <= 7 Then
            Return Format(text, "!@@@-@@@@")
        Else
            Return Format(text, "!(@@@) @@@-@@@@")
        End If
    End Function

    Public Sub GetIPAddress()
        'This sub will get all IP addresses, the first one should be the adapters MAC
        'address, the second one the IP Address when connected to the internet.

        Dim myIPAddress, MacAddr, x As Net.IPAddress
        Dim myIPHostEntry As New Net.IPHostEntry()
        myIPHostEntry = Net.Dns.GetHostEntry(Net.Dns.GetHostName())
        Dim i As Integer = 0
        myIPAddress = Nothing
        MacAddr = Nothing
        For Each x In myIPHostEntry.AddressList
            'i = i + 1
            'If i = 1 Then
            '    MacAddr = x.ToString()
            'End If
            'If i = 2 Then
            '    myIPAddress = x.ToString()
            'End If
            'ShowMsg(owner, x.ToString())
        Next
    End Sub

    Public Function ckVar(ByRef sText As String) As String
        Dim i As Integer = 0
        Dim j As Integer = 0
        If sText = "&nbsp;" Then
            sText = ""
            Return sText
        End If

        sText = ReplaceOccr(sText, "&gt", "<")
        sText = ReplaceOccr(sText, "&Lt", ">")
        sText = ReplaceOccr(sText, "&nbsp;", " ")

        sText = UTIL.RemoveSingleQuotes(sText)

        Return sText
    End Function

    Private Function ReplaceOccr(ByVal tStr As String, ByVal TgtStr As String, ByVal ReplacementStr As String) As String
        Dim S1 As String = ""
        Dim S2 As String = ""
        Dim L As Integer = Len(TgtStr)
        Dim I As Integer = 0

        Do While InStr(tStr, TgtStr, CompareMethod.Text) > 0
            I = InStr(tStr, TgtStr, CompareMethod.Text)
            S1 = Mid(tStr, 1, I - 1)
            S2 = Mid(tStr, I + L)
            tStr = S1 + S2
        Loop

        Return tStr
    End Function

    Public Function SaveFile(ByVal sFileName As String,
           ByVal bytFileByteArr As Byte()) As Integer

        ' Saves a file with no file extension

        ' Get the file name and set a new path to the local storage folder
        Dim strFile As String =
        System.IO.Path.GetFileNameWithoutExtension(sFileName)

        'Dim GL As New clsGlobals
        'strFile = System.Web.Hosting.HostingEnvironment.MapPath(GL.getServerStroragePath(strFile))

        'write the file out to the storage location
        Try

            Dim stream As New FileStream(strFile, FileMode.CreateNew)
            stream.Write(bytFileByteArr, 0, bytFileByteArr.Length)
            stream.Close()
            Return 0
        Catch ex As Exception

            LogThis("clsDma :  : 308 : " + ex.Message)
            LogThis("clsDma :  : 313 : " + ex.Message)
            LogThis("clsDma :  : 318 : " + ex.Message)
            LogThis("clsDma :  : 959 : " + ex.Message)
            Return 1

        End Try

    End Function

    Function GetMimeType(ByVal FileSuffix As String) As String
        Dim MimeTypes As String = "application/andrew-inset | ez,application/mac-binhex40 | hqx,application/mac-compactpro | cpt,application/msword | doc,application/octet-stream | bin,application/octet-stream | dms,application/octet-stream | lha,application/octet-stream | lzh,application/octet-stream | exe,application/x-rar-compressed | rar,application/octet-stream | class,application/octet-stream | so,application/octet-stream | dll,application/oda | oda,application/pdf | pdf,application/postscript | ai,application/postscript | eps,application/postscript | ps,application/smil | smi,application/smil | smil,application/vnd.mif | mif,application/vnd.ms-excel | xls,application/vnd.ms-powerpoint | ppt,application/vnd.wap.wbxml | wbxml,application/vnd.wap.wmlc | wmlc,application/vnd.wap.wmlscriptc | wmlsc,application/x-bcpio | bcpio,application/x-cdlink | vcd,application/x-chess-pgn | pgn,application/x-cpio | cpio,application/x-csh | csh,application/x-director | dcr,application/x-director | dir,application/x-director | dxr,application/x-dvi | dvi,application/x-futuresplash | spl,application/x-gtar | gtar,application/x-hdf | hdf,application/x-javascript | js,application/x-koan | skp,application/x-koan | skd,application/x-koan | skt,application/x-koan | skm,application/x-latex | latex,application/x-netcdf | nc,application/x-netcdf | cdf,application/x-sh | sh,application/x-shar | shar,application/x-shockwave-flash | swf,application/x-stuffit | sit,application/x-sv4cpio | sv4cpio,application/x-sv4crc | sv4crc,application/x-tar | tar,application/x-tcl | tcl,application/x-tex | tex,application/x-texinfo | texinfo,application/x-texinfo | texi,application/x-troff | t,application/x-troff | tr,application/x-troff | roff,application/x-troff-man | man,application/x-troff-me | me,application/x-troff-ms | ms,application/x-ustar | ustar,application/x-wais-source | src,application/xhtml+xml | xhtml,application/xhtml+xml | xht,application/zip | zip,audio/basic | au,audio/basic | snd,audio/midi | mid,audio/midi | midi,audio/midi | kar,audio/mpeg | mpga,audio/mpeg | mp2,audio/mpeg | mp3,audio/x-aiff | aif,audio/x-aiff | aiff,audio/x-aiff | aifc,audio/x-mpegurl | m3u,audio/x-pn-realaudio | ram,audio/x-pn-realaudio | rm,audio/x-pn-realaudio-plugin | rpm,audio/x-realaudio | ra,audio/x-wav | wav,chemical/x-pdb | pdb,chemical/x-xyz | xyz,image/bmp | bmp,image/gif | gif,image/ief | ief,image/jpeg | jpeg,image/jpeg | jpg,image/jpeg | jpe,image/png | png,image/tiff | tiff,image/tiff | tif,image/vnd.djvu | djvu,image/vnd.djvu | djv,image/vnd.wap.wbmp | wbmp,image/x-cmu-raster | ras,image/x-portable-anymap | pnm,image/x-portable-bitmap | pbm,image/x-portable-graymap | pgm,image/x-portable-pixmap | ppm,image/x-rgb | rgb,image/x-xbitmap | xbm,image/x-xpixmap | xpm,image/x-xwindowdump | xwd,model/iges | igs,model/iges | iges,model/mesh | msh,model/mesh | mesh,model/mesh | silo,model/vrml | wrl,model/vrml | vrml,text/css | css,text/html | html,text/html | htm,text/plain | asc,text/plain | txt,text/richtext | rtx,text/rtf | rtf,text/sgml | sgml,text/sgml | sgm,text/tab-separated-values | tsv,text/vnd.wap.wml | wml,text/vnd.wap.wmlscript | wmls,text/x-setext | etx,text/xml | xsl,text/xml | xml,video/mpeg | mpeg,video/mpeg | mpg,video/mpeg | mpe,video/quicktime | qt,video/quicktime | mov,video/vnd.mpegurl | mxu,video/x-msvideo | avi,video/x-sgi-movie | movie,x-conference/x-cooltal | ice"
        Dim A As String() = Split(MimeTypes, ",")
        Dim I As Integer = 0
        Dim Classification As String = ""
        Dim TgtMime As String = ""
        For I = 0 To UBound(A)
            Dim b As String() = Split(A(I), "|")
            Classification = b(0).Trim
            Dim tMime As String = b(1).Trim
            If StrComp(FileSuffix, tMime, CompareMethod.Text) = 0 Then
                TgtMime = tMime
                Exit For
            End If
        Next
        Return Classification
    End Function

    Private Shared Function BinToHex(ByVal data As Byte()) As String
        If Not data Is Nothing Then
            Dim sb As New System.Text.StringBuilder
            For i As Integer = 0 To data.Length - 1
                sb.Append(data(i).ToString("X2"))
            Next
            Return sb.ToString()
        Else
            Return Nothing
        End If
    End Function

    Public Shared Function HexToBin(ByVal s As String) As Byte()
        Dim arraySize As Integer = CInt(s.Length / 2)
        Dim bytes(arraySize - 1) As Byte
        Dim counter As Integer

        For i As Integer = 0 To s.Length - 1 Step 2
            Dim hexValue As String = s.Substring(i, 2)

            ' Tell convert to interpret the string as a 16 bit hex value
            Dim intValue As Integer = Convert.ToInt32(hexValue, 16)
            ' Convert the integer to a byte and store it in the array
            bytes(counter) = Convert.ToByte(intValue)
            counter += 1
        Next

        Return bytes
    End Function

    Public Function RecursiveSearch(ByVal path As String, ByRef A As String()) As Boolean
        Try
            Application.DoEvents()
            Dim dirfound As Boolean = False
            path = UTIL.ReplaceSingleQuotes(path)
            Dim dirInfo As New IO.DirectoryInfo(path)
            Dim fileObject As FileSystemInfo
            For Each fileObject In dirInfo.GetFileSystemInfos()

                Application.DoEvents()
                Dim iCode As Integer = fileObject.Attributes
                Dim SS As String = fileObject.Attributes.ToString
                Dim isDirectory As Boolean = False
                If InStr(SS, ", directory", CompareMethod.Text) Then
                    If ddebug Then Debug.Print(fileObject.Attributes.ToString)
                    isDirectory = True
                End If

                If iCode = 16 Then
                    isDirectory = True
                End If

                If isDirectory = True Then

                    frmMain.SB.Text = fileObject.FullName
                    frmMain.SB.Refresh()
                    Application.DoEvents()

                    'Dim tDir  = GetFilePath(fileObject.FullName)
                    dirfound = True
                    ReDim Preserve A(UBound(A) + 1)
                    A(UBound(A)) = fileObject.FullName
                    frmMain.SubDirectories.Add(fileObject.FullName)
                    RecursiveSearch(fileObject.FullName, A)
                End If

            Next
            Return dirfound
        Catch ex As Exception
            LogThis("clsDma : RecursiveSearch : 422 : " + ex.Message)
            Return False
        End Try

    End Function

    ''' <summary>
    ''' </summary>
    ''' <param name="DirName">      </param>
    ''' <param name="DirFiles">     </param>
    ''' <param name="IncludedTypes"></param>
    ''' <param name="ExcludedTypes"></param>
    ''' <param name="ckArchiveFlag"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function getFilesInDir(ByVal DirName As String, ByRef DirFiles As List(Of String), ByVal IncludedTypes As ArrayList, ByVal ExcludedTypes As ArrayList, ByVal ckArchiveFlag As Boolean) As Integer

        'WDM - Convert the below to use a data structure class

        Dim I As Integer = DirFiles.Count
        Dim iFilesAdded As Integer = 0
        Dim xFileName As String = ""
        Dim FilterList As New List(Of String)
        Dim ArchiveAttr As Boolean = False

        For II As Integer = 0 To IncludedTypes.Count - 1
            If InStr(IncludedTypes(II), ".") = 0 Then
                IncludedTypes(II) = "." + IncludedTypes(II)
            End If
            If InStr(IncludedTypes(II), "*") = 0 Then
                IncludedTypes(II) = "*"
            End If
            If InStr(IncludedTypes(II), "*.*") > 0 Then
                IncludedTypes(II) = "*"
            End If
            If IncludedTypes(II).Equals("*.*") Then
                IncludedTypes(II) = "*"
            End If
            If IncludedTypes(II).Equals(".*") Then
                IncludedTypes(II) = "*"
            End If
            FilterList.Add(IncludedTypes(II))
        Next
        Try
            Dim FileAttributes As String = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)

            'Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo

            Dim Files As List(Of FileInfo) = Nothing
            Dim IncludeSubDir As Boolean = False

            If IncludeSubDir = True Then
                Files = UTIL.GetFilesRecursive(DirName, FilterList)
            Else
                Files = UTIL.GetFiles(DirName, FilterList, "N")
            End If
            Dim XX As Integer = 0
            Try
                For Each fi In Files
                    XX += 1
                    If fi.Attributes And 32 Then
                        ArchiveAttr = True
                        'frmReconMain.SB.Text = fi.Name
                        Application.DoEvents()
                        'frmReconMain.SB.Text = "Processed: -" & XX
                    Else
                        ArchiveAttr = False
                        If ckArchiveFlag = True Then
                            'frmReconMain.SB.Text = "Processed: -" & XX
                            Application.DoEvents()
                            GoTo NextFile
                        Else
                            'frmReconMain.SB.Text = "Processed: +" & XX
                            Application.DoEvents()
                        End If
                    End If

                    Dim fExt As String = fi.Extension
                    If InStr(fi.FullName, ".") = 0 Then
                        LogThis("Warning: File '" + fi.Name + "' has no extension, skipping.")
                        GoTo NextFile
                    End If
                    If fExt.Length = 0 Then
                        fExt = getFileExtension(fi.FullName)
                    End If
                    FixFileExtension(fExt)

                    Dim TempExt As String = fExt
                    If InStr(fExt, ".") = 0 Then
                        TempExt = "." + fExt
                    End If
                    If InStr(fExt, "*") = 0 Then
                        TempExt = "*" + fExt
                    End If
                    Dim bbExt As Boolean = isExtIncluded(TempExt, IncludedTypes)

                    For IX As Integer = 0 To IncludedTypes.Count - 1
                        If IncludedTypes(IX).Equals("*.*") Or IncludedTypes(IX).Equals("*") Then
                            bbExt = True
                        End If
                    Next

                    If Not bbExt Then
                        GoTo NextFile
                    End If

                    bbExt = isExtExcluded(fExt, ExcludedTypes)
                    If bbExt Then
                        GoTo NextFile
                    End If
                    If ckArchiveFlag = True Then
                        Dim bArch As Boolean = Me.isArchiveBitOn(fi.FullName)
                        If bArch = False Then
                            'This file does not need to be archived
                            GoTo NextFile
                        End If
                    End If

                    xFileName = fi.FullName

                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                    FileAttributes = ""
                    FileAttributes = FileAttributes + fi.Name + "|"
                    FileAttributes = FileAttributes + fi.FullName + "|"
                    FileAttributes = FileAttributes + fi.Length.ToString + "|"
                    FileAttributes = FileAttributes + fi.Extension + "|"

                    Dim xdate As Date = fi.LastAccessTime
                    'Dim sDate As String = UTIL.ConvertDate(xdate)
                    Dim sDate As String = xdate.ToString

                    'Console.WriteLine(xdate.ToString)
                    'Console.WriteLine(sDate)

                    'FileAttributes  = FileAttributes  + fi.LastAccessTime.ToString + "|"
                    FileAttributes = FileAttributes & xdate & "|"

                    xdate = fi.CreationTime
                    'sDate = UTIL.ConvertDate(xdate)
                    sDate = xdate.ToString
                    FileAttributes = FileAttributes & xdate & "|"

                    xdate = fi.LastWriteTime
                    'sDate = UTIL.ConvertDate(xdate)
                    sDate = xdate.ToString
                    FileAttributes = FileAttributes & xdate

                    If fi.Length > 0 Then
                        Dim fn As String = fi.Name
                        If fn.Substring(1, 1).Equals("~") Then
                            If I = 0 Then
                                DirFiles.Add(FileAttributes)
                            Else
                                DirFiles.Add(FileAttributes)
                            End If
                        End If
                    End If
                    iFilesAdded += 1
NextFile:
                    I = I + 1
                Next
            Catch ex As Exception
                LogThis("ERROR - clsDma : getFilesInDir : 22012c : " + ex.Message + Environment.NewLine + "DIR: " + DirName + Environment.NewLine + "FILE: " + fi.Name)
            End Try
        Catch ex As Exception
            'messagebox.show("Error 22013: " + ex.Message)
            NbrOfErrors += 1
            ''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
            LogThis("clsDma : getFilesInDir : 471 : " + ex.Message)
        End Try
        Return iFilesAdded
    End Function

    Function getFileInDir(ByVal DirName As String, ByRef DirFiles As List(Of String)) As Integer
        Dim I As Integer = 0

        Try
            DirFiles.Clear()
            Dim FileAttributes As String = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo

            Try
                For Each fi In aryFi
                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                    FileAttributes = ""
                    FileAttributes = FileAttributes + fi.Name + "|"
                    FileAttributes = FileAttributes + fi.FullName + "|"
                    FileAttributes = FileAttributes + fi.Length.ToString + "|"
                    FileAttributes = FileAttributes + fi.Extension + "|"
                    FileAttributes = FileAttributes + fi.LastAccessTime.ToString + "|"
                    FileAttributes = FileAttributes + fi.CreationTime.ToString + "|"
                    FileAttributes = FileAttributes + fi.LastWriteTime.ToString

                    DirFiles.Add(FileAttributes)

                    I = I + 1
                Next
            Catch ex As Exception
                MessageBox.Show("Error 22012a: " + ex.Message)
                LogThis("clsDma : getFileInDir : 480 : " + ex.Message)
                LogThis("clsDma : getFileInDir : 491 : " + ex.Message)
                LogThis("clsDma : getFileInDir : 502 : " + ex.Message)
            End Try
        Catch ex As Exception
            MessageBox.Show("Error 22013: " + ex.Message)
            LogThis("clsDma : getFileInDir : 481 : " + ex.Message)
            LogThis("clsDma : getFileInDir : 493 : " + ex.Message)
            LogThis("clsDma : getFileInDir : 505 : " + ex.Message)
        End Try
        Return I
    End Function

    Public Function getFilesInDir(ByVal DirName As String, ByRef DirFiles As List(Of String), ByVal ExactFileName As String) As Integer

        DirName = UTIL.RemoveSingleQuotes(DirName)
        ExactFileName = UTIL.RemoveSingleQuotes(ExactFileName)

        Dim I As Integer = 0
        Dim FQN As String = DirName + "\" + ExactFileName
        Try
            DirFiles.Clear()
            Dim FileAttributes As String = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim fInfo As New IO.FileInfo(DirName + "\" + ExactFileName)
            'Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName )
            'Dim fi As IO.FileInfo

            Try
                'For Each fi In aryFi
                strFileSize = (Math.Round(fInfo.Length / 1024)).ToString()
                FileAttributes = ""
                FileAttributes = FileAttributes + fInfo.Name + "|"
                FileAttributes = FileAttributes + fInfo.FullName + "|"
                FileAttributes = FileAttributes + fInfo.Length.ToString + "|"
                FileAttributes = FileAttributes + fInfo.Extension + "|"

                'Dim ZDate As DateTime = DateTime.Parse(fInfo.LastAccessTime.ToString)
                'Date.ToString("ddMMyy")
                'Date.ToString("hhmm")

                Dim xDate As Date = fInfo.LastAccessTime
                xDate.ToString("MM/dd/yyyy")

                FileAttributes = FileAttributes + xDate.ToString + "|"

                xDate = fInfo.CreationTime
                xDate.ToString("MM/dd/yyyy")
                FileAttributes = FileAttributes + fInfo.CreationTime.ToString + "|"
                FileAttributes = FileAttributes + fInfo.LastWriteTime.ToString

                If fInfo.Length > 0 Then
                    Dim fn As String = fInfo.Name
                    If fn.Substring(1, 1).Equals("~") Then
                        If I = 0 Then
                            DirFiles.Add(FileAttributes)
                        Else
                            DirFiles.Add(FileAttributes)
                        End If
                    End If
                End If
                I = I + 1
                'Next
            Catch ex As Exception
                MessageBox.Show("Error 22012b: " + ex.Message)
                LogThis("clsDma : getFilesInDir : 508 : " + ex.Message)
                LogThis("clsDma : getFilesInDir : 521 : " + ex.Message)
                LogThis("clsDma : getFilesInDir : 534 : " + ex.Message)
            End Try
        Catch ex As Exception
            MessageBox.Show("Error 22013: " + ex.Message)
            LogThis("clsDma : getFilesInDir : 509 : " + ex.Message)
            LogThis("clsDma : getFilesInDir : 523 : " + ex.Message)
            LogThis("clsDma : getFilesInDir : 537 : " + ex.Message)
        End Try
        Return I
    End Function

    Sub ReplaceStar(ByRef tVal As String)
        Dim CH As String = ""
        If InStr(tVal, "*") = 0 Then
            Return
        End If
        If tVal.Length > 0 Then
            If tVal.Length > 1 Then
                CH = Mid(tVal, 1, 1)
                If CH.Equals("*") Then
                    Mid(tVal, 1, 1) = "%"
                End If
                CH = Mid(tVal, tVal.Length, 1)
                If CH.Equals("*") Then
                    Mid(tVal, tVal.Length, 1) = "%"
                End If
            End If
        End If
    End Sub

    Sub ReplaceSingleTick(ByRef tVal As String)
        tVal = tVal.Trim
        Dim CH As String = ""
        If InStr(tVal, "'") = 0 Then
            Return
        End If
        For i As Integer = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            If CH.Equals("'") Then
                Mid(tVal, i, 1) = "`"
            End If
        Next
    End Sub

    Sub GetStartAndStopDate(ByRef StartDate As Date, ByRef EndDate As Date)
        ''5/14/2009 12:00:00 AM'
        Dim S1 As String = StartDate.ToString
        Dim S2 As String = EndDate.ToString
        Dim I As Integer = 0
        I = InStr(S1, "12:00:00")

        Mid(S1, I, 1) = "1"
        I += 1
        Mid(S1, I, 1) = "2"
        I += 1
        Mid(S1, I, 1) = ":"
        I += 1
        Mid(S1, I, 1) = "0"
        I += 1
        Mid(S1, I, 1) = "0"
        I += 1
        Mid(S1, I, 1) = ":"
        I += 1
        Mid(S1, I, 1) = "0"
        I += 1
        Mid(S1, I, 1) = "0"

        I = InStr(S2, "12:00:00")
        Mid(S2, I, 1) = "1"
        Mid(S2, I, 1) = "1"
        I += 1
        Mid(S2, I, 1) = "1"
        I += 1
        Mid(S2, I, 1) = ":"
        I += 1
        Mid(S2, I, 1) = "5"
        I += 1
        Mid(S2, I, 1) = "9"
        I += 1
        Mid(S2, I, 1) = ":"
        I += 1
        Mid(S2, I, 1) = "5"
        I += 1
        Mid(S2, I, 1) = "9"
        I += 1
        Mid(S2, I, 1) = " "
        I += 1
        Mid(S2, I, 1) = "P"

        StartDate = CDate(S1)
        EndDate = CDate(S2)

    End Sub

    Function ckQryDate(ByVal StartDate As String, ByVal EndDate As String, ByVal Evaluator As String, ByVal DbColName As String, ByRef FirstTime As Boolean) As String

        '** Set to false by WDM on 3/10/2010 to allow for parens and the AND operator
        FirstTime = False

        Dim S As String = ""
        Dim CH As String = ""
        Dim WhereClause As String = ""
        If UCase(Evaluator).Equals("OFF") Then
            Return WhereClause
        Else
            If Evaluator.Equals("OFF") Then
                Return WhereClause
            ElseIf Evaluator.Equals("After") Then
                If FirstTime Then
                    WhereClause = " " + DbColName + " > '" + CDate(StartDate).ToString + "'" + Environment.NewLine
                    FirstTime = False
                Else
                    WhereClause = " AND (" + DbColName + " > '" + CDate(StartDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator.Equals("Before") Then
                If FirstTime Then
                    WhereClause = " " + DbColName + " < '" + CDate(StartDate).ToString + "'" + Environment.NewLine
                    FirstTime = False
                Else
                    WhereClause = " AND (" + DbColName + " < '" + CDate(StartDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator.Equals("Between") Then
                GetStartAndStopDate(StartDate, EndDate)
                'select * from Production.Product where Sellcdate(StartDate).tostring between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause = " " + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "' " + Environment.NewLine
                Else
                    WhereClause = " AND (" + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator.Equals("Not Between") Then
                GetStartAndStopDate(StartDate, EndDate)
                'select * from Production.Product where SellStartDate between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause = " " + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "'" + Environment.NewLine
                Else
                    WhereClause = " AND (" + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator.Equals("On") Then
                GetStartAndStopDate(StartDate, EndDate)
                If FirstTime Then
                    FirstTime = False
                    WhereClause = " " + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "'" + Environment.NewLine
                Else
                    WhereClause = " AND (" + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            Else
                Return WhereClause
            End If

        End If
        Return WhereClause
    End Function

    Sub AddSlashToDirName(ByRef tDir As String)

        If tDir.Trim.Length = 0 Then
            Return
        End If

        Dim I As Integer = 0
        tDir = tDir.Trim
        I = tDir.Length
        Dim CH As String = Mid(tDir, I, 1)
        If CH = "\" Then
            Return
        Else
            tDir = tDir + "\"
        End If

    End Sub

    Sub ListRegistryKeys(ByVal FileExt As String, ByRef LB As List(Of String))
        Try
            Dim rootKey As RegistryKey
            rootKey = Registry.ClassesRoot
            Dim S As String

            Dim regSubKey As RegistryKey

            Dim subk As String

            Dim tmp As RegistryKey
            rootKey = rootKey.OpenSubKey(FileExt, False)
            Debug.Print(rootKey.GetValue("").ToString())
            Debug.Print(rootKey.GetValue("Content Type").ToString())

            Dim ControlApp As String = rootKey.GetValue("Content Type").ToString()

            LB.Add("Content Type: " + rootKey.GetValue("Content Type").ToString())

            For Each subk In rootKey.GetSubKeyNames()
                'MessageBox.Show(subk)
                S = subk + " : "
                tmp = rootKey.OpenSubKey(subk)
                S = tmp.ToString
                LB.Add(S)
            Next
        Catch ex As Exception
            Debug.Print(ex.Message)
            LogThis("clsDma : ListRegistryKeys : 595 : " + ex.Message)
            LogThis("clsDma : ListRegistryKeys : 610 : " + ex.Message)
            LogThis("clsDma : ListRegistryKeys : 625 : " + ex.Message)
        End Try

    End Sub

    Function GetCurrUserName() As String
        Dim S As String = ""
        S = Environment.UserName.ToString
        Return S
    End Function

    Function GetCurrOsVersionName() As String
        Dim S As String = ""
        S = Environment.OSVersion.ToString
        Return S
    End Function

    Function GetCurrEnvironmentVersionName() As String
        Dim S As String = ""
        S = Environment.Version.ToString
        Return S
    End Function

    Function GetCurrSystemDirectory() As String
        Dim S As String = ""
        S = Environment.SystemDirectory.ToString
        Return S
    End Function

    Function GetCurrUptime() As String
        Dim S As String = ""
        S = Mid((Environment.TickCount / 3600000), 1, 5) & " :Hours"
        S = Environment.SystemDirectory.ToString
        Return S
    End Function

    Function GetCurrMachineName() As String
        Dim S As String = ""
        S = Environment.MachineName.ToString
        Return S
    End Function

    Function GetCurrentDirectory() As String
        Dim S As String = ""
        S = Environment.CurrentDirectory.ToString
        Return S
    End Function

    Function GetUserDomainName() As String
        Dim S As String = ""
        S = Environment.UserDomainName.ToString
        Return S
    End Function

    Function GetWorkingSet() As String
        Dim S As String = ""
        S = Environment.WorkingSet.ToString
        Return S
    End Function

    Function isFileArchiveAttributeSet(ByVal FQN As String) As Boolean

        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
        'Console.WriteLine(fileDetail.IsReadOnly)
        Dim A As Integer = fileDetail.Attributes.Archive
        Dim R As Integer = fileDetail.Attributes.ReadOnly
        Dim H As Integer = fileDetail.Attributes.Hidden
        Dim C As Integer = fileDetail.Attributes.Compressed
        Dim D As Integer = fileDetail.Attributes.Directory
        Dim E As Integer = fileDetail.Attributes.Encrypted
        Dim N As Integer = fileDetail.Attributes.Normal
        Dim NCI As Integer = fileDetail.Attributes.NotContentIndexed
        Dim OL As Integer = fileDetail.Attributes.Offline
        Dim S As Integer = fileDetail.Attributes.System
        Dim T As Integer = fileDetail.Attributes.Temporary

        'Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))

        If (fileDetail.Attributes And fileDetail.Attributes.Archive) = fileDetail.Attributes.Archive Then
            'MessageBox.Show(fileDetail.Name & " is Archived")
            Return False
        Else
            'MessageBox.Show(fileDetail.Name & " is NOT Archived")
            Return True
        End If

    End Function

    Function setFileArchiveAttributeSet(ByVal FQN As String, ByVal SetOn As Boolean) As Boolean

        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)

        If SetOn = True Then
            fileDetail.Attributes = fileDetail.Attributes And fileDetail.Attributes.Archive
        Else
            fileDetail.Attributes = fileDetail.Attributes And Not fileDetail.Attributes.Archive
        End If

    End Function

    Function setFileArchiveBitOn(ByVal FQN As String) As Boolean
        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
        fileDetail.Attributes = fileDetail.Attributes + fileDetail.Attributes.Archive
    End Function

    Function setFileArchiveBitOff(ByVal FQN As String) As Boolean
        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
        fileDetail.Attributes = fileDetail.Attributes - fileDetail.Attributes.Archive
    End Function

    'WDM This could be a problem
    Function ToggleArchiveBit(ByVal filespec As String) As Boolean

        filespec = UTIL.ReplaceSingleQuotes(filespec)

        Try
            Dim fso, f
            fso = CreateObject("Scripting.FileSystemObject")
            f = fso.GetFile(filespec)

            If f.attributes And 32 Then
                f.attributes = f.attributes - 32
                'ToggleArchiveBit = "Archive bit is cleared."
                Return True
            Else
                f.attributes = f.attributes + 32
                'ToggleArchiveBit = "Archive bit is set."
                Return False
            End If
        Catch ex As Exception
            LogThis("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
            Return False
        End Try
    End Function

    Function isArchiveBitOn(ByVal filespec As String) As Boolean

        'Dim skipThis As Boolean = True
        'If skipThis = True Then
        'Return False
        'End If

        Dim B As Boolean = False

        Try

            Dim MyAttr As FileAttribute
            ' Assume file TESTFILE is normal and readonly.
            MyAttr = GetAttr(filespec)   ' Returns vbNormal.
            'Dim iAttr As Integer = GetAttr(filespec)

            ' Test for Archived.
            If (MyAttr And FileAttribute.Archive) = FileAttribute.Archive Then
                'If (MyAttr And FileAttribute.Archive) = 1 Then
                'The "A" is showing.
                Return True
            Else
                Return False
            End If

            'Feb 7, 2010 - Set the above code in place and removed the following - WDM
            'Dim fso, f
            'fso = CreateObject("Scripting.FileSystemObject")
            'f = fso.GetFile(filespec)

            'If f.attributes And 32 Then
            '    'f.attributes = f.attributes - 32
            '    'ToggleArchiveBit = "Archive bit is cleared."
            '    B = True
            'Else
            '    'f.attributes = f.attributes + 32
            '    'ToggleArchiveBit = "Archive bit is set."
            '    B = False
            'End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Warning: clsDMa:isArchiveBitOn 100 - " + ex.Message)
            B = False
        End Try

        Return B
    End Function

    Function setArchiveBitOff(ByVal filespec As String) As Boolean

        Dim B As Boolean = False
        filespec = UTIL.ReplaceSingleQuotes(filespec)

        Try
            ''Dim MyAttr As FileAttribute
            ''' Assume file TESTFILE is normal and readonly.
            ''MyAttr = GetAttr(filespec )   ' Returns vbNormal.
            'If F.Exists(filespec) Then
            '    F.SetAttributes(filespec, FileAttributes.Archive)
            '    'SetAttr(filespec , FileAttribute.Archive)
            'End If

            Dim f As New FileInfo(filespec)
            f.Attributes = f.Attributes And Not FileAttributes.Archive
            f = Nothing

            'SetAttr(filespec , FileAttribute.Archive)
            'B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("Warning: clsDMa:setArchiveBitOn 100 - " + ex.Message)
            B = False
        End Try

        Return B
    End Function

#If GetAllWidgets Then
    Sub getFormWidgets(ByVal F As Form)

        Dim HELP As New clsHELPTEXT

Dim FormName AS String  = F.Name
        Dim loControl As Control

        Dim lsTmp As String = ""
Dim S AS String  = ""
        Dim A As New ArrayList
Dim SS AS String  = ""
Dim ctlText AS String  = ""
Dim ControlType AS String  = ""
        For Each loControl In F.Controls
            SS  = FormName + "," + loControl.Name + "," + loControl.Text + "," + "<help text here>"
            ctlText  = loControl.Text
            Debug.Print(loControl.Name)
            lsTmp += loControl.Name & vbNewLine
            ControlType  = loControl.GetType.ToString
            Dim iCnt As Integer = loControl.Controls.Count - 1
            Dim B As Boolean = True
            If ControlType.Equals("System.Windows.Forms.GroupBox") Then
                SS  = FormName
                Debug.Print("GBox: " + loControl.Name)
                For x As Integer = 0 To loControl.Controls.Count - 1
                    B = False
Dim Ctrl2 AS String  = loControl.Controls.Item(x).Name
                    S += "TT.SetToolTip(" + Ctrl2  + ", " + Chr(34) + "<" + loControl.Controls.Item(x).Text + ">" + Chr(34) + ")" + " '*GB" + environment.NewLine

                    SS  = FormName + "," + Ctrl2  + "," + loControl.Controls.Item(x).Text + "," + "<help text here>"
                    A.Add(SS)
                    'For Each ctrl As Control In loControl.Controls
                    '    Debug.Print("Inside GBox: " + ctrl.Name)
                    'Next
                Next
            End If
            If B = True Then
                A.Add(SS)
            End If
            S += "TT.SetToolTip(" + loControl.Name + ", " + Chr(34) + "<" + ctlText  + ">" + Chr(34) + ")" + environment.NewLine
        Next loControl
        S = S + " " + environment.NewLine
        S = S + " " + environment.NewLine
        For i As Integer = 0 To A.Count - 1
            Dim ScreenName As String = ""
Dim WidgetName AS String  = ""
Dim WidgetText AS String  = ""
            S = S + A(i) + environment.NewLine
Dim tArray AS String () = Split(A(i), ",")

            If tArray(0).Trim.Length = 0 Then
                GoTo NEXTONE
            End If
            If tArray(0).Trim.Length = 0 Then
                GoTo NEXTONE
            End If

            tArray(0) = Me.UTIL.RemoveSingleQuotes(tArray(0))
            tArray(1) = Me.UTIL.RemoveSingleQuotes(tArray(1))
            tArray(2) = Me.UTIL.RemoveSingleQuotes(tArray(2))
            tArray(3) = Me.UTIL.RemoveSingleQuotes(tArray(3))

            ScreenName = tArray(0)
            WidgetName  = tArray(1)
            WidgetText  = tArray(2)

            Dim iCnt As Integer = HELP.cnt_PK_HelpText(ScreenName, WidgetName)
            If iCnt = 0 Then
                'ScreenName = tArray(0)
                'WidgetName  = tArray(1)
                If WidgetName .Length = 0 Then
                    GoTo NEXTONE
                End If
                HELP.setScreenname(tArray(0))
                HELP.setWidgetname(tArray(1))
                HELP.setWidgettext(tArray(2))
                HELP.setHelptext(tArray(3))
                Dim BB As Boolean = HELP.Insert()
                If BB = False Then
                    Debug.Print("Failed to enter help...")
                End If
            Else
                'ScreenName = tArray(0)
                'WidgetName  = tArray(1)
                If WidgetName .Length = 0 Then
                    GoTo NEXTONE
                End If
                HELP.setScreenname(tArray(0))
                HELP.setWidgetname(tArray(1))
                HELP.setWidgettext(tArray(2))
                HELP.setHelptext(tArray(3))
Dim WC AS String  = HELP.wc_PK_HelpText(ScreenName, WidgetName)
                Dim Bb As Boolean = UpdateDoNotChangeHelpText(WC, ScreenName, WidgetName, WidgetText )
                If Bb = False Then
                    Debug.Print("Failed to UPDATE help...")
                End If
            End If
NEXTONE:
        Next
        'If ddebug Then Clipboard.SetText(S)
    End Sub
#End If

    ''' <summary>
    ''' OK - to anyone that reads this later... This is kind of a thought that should not be tried,
    ''' but what the heck. MAybe we can pass a control in by REF and let the object modify itself. I
    ''' figure if an ameba can do it, maybe a reflective object can too! Speaking of stupid, remember
    ''' to wrap this in a TRY/CATCH.
    ''' </summary>
    ''' <param name="TT">     .NET ToolTip</param>
    ''' <param name="ctrl">   Any form control</param>
    ''' <param name="TipText">The Tooltip object must exist on the form or this will blow up.</param>
    ''' <remarks></remarks>
    Sub addToolTip(ByVal TT As ToolTip, ByRef ctrl As Control, ByVal TipText As String)
        '** Holy shit, this may work!
        Try
            TT.SetToolTip(ctrl, TipText)
        Catch ex As Exception
            MessageBox.Show("You blew this idiot," + Environment.NewLine + ex.Message)
            LogThis("clsDma : addToolTip : 749 : " + ex.Message)
            LogThis("clsDma : addToolTip : 770 : " + ex.Message)
            LogThis("clsDma : addToolTip : 784 : " + ex.Message)
        End Try

    End Sub

    'Public Sub smoLoadServers(ByRef CB As Windows.Forms.ComboBox)

    ' Dim dt As DataTable = SmoApplication.EnumAvailableSqlServers(False) Dim ServersFound As Boolean
    ' = False

    '    If dt.Rows.Count > 0 Then
    '        For Each dr As DataRow In dt.Rows
    '            ServersFound = True
    '            If ddebug Then Console.WriteLine(dr("Name"))
    '            CB.Items.Add(dr("Name"))
    '        Next
    '    End If
    '    If Not ServersFound Then
    '        CB.Items.Add("NO SQL SERVERS FOUND")
    '    End If
    'End Sub

    'Public Sub LoadServersCombo(ByRef CB As Windows.Forms.ComboBox)
    '    Dim oSQLApp As SQLDMO.Application
    '    Dim oNames As SQLDMO.NameList
    '    Dim i As Integer
    '    oSQLApp = New SQLDMO.Application    'POPULATE CBO ONLY WITH SQL SERVERS
    '    oNames = oSQLApp.ListAvailableSQLServers
    '    CB.Items.Clear()
    '    For i = 1 To oNames.Count
    '        CB.Items.Add(oNames.Item(i))
    '    Next i
    '    If oNames.Count = 0 Then
    '        CB.Items.Add("NO SQL SERVERS FOUND")
    '    End If
    'End Sub

    'Public Sub LoadDatabases(ByVal ServerName , ByVal UserID , ByVal PW , ByRef CB As Windows.Forms.ComboBox)
    '    Dim oSQLServer As New SQLDMO.SQLServer
    '    Dim i As Integer
    '    CB.Items.Clear()
    '    Try
    '        If UserID = "" And PW = "" Then
    '            oSQLServer.LoginSecure = True
    '        End If
    '        oSQLServer.Connect(ServerName, UserID, PW)
    '        For i = 1 To oSQLServer.Databases.Count
    '            Dim dbName  = oSQLServer.Databases.Item(i).Name.ToString
    '            CB.Items.Add(dbName)
    '        Next i
    '    Catch ex As Exception
    '        CB.Items.Clear()
    '        CB.Items.Add(ex.Message.Trim)
    '    End Try
    'End Sub

    Public Function formatTextSearch(ByVal SearchString As String) As String
        If SearchString.Trim.Length = 0 Then
            Return ""
        End If
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim CH As String = ""
        Dim currWord As String = ""
        Dim prevWord As String = ""
        Dim prevWordIsKeyWord As Boolean = False
        Dim currWordIsKeyWord As Boolean = False
        Dim tStack As New ArrayList
        Dim aList As New ArrayList
        For I = 1 To SearchString.Length
            CH = Mid(SearchString, I, 1)
            If CH = Chr(34) Then
                I = I + 1
                CH = Mid(SearchString, I, 1)
                Do While CH <> Chr(34) And I < SearchString.Length
                    I = I + 1
                    CH = Mid(SearchString, I, 1)
                Loop
            ElseIf CH = " " Then
                Mid(SearchString, I, 1) = Chr(254)
            End If
        Next

        Dim NewText As New ArrayList
        Dim A As String() = SearchString.Split(Chr(254))
        For I = 0 To UBound(A)
            currWord = A(I)
            currWordIsKeyWord = ckKeyWord(currWord)
            prevWordIsKeyWord = ckKeyWord(prevWord)
            If ddebug Then Console.WriteLine(SearchString)
            If ddebug Then Console.WriteLine(currWord, currWordIsKeyWord)
            If ddebug Then Console.WriteLine(currWord, prevWordIsKeyWord)
            If currWordIsKeyWord = False And prevWordIsKeyWord = False Then
                If prevWord.Trim.Length > 0 And currWord.Trim.Length > 0 Then
                    Dim CH1 As String = Mid(currWord, 1, 1)
                    If CH1.Equals(Chr(34)) Then
                        NewText.Add("OR")
                        NewText.Add(currWord)
                    ElseIf InStr(1, "+-^|", CH1, CompareMethod.Text) = 0 Then
                        NewText.Add("OR")
                        NewText.Add(currWord)
                    Else
                        NewText.Add(currWord)
                    End If
                ElseIf currWord.Trim.Length > 0 Then
                    NewText.Add(currWord)
                End If
            Else
                NewText.Add(currWord)
            End If
            prevWord = currWord
        Next
        Dim ReformattedSearch As String = ""
        For I = 0 To NewText.Count - 1
            Dim isContainsDoubleQuote As Boolean = False
            Dim isContainsStar As Boolean = False
            Dim tWord As String = NewText.Item(I).ToString
            If InStr(tWord, "*") > 0 Then
                isContainsStar = True
            End If
            If InStr(tWord, Chr(34)) > 0 Then
                isContainsDoubleQuote = True
            End If
            If isContainsDoubleQuote = False And isContainsStar = True Then
                '** Wrap this word in double quotes
                tWord = tWord.Trim
                tWord = Chr(34) + tWord + Chr(34)
            End If
            ReformattedSearch += tWord + " "
        Next
        Return ReformattedSearch
    End Function

    Function ckKeyWord(ByVal KW As String) As Boolean
        Dim B As Boolean = False
        KW = UCase(KW)
        Select Case KW
            Case "NEAR"
                Return True
            Case "AND"
                Return True
            Case "OR"
                Return True
            Case "NOT"
                Return True
            Case "FORMSOF"
                Return True
            Case "FROM"
                Return True
            Case "ISABOUT"
                Return True
            Case "INFLECTIONAL"
                Return True
            Case "CONTAINS"
                Return True
            Case "ORDER"
                Return True
            Case "BY"
                Return True
            Case "CONTAINSTABLE"
                Return True
            Case "FREETEXT"
                Return True
            Case "WHERE"
                Return True
            Case "WITH"
                Return True
            Case "AS"
                Return True
            Case "AS"
                Return True
            Case "INNER"
                Return True
            Case "JOIN"
                Return True
            Case "LEFT"
                Return True
            Case "RIGHT"
                Return True
            Case "OUTER"
                Return True
        End Select
        Return B
    End Function

    Sub ckFirstTokenKeyWord(ByRef tStr As String)
        Try
            Dim S As String = tStr
            Dim A As String() = Split(S, " ")
            If UBound(A) > 0 Then
                Dim B As Boolean = ckKeyWord(A(0))
                If B Then
                    S = ""
                    For i As Integer = 1 To UBound(A)
                        S += A(i) + " "
                    Next
                End If
            End If

            tStr = S
        Catch ex As Exception
            tStr = ""
            LogThis("clsDma : ckFirstTokenKeyWord : 910 : " + ex.Message)
            LogThis("clsDma : ckFirstTokenKeyWord : 934 : " + ex.Message)
            LogThis("clsDma : ckFirstTokenKeyWord : 951 : " + ex.Message)
        End Try

    End Sub

    Public Function getDebug(ByVal FormID As String) As Boolean
        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        Dim B As Boolean = False

        Try
            FormID = "debug_" + FormID
            S = System.Configuration.ConfigurationManager.AppSettings(FormID)
            If S.Equals("0") Then
                B = False
            ElseIf S.Equals("1") Then
                B = True
            ElseIf S.Equals("-1") Then
                B = True
            ElseIf UCase(S).Equals("TRUE") Then
                B = True
            ElseIf UCase(S).Equals("FALSE") Then
                B = False
            End If
        Catch ex As Exception
            B = False
            LogThis("clsDma : getDebug : 928 : " + ex.Message)
            LogThis("clsDma : getDebug : 953 : " + ex.Message)
            LogThis("clsDma : getDebug : 971 : " + ex.Message)
        End Try

        Return B

    End Function

    Function getEnvironmentDir(ByVal DirName As String) As String
        '        0	Desktop			C:\Documents and Settings\Charlie\Desktop
        '2	Programs		C:\Documents and Settings\Charlie\Start Menu\Programs
        '5	Personal		D:\documents
        '6	Favorites		C:\Documents and Settings\Charlie\Favorites
        '8	Recent			C:\Documents and Settings\Charlie\Recent
        '9	SendTo			C:\Documents and Settings\Charlie\SendTo
        '11	StartMenu		C:\Documents and Settings\Charlie\Start Menu
        '13	MyMusic			D:\documents\My Music
        '16	DesktopDirectory	C:\Documents and Settings\Charlie\Desktop
        '17:     MyComputer()
        '26	ApplicationData		C:\Documents and Settings\Charlie\Application Data
        '28	LocalApplicationData	C:\Documents and Settings\Charlie\Local Settings\Application Data
        '32	InternetCache		C:\Documents and Settings\Charlie\Local Settings\Temporary Internet Files
        '33	Cookies			C:\Documents and Settings\Charlie\Cookies
        '34	History			C:\Documents and Settings\Charlie\Local Settings\History
        '35	CommonApplicationData	C:\Documents and Settings\All Users\Application Data
        '37	System			C:\WINDOWS\System32
        '38	ProgramFiles		C:\Program Files
        '39	MyPictures		D:\documents\My Pictures
        '43	CommonProgramFiles	C:\Program FilesCommon Files

        Dim S As String = ""

        'Environment.SpecialFolder.ApplicationData()
        'Environment.SpecialFolder.System()
        'Environment.SpecialFolder.CommonApplicationData()
        'Environment.SpecialFolder.CommonProgramFiles()
        'Environment.SpecialFolder.Cookies()
        'Environment.SpecialFolder.Desktop()
        'Environment.SpecialFolder.DesktopDirectory()
        'Environment.SpecialFolder.Favorites()
        'Environment.SpecialFolder.History()
        'Environment.SpecialFolder.InternetCache()
        'Environment.SpecialFolder.LocalApplicationData()
        'Environment.SpecialFolder.MyComputer()
        'Environment.SpecialFolder.MyMusic()
        'Environment.SpecialFolder.MyPictures()
        'Environment.SpecialFolder.Personal()
        'Environment.SpecialFolder.ProgramFiles()
        'Environment.SpecialFolder.Programs()
        'Environment.SpecialFolder.Recent()
        'Environment.SpecialFolder.SendTo()
        'Environment.SpecialFolder.StartMenu()

        Return S

    End Function

    Public Function App_Path() As String
        Return System.AppDomain.CurrentDomain.BaseDirectory()
    End Function

    Public Function setHelpDir(ByVal HelpFile As String) As String
        Dim tDir As String = App_Path()
        tDir = tDir + "HelpFiles\" + HelpFile
        Return tDir
    End Function

    Function isConnected() As Boolean
        Dim bDebugConnection As Boolean = False
        Dim B As Boolean = False
        ' Returns True if connection is available Replace www.yoursite.com with a site that is
        ' guaranteed to be online - perhaps your corporate site, or microsoft.com

        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 1.")
        Dim objUrl As New System.Uri("http://www.ecmlibrary.com/")
        ' Setup WebRequest

        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 2.")
        Dim objWebReq As System.Net.WebRequest

        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 3.")
        objWebReq = System.Net.WebRequest.Create(objUrl)

        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 4.")
        Dim objResp As System.Net.WebResponse

        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 5.")
        Try
            ' Attempt to get response and return True
            If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 6.")
            objResp = objWebReq.GetResponse

            If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 7.")
            objResp.Close()

            If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 8.")
            objWebReq = Nothing

            If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 9.")
            B = True
        Catch ex As Exception
            ' Error, exit and return False
            'objResp.Close()
            'objWebReq = Nothing
            B = False
            If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 10.")
            LogThis("FAILED TO CONNECT clsDma : isConnected : 987 : " + ex.Message)
        End Try
        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 11.")
        Return B
    End Function

    'Public Sub SetSearchFields(ByVal txtSearch , ByVal txtThesaurus )
    '    Try
    '        frmQuickSearch.txtThesaurus.Text = txtThesaurus
    '        frmQuickSearch.txtSearch.Text = txtSearch
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    '    Try
    '        frmDocSearch.txtThesaurus.Text = txtThesaurus
    '        frmDocSearch.txtSearch.Text = txtSearch
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    '    Try
    '        frmEmailSearch.txtThesaurus.Text = txtThesaurus
    '        frmEmailSearch.txtSearch.Text = txtSearch
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    'End Sub

    ' Only the first X bytes of the file are read into a byte array. BUFFERSIZE is X. A larger number
    ' will use more memory and be slower. A smaller number may not be able to decode all JPEG files.
    ' Feel free to play with this number.
    '
    ' CImageInfo
    '
    ' Author: David Crowell davidc@qtm.net http://www.qtm.net/~davidc
    '
    ' Released to the public domain use however you wish
    '
    ' CImageInfo will get the image type ,dimensions, and color depth from JPG, PNG, BMP, and GIF files.
    '
    ' version date: June 16, 1999
    '
    ' http://www.wotsit.org is a good source of file format information. This code would not have
    ' been possible without the files I found there.

    ' read-only properties

    'Public Function GetWidth() As Long
    '    Return GraphicWidth
    'End Function
    'Public Function GetHeight() As Long
    '    Return GraphicHeight
    'End Function
    'Public Function GetDepth() As Byte
    '    Return graphicDepth
    'End Function
    'Public Function GetImageType() As eImageType
    '    Return ImageType
    'End Function

    'Public Sub ReadImageInfo(ByVal sFileName As String)
    '    ' This is the sub to call to retrieve information on a file.

    ' ' Byte array buffer to store part of the file Dim bBuf(BUFFERSIZE) As Byte ' Open file number
    ' Dim iFN As Integer

    ' ' Set all properties to default values GraphicWidth = 0 GraphicHeight = 0 GraphicDepth = 0
    ' ImageType = itUNKNOWN

    '    ' here we will load the first part of a file into a byte
    '    'array the amount of the file stored here depends on
    '    'the BUFFERSIZE constant
    '    iFN = FreeFile()
    'Open sFileName For Binary As iFN
    'Get #iFN, 1, bBuf()
    '    Close(iFN)

    ' If bBuf(0) = 137 And bBuf(1) = 80 And bBuf(2) = 78 Then ' this is a PNG file

    ' m_ImageType = itPNG

    ' ' get bit depth Select Case bBuf(25) Case 0 ' greyscale m_Depth = bBuf(24)

    ' Case 2 ' RGB encoded m_Depth = bBuf(24) * 3

    ' Case 3 ' Palette based, 8 bpp m_Depth = 8

    ' Case 4 ' greyscale with alpha m_Depth = bBuf(24) * 2

    ' Case 6 ' RGB encoded with alpha m_Depth = bBuf(24) * 4

    ' Case Else ' This value is outside of it's normal range, so 'we'll assume ' that this is not a
    ' valid file m_ImageType = itUNKNOWN

    ' End Select

    ' If m_ImageType Then ' if the image is valid then

    ' ' get the width m_Width = Mult(bBuf(19), bBuf(18))

    ' ' get the height m_Height = Mult(bBuf(23), bBuf(22)) End If

    ' End If

    ' If bBuf(0) = 71 And bBuf(1) = 73 And bBuf(2) = 70 Then ' this is a GIF file

    ' m_ImageType = itGIF

    ' ' get the width m_Width = Mult(bBuf(6), bBuf(7))

    ' ' get the height m_Height = Mult(bBuf(8), bBuf(9))

    ' ' get bit depth m_Depth = (bBuf(10) And 7) + 1 End If

    ' If bBuf(0) = 66 And bBuf(1) = 77 Then ' this is a BMP file

    ' m_ImageType = itBMP

    ' ' get the width m_Width = Mult(bBuf(18), bBuf(19))

    ' ' get the height m_Height = Mult(bBuf(22), bBuf(23))

    ' ' get bit depth m_Depth = bBuf(28) End If

    ' If m_ImageType = itUNKNOWN Then ' if the file is not one of the above type then ' check to see
    ' if it is a JPEG file Dim lPos As Long

    ' Do ' loop through looking for the byte sequence FF,D8,FF ' which marks the begining of a JPEG
    ' file ' lPos will be left at the postion of the start If (bBuf(lPos) = &HFF And bBuf(lPos + 1) =
    ' &HD8 _ And bBuf(lPos + 2) = &HFF) _ Or (lPos >= BUFFERSIZE - 10) Then Exit Do

    ' ' move our pointer up lPos = lPos + 1

    ' ' and continue Loop

    ' lPos = lPos + 2 If lPos >= BUFFERSIZE - 10 Then Exit Sub

    ' Do ' loop through the markers until we find the one 'starting with FF,C0 which is the block
    ' containing the 'image information

    ' Do ' loop until we find the beginning of the next marker If bBuf(lPos) = &HFF And bBuf(lPos +
    ' 1) _ <> &HFF Then Exit Do lPos = lPos + 1 If lPos >= BUFFERSIZE - 10 Then Exit Sub Loop

    ' ' move pointer up lPos = lPos + 1

    ' Select Case bBuf(lPos) Case &HC0 To &HC3, &HC5 To &HC7, &HC9 To &HCB, _ &HCD To &HCF ' we found
    ' the right block Exit Do End Select

    ' ' otherwise keep looking lPos = lPos + Mult(bBuf(lPos + 2), bBuf(lPos + 1))

    ' ' check for end of buffer If lPos >= BUFFERSIZE - 10 Then Exit Sub

    ' Loop

    ' ' If we've gotten this far it is a JPEG and we are ready ' to grab the information.

    ' m_ImageType = itJPEG

    ' ' get the height m_Height = Mult(bBuf(lPos + 5), bBuf(lPos + 4))

    ' ' get the width m_Width = Mult(bBuf(lPos + 7), bBuf(lPos + 6))

    ' ' get the color depth m_Depth = bBuf(lPos + 8) * 8

    ' End If

    'End Sub
    'Private Function Mult(ByVal lsb As Byte, ByVal msb As Byte) As Long
    '    Mult = lsb + (msb * CLng(256))
    'End Function

    Sub SayWords(ByVal Words As String)
        If gVoiceOn = False Then
            Return
        End If
#If Offfice2007 Then
        Dim Voice As New SpeechSynthesizer
        Voice.Rate = 0
        Voice.Speak(Words)
#End If
    End Sub

    Sub ckFreetextSearchLine(ByRef SearchText As TextBox)
        Dim S As String = SearchText.Text.Trim
        Dim A As String() = S.Split(" ")
        For I As Integer = 0 To UBound(A)
            Dim token As String = A(I)
            If InStr(1, token, Chr(34)) > 0 Then
                Do While InStr(1, token, Chr(34)) > 0
                    Dim II As Integer = InStr(1, token, Chr(34))
                    Mid(token, II, 1) = " "
                Loop
            End If
            token = token.Trim
            A(I) = token
            If UCase(token).Equals("AND") Then
                A(I) = ""
            ElseIf UCase(token).Equals("NOT") Then
                A(I) = ""
            ElseIf UCase(token).Equals("OR") Then
                A(I) = ""
            End If
        Next
        S = ""
        For i As Integer = 0 To UBound(A)
            If A(i).Trim.Length > 0 Then
                S = S + A(i).Trim + " "
            End If
        Next
        S = S.Trim
        SearchText.Text = S
    End Sub

    Sub ckFreetextRemoveOr(ByRef SqlQuery As String, ByVal LocatorPhrase As String)
        '" FREETEXT ("
        'FREETEXT (EMAIL.*
        'freetext (subject,
        Dim S As String = SqlQuery.Trim
        Dim I As Integer = 0
        Dim J As Integer = 0

        Dim Part1 As String = ""
        Dim Part2 As String = ""

        I = InStr(1, SqlQuery, LocatorPhrase, CompareMethod.Binary)
        If I = 0 Then
            Return
        End If

        I = InStr(I + 2, SqlQuery, "'", CompareMethod.Binary)
        J = InStr(I + 1, SqlQuery, "'", CompareMethod.Binary)

        Part1 = Mid(SqlQuery, 1, I).Trim
        Part2 = Mid(SqlQuery, J).Trim

        'Clipboard.Clear()
        'Clipboard.SetText(Part1)

        Dim S2 As String = Mid(S, I + 1, J - I - 1).Trim
        Dim A As String() = S2.Split(" ")

        For I = 0 To UBound(A)
            Dim token As String = A(I)
            'If InStr(1, token, Chr(34)) > 0 Then
            '    Do While InStr(1, token, Chr(34)) > 0
            '        Dim II As Integer = InStr(1, token, Chr(34))
            '        Mid(token, II, 1) = " "
            '    Loop
            'End If
            token = token.Trim
            A(I) = token
            If UCase(token).Equals("OR") Then
                A(I) = ""
            End If
        Next

        S = ""
        For I = 0 To UBound(A)
            If A(I).Trim.Length > 0 Then
                S = S + A(I).Trim + " "
            End If
        Next
        S = S.Trim

        S = Part1 + " " + S + " " + Part2
        'Clipboard.Clear()
        'Clipboard.SetText(S)
        SqlQuery = S
    End Sub

    Public Function SaveScreen(ByVal theFile As String) As Boolean
        Dim Pic As New PictureBox
        Dim data As IDataObject
        data = Clipboard.GetDataObject()
        Dim bmap As Bitmap
        If data.GetDataPresent(GetType(System.Drawing.Bitmap)) Then
            bmap = CType(data.GetData(GetType(System.Drawing.Bitmap)), Bitmap)
            Pic.Image = bmap
            Pic.Image.Save(theFile, Imaging.ImageFormat.Jpeg)
        End If
    End Function

    Public Function getFileNameWithoutExtension(ByVal FullPath As String) As String
        Return System.IO.Path.GetFileNameWithoutExtension(FullPath)
    End Function

    Public Function getDirName(ByVal FQN As String) As String
        Dim dirName As String = IO.Path.GetDirectoryName(FQN)
        Return dirName
    End Function

    Public Function getFileName(ByVal FQN As String) As String
        Try
            Dim dirName As String = IO.Path.GetFileName(FQN)
            Return dirName
        Catch ex As Exception
            Return FQN
        End Try
    End Function

    Public Function getFullPath(ByVal FQN As String) As String
        Dim dirName As String = IO.Path.GetFullPath(FQN)
        Return dirName
    End Function

    Public Function getFileExtension(ByVal FQN As String) As String
        Dim dirName As String = IO.Path.GetExtension(FQN)
        Return dirName
    End Function

    ''' <summary>
    ''' This method starts at the specified directory, and traverses all subdirectories. It returns a
    ''' List of those directories.
    ''' </summary>
    Public Function GetFilesRecursive(ByVal initial As String) As List(Of String)
        ' This list stores the results.
        Dim result As New List(Of String)

        ' This stack stores the directories to process.
        Dim stack As New Stack(Of String)

        ' Add the initial directory
        stack.Push(initial)

        ' Continue processing for each stacked directory
        Do While (stack.Count > 0)
            ' Get top directory string
            Dim dir As String = stack.Pop
            Try
                ' Add all immediate file paths
                result.AddRange(Directory.GetFiles(dir, "*.*"))

                ' Loop through all subdirectories and add them to the stack.
                Dim directoryName As String
                For Each directoryName In Directory.GetDirectories(dir)
                    stack.Push(directoryName)
                Next
            Catch ex As Exception
            End Try
        Loop

        ' Return the list
        Return result
    End Function

    Public Function GetSubDirs(ByVal ParentDir As String, ByVal Result As List(Of String)) As Boolean

        ParentDir = UTIL.ReplaceSingleQuotes(ParentDir)

        Try
            Dim MS As String = Now.Millisecond.ToString
            Dim B As Boolean = False
            Dim TempDir As String = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData)
            Dim sCmd As String = "DIR " + ParentDir + "\*.* /AD /S >" + TempDir + "\ServiceManager.DirListing." + MS + ".txt"

            Dim OutputFileFQN As String = TempDir + "\ServiceManager.DirListing." + MS + ".txt"

            Dim BatchFileName As String = TempDir + "\ServiceManger.GetDirListing.bat"

            Dim objReader As StreamWriter
            Try
                objReader = New StreamWriter(BatchFileName)
                objReader.Write(sCmd)
                objReader.Close()
                objReader.Dispose()
                B = True
            Catch Ex As Exception
                LOG.WriteToArchiveLog("ERROR: GetSubDirs 200: " + Ex.Message)
                Return B
            End Try

            frmMain.SB2.Text = "Directory Inventory: " + Now.ToString

            Dim starter As New ProcessStartInfo(BatchFileName)

            Dim P As New System.Diagnostics.Process

            P.StartInfo = starter
            P.Start()
            P.WaitForExit()

            Dim I As Integer = 0
            Do While Not P.HasExited
                I += 1
                System.Threading.Thread.Sleep(2000)
                frmMain.SB2.Text = "Directory Inventory:" + I.ToString + " : " + Now.ToString
                frmMain.SB2.Refresh()
                Application.DoEvents()
            Loop

            Dim sFileName As String = ""
            Dim srFileReader As System.IO.StreamReader
            Dim sInputLine As String
            Dim DirToSave As String = ""

            Dim F As File
            If Not F.Exists(OutputFileFQN) Then
                LOG.WriteToArchiveLog("ERROR - failed to create the Quick Directory List.")
                Return False
            End If

            F = Nothing

            sFileName = OutputFileFQN
            srFileReader = System.IO.File.OpenText(sFileName)
            sInputLine = srFileReader.ReadLine()
            Do Until sInputLine Is Nothing
                DirToSave = ""
                sInputLine = srFileReader.ReadLine()
                If sInputLine = Nothing Then
                    GoTo LoopOver
                End If
                sInputLine = sInputLine.Trim
                If InStr(sInputLine, "Directory of", CompareMethod.Text) Then
                    Dim T As String = Mid(sInputLine, 1, Len("Directory of"))
                    If T.ToUpper.Equals("DIRECTORY OF") Then
                        DirToSave = Mid(sInputLine, Len("Directory of") + 1)
                        DirToSave = DirToSave.Trim
                        If Result.Contains(DirToSave) Then
                        Else
                            If DirToSave.Trim.Length > 254 Then
                                DirToSave = getShortDirName(DirToSave)
                            End If
                            Result.Add(DirToSave)
                        End If
                    End If
                End If
LoopOver:
            Loop

            srFileReader.Close()
            srFileReader = Nothing

            Dim F2 As File
            If F2.Exists(OutputFileFQN) Then
                F2.Delete(OutputFileFQN)
            End If

            F2 = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR GetSubDirs - 100.23.1 - " + ex.Message)
            Return False
        End Try

        Return True

    End Function

    Public Function GetDirsRecursive(ByVal initial As String) As List(Of String)
        ' This list stores the results.
        Dim result As New List(Of String)

        initial = UTIL.ReplaceSingleQuotes(initial)

        ' This stack stores the directories to process.
        Dim stack As New Stack(Of String)

        ' Add the initial directory
        stack.Push(initial)

        ' Continue processing for each stacked directory
        Do While (stack.Count > 0)
            ' Get top directory string
            Dim dir As String = stack.Pop
            If result.Contains(dir) Then
            Else
                result.Add(dir)
            End If

            IXV1 += 1
            ''FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
            Application.DoEvents()

            Try
                ' Add all immediate file paths
                'result.AddRange(Directory.GetFiles(dir, "*.*"))
                ' Loop through all subdirectories and add them to the stack.
                Dim directoryName As String

                frmMain.SB2.Text = dir
                frmMain.SB2.Refresh()
                Application.DoEvents()

                Dim iDirCnt As Integer = Directory.GetDirectories(dir).Count
                If iDirCnt > 0 Then
                    For Each directoryName In Directory.GetDirectories(dir)
                        IXV1 += 1
                        ''FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
                        Application.DoEvents()

                        stack.Push(directoryName)
                        If result.Contains(dir) Then
                        Else
                            result.Add(directoryName)
                        End If
                    Next
                End If
            Catch ex As Exception
            End Try
        Loop

        ' Return the list
        Return result
    End Function

    Sub GetAllDirs(ByVal DirFqn As String, ByRef result As List(Of String))

        Dim Root As New DirectoryInfo(DirFqn)
        Dim Files As FileInfo() = Root.GetFiles("*.*")
        Dim Dirs As DirectoryInfo() = Root.GetDirectories("*.*")

        Console.WriteLine("Root Directories")
        Dim DirectoryName As DirectoryInfo

        For Each DirectoryName In Dirs
            Try
                Console.Write(DirectoryName.FullName)
                'Console.Write(" contains {0} files ", DirectoryName.GetFiles().Length)
                'Console.WriteLine(" and {0} subdirectories ", DirectoryName.GetDirectories().Length)

                frmMain.SB2.Text = DirectoryName.FullName
                frmMain.SB2.Refresh()
                Application.DoEvents()

                If DirectoryName.GetDirectories().Length > 0 Then
                    Dim A As Object = DirectoryName.GetDirectories("*.*")
                    For Each DirName As String In A
                        GetAllDirs(DirFqn, result)
                    Next
                End If

                If result.Contains(DirectoryName.FullName) Then
                Else
                    result.Add(DirectoryName.FullName)
                End If
            Catch E As Exception
                Console.WriteLine("Error accessing")
            End Try
        Next

    End Sub

    Public Sub GetFilesRecursive(ByVal initial As String, ByVal List As List(Of String))
        ' This list stores the results.
        Dim result As New List(Of String)

        ' This stack stores the directories to process.
        Dim stack As New Stack(Of String)

        ' Add the initial directory
        stack.Push(initial)

        ' Continue processing for each stacked directory
        Do While (stack.Count > 0)
            ' Get top directory string
            Dim dir As String = stack.Pop
            Try
                ' Add all immediate file paths
                result.AddRange(Directory.GetFiles(dir, "*.*"))

                ' Loop through all subdirectories and add them to the stack.
                Dim directoryName As String
                For Each directoryName In Directory.GetDirectories(dir)
                    stack.Push(directoryName)
                Next
            Catch ex As Exception
            End Try
        Loop

        ' Return the list
        CombineLists(List, result)
    End Sub

    Sub CombineLists(ByRef ParentList As List(Of String), ByRef ChildList As List(Of String))
        Dim I As Integer = 0
        For I = 0 To ChildList.Count - 1
            Dim S As String = ChildList.Item(I)
            ParentList.Add(S)
        Next
        ChildList.Clear()
    End Sub

    Sub FixFileExtension(ByRef Extension As String)
        Extension = Extension.Trim
        Extension = Extension.ToLower
        If InStr(1, Extension, ".") = 0 Then
            Extension = "." + Extension
        End If
        Do While InStr(1, Extension, ",") > 0
            Mid(Extension, InStr(1, Extension, ","), 1) = "."
        Loop
        Return
    End Sub

    Function isExtIncluded(ByVal fExt As String, ByVal IncludedTypes As ArrayList) As Boolean
        fExt = UCase(fExt)
        If fExt.Length > 1 Then
            fExt = UCase(fExt)
            If Mid(fExt, 1, 1) = "." Then
                Mid(fExt, 1, 1) = " "
                fExt = fExt.Trim
            End If
        End If

        'Dim B As Boolean = False
        If IncludedTypes.Contains("*") Then
            Return True
        ElseIf IncludedTypes.Contains(".*") Then
            Return True
        ElseIf IncludedTypes.Contains(fExt) Then
            Return True
        Else
            Return False
        End If
    End Function

    Function isExtExcluded(ByVal fExt As String, ByVal ExcludedTypes As ArrayList) As Boolean

        fExt = UCase(fExt)
        If fExt.Length > 1 Then
            fExt = UCase(fExt)
            If Mid(fExt, 1, 1) = "." Then
                Mid(fExt, 1, 1) = " "
                fExt = fExt.Trim
            End If
        End If

        'Dim B As Boolean = False

        If ExcludedTypes.Contains("*") Then
            Return True
        ElseIf ExcludedTypes.Contains(".*") Then
            Return True
        ElseIf ExcludedTypes.Contains(fExt) Then
            Return True
        Else
            Return False
        End If

    End Function

    Function commentOutOrderBy(ByVal sTxt As String) As String
        Dim S As String = sTxt
        If S.Trim.Length = 0 Then
            Return ""
        End If
        '** Find the starting point of the order by and start the comment there
        Dim X As Integer = 0
        X = InStr(S, "order by", CompareMethod.Text)
        Dim S1 As String = Mid(S, 1, X - 1)
        Dim S2 As String = Mid(S, X)
        Dim S3 As String = S1 + Environment.NewLine + "  /* " + S2 + "  */"
        S = S3
        Return S
    End Function

    Function CreateMissingDir(ByVal DirFQN As String) As Boolean

        Dim B As Boolean = False
        Dim D As Directory
        If D.Exists(DirFQN) Then
            Return True
        End If
        Try
            D.CreateDirectory(DirFQN)
            Return True
        Catch ex As Exception
            LogThis("ERROR 76.54.32 - Could not create restore directory. " + Environment.NewLine + ex.Message)
            MessageBox.Show("ERROR 76.54.32 - Could not create restore directory. " + Environment.NewLine + Environment.NewLine + "Please verify that you have authority to create this directory." + ex.Message)
            Return False
        Finally
            D = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Function

    Function LoadLicenseFile(ByVal FQN As String) As String
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            MessageBox.Show("Failed to load License file: " + Environment.NewLine + Ex.Message)
            LogThis("clsDatabaseARCH : LoadLicenseFile : 5914 : " + Ex.Message)
            Return False
        End Try
        Return strContents
    End Function

    Sub LogThis(ByVal MSG As String)
        Dim LOG As New clsLogging
        LOG.WriteToArchiveLog(MSG)
        LOG = Nothing
    End Sub

    Function ReadFile(ByVal fName As String) As String
        Dim SR As New IO.StreamReader(fName)
        Dim FullText As String = ""
        Do While Not SR.EndOfStream
            Dim S As String = SR.ReadLine
            FullText = FullText + S + Environment.NewLine
        Loop
        SR.Close()
        Return FullText
    End Function

    Sub WriteFile(ByVal FQN As String, ByVal sText As String)
        Try
            Dim SW As New IO.StreamWriter(FQN)
            Dim S As String = sText.Trim

            If S.Length > 0 Then
                SW.WriteLine(S)
            End If
            SW.Close()
        Catch ex As Exception
            LogThis("clsDMa:WriteFile - " + ex.Message)
        End Try

    End Sub

    Sub ModifyAppConfig(ByVal ServerName As String, ByVal ItemToModify As String)
        Dim AppConfigBody As String = ""
        Dim aPath As String = App_Path()
        Dim AppName As String = aPath + "EcmArchiveSetup.exe.config"

        Dim F As File
        If F.Exists(AppName) Then
            AppConfigBody = ReadFile(AppName)
            If AppConfigBody.Trim.Length > 0 Then
                ApplyAppConfigChange(ServerName, ItemToModify, AppConfigBody)
                If AppConfigBody.Trim.Length > 0 Then
                    WriteFile(AppName, AppConfigBody)
                    SetUserConnectionString(ServerName)
                    SetThesaurusConnectionStringToConfig(ServerName)
                End If
            End If
        End If
    End Sub

    Sub SetUserConnectionString(ByVal ServerName As String)

        Dim sCurr As String = ServerName

        My.Settings("UserDefaultConnString") = "?"
        My.Settings.Save()

        Dim S As String = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")

        '*****************************************************************************
        Dim Str1 As String = ""
        Dim Str2 As String = ""
        Dim NewStr As String = ServerName

        Dim NumberOfCycles As Integer = 0
        Dim I As Integer = 1
        Do While InStr(I, S, "Data Source=", CompareMethod.Text) > 0

            I = InStr(I, S, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, S, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, S, ";", CompareMethod.Text)
            Str1 = Mid(S, 1, I)
            Str2 = Mid(S, J)
            S = Str1 + sCurr + Str2
            NumberOfCycles += 1
            If NumberOfCycles > 50 Then
                Exit Do
            End If
            I = J + 1

        Loop
        '*****************************************************************************

        UTIL.setConnectionStringTimeout(S)
        'S = ENC.AES256DecryptString(S)

        My.Settings.Reload()
        Console.WriteLine(My.Settings("UserDefaultConnString"))
        My.Settings("UserDefaultConnString") = S
        Console.WriteLine(My.Settings("UserDefaultConnString"))
        My.Settings.Save()

    End Sub

    Sub SetThesaurusConnectionStringToConfig(ByVal ServerName As String)

        Dim sCurr As String = ServerName

        My.Settings("UserThesaurusConnString") = "?"
        My.Settings.Save()
        Dim S As String = setThesaurusConnStr()

        '*****************************************************************************
        Dim Str1 As String = ""
        Dim Str2 As String = ""
        Dim NewStr As String = ServerName

        Dim NumberOfCycles As Integer = 0
        Dim I As Integer = 1
        Do While InStr(I, S, "Data Source=", CompareMethod.Text) > 0

            I = InStr(I, S, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, S, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, S, ";", CompareMethod.Text)
            Str1 = Mid(S, 1, I)
            Str2 = Mid(S, J)
            S = Str1 + sCurr + Str2
            NumberOfCycles += 1
            If NumberOfCycles > 50 Then
                Exit Do
            End If
            I = J + 1

        Loop
        '*****************************************************************************

        UTIL.setConnectionStringTimeout(S)
        'S = ENC.AES256DecryptString(S)

        My.Settings.Reload()
        Console.WriteLine(My.Settings("UserDefaultConnString"))
        My.Settings("UserThesaurusConnString") = S
        Console.WriteLine(My.Settings("UserDefaultConnString"))
        My.Settings.Save()

    End Sub

    Sub ApplyAppConfigChange(ByVal ServerName As String, ByVal ItemToModify As String, ByRef AppConFigBody As String)

        If ServerName.Trim.Length = 0 Then
            Return
        End If

        Dim AppText As String = AppConFigBody
        Dim Str1 As String = ""
        Dim Str2 As String = ""
        Dim NewStr As String = ServerName

        Dim NumberOfCycles As Integer = 0
        Dim I As Integer = 1
        Do While InStr(I, AppText, "Data Source=", CompareMethod.Text) > 0
            I = InStr(I, AppText, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, AppText, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, AppText, ";", CompareMethod.Text)
            Str1 = Mid(AppText, 1, I)
            'messagebox.show(Str1)
            Str2 = Mid(AppText, J)
            'messagebox.show(Str2)
            AppText = Str1 + ServerName + Str2
            'messagebox.show(AppText)
            NumberOfCycles += 1
            If NumberOfCycles > 50 Then
                Exit Do
            End If
            I = J + 1
            'Clipboard.Clear()
            'Clipboard.SetText(AppText)
        Loop

        AppConFigBody = AppText

    End Sub

    Public Sub deleteDirectoryFiles(ByVal DirFQN As String)
        Dim FileName As String
        Try
            For Each FileName In System.IO.Directory.GetFiles(DirFQN)
                Try
                    System.IO.File.Delete(FileName)
                Catch ex As System.Exception
                    LOG.WriteToArchiveLog("ERROR 100A clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.")
                End Try
            Next FileName
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 200A :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.")
        End Try

    End Sub

    Function getFileInDir(ByVal DirName As String, ByRef DirFiles As String()) As Integer
        Dim I As Integer = 0

        Try
            ReDim DirFiles(0)
            Dim FileAttributes As String = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo

            Try
                For Each fi In aryFi
                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                    FileAttributes = ""
                    FileAttributes = FileAttributes + fi.Name + "|"
                    FileAttributes = FileAttributes + fi.FullName + "|"
                    FileAttributes = FileAttributes + fi.Length.ToString + "|"
                    FileAttributes = FileAttributes + fi.Extension + "|"
                    FileAttributes = FileAttributes + fi.LastAccessTime.ToString + "|"
                    FileAttributes = FileAttributes + fi.CreationTime.ToString + "|"
                    FileAttributes = FileAttributes + fi.LastWriteTime.ToString
                    If I = 0 Then
                        DirFiles(0) = FileAttributes
                    Else
                        ReDim Preserve DirFiles(I)
                        DirFiles(I) = FileAttributes
                    End If
                    I = I + 1
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("Error 22012: " + ex.Message)
            End Try
        Catch ex As Exception
            LOG.WriteToArchiveLog("Error 22013: " + ex.Message)
        End Try
        Return I
    End Function

#Region "IDisposable Support"
    Private disposedValue As Boolean ' To detect redundant calls

    ' IDisposable
    Protected Overridable Sub Dispose(disposing As Boolean)
        If Not disposedValue Then
            If disposing Then
                ' TODO: dispose managed state (managed objects).
                RemoveHandler currDomain.UnhandledException, AddressOf MYExnHandler
                RemoveHandler Application.ThreadException, AddressOf MYThreadHandler
            End If

            ' TODO: free unmanaged resources (unmanaged objects) and override Finalize() below.
            ' TODO: set large fields to null.
        End If
        disposedValue = True
    End Sub

    ' TODO: override Finalize() only if Dispose(disposing As Boolean) above has code to free unmanaged resources.
    'Protected Overrides Sub Finalize()
    '    ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
    '    Dispose(False)
    '    MyBase.Finalize()
    'End Sub

    ' This code added by Visual Basic to correctly implement the disposable pattern.
    Public Sub Dispose() Implements IDisposable.Dispose
        ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
        Dispose(True)
        ' TODO: uncomment the following line if Finalize() is overridden above.
        ' GC.SuppressFinalize(Me)
    End Sub
#End Region

End Class
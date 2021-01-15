
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
Imports System.Net
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.IO.Directory
Imports System.Security.Permissions
Imports System.Net.Sockets
Imports System.Text.RegularExpressions
Imports System.Text
Imports System.Threading
Imports System.Windows.Application

Public Class clsDma



    Dim WaitingForIP As Boolean = False
    Dim TimeOutSecs As String = "89"
    Dim NbrOfErrors As Integer = 0

    Const MUST_BE_LESS_THAN As Integer = 100000000 '8 decimal digits
    Dim UTIL As New clsUtility
    Dim LOG As New clsLog
    Public IXV1 As Integer = 0
    'Dim DFLT As New clsDefaults

    'Dim owner As IWin32Window
    Private Const BUFFERSIZE As Long = 65535
    Dim GraphicWidth As Long = 0
    Dim GraphicHeight As Long = 0
    Dim GraphicDepth As Long = 0

    ' image type enum
    Private Declare Function URLDownloadToFile Lib "urlmon" _
        Alias "URLDownloadToFileA" (ByVal pCaller As Long, _
        ByVal szURL As String, ByVal szFileName As String, _
        ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

    Dim bb As Boolean = False
    Public TempEnvironDir As String = getEnvVarTempDir()
    Private CurrHostName As String = ""
    Private MachineIP As String = ""

    Dim myIPAddress, MacAddr, x As Net.IPAddress
    Public RetC As Boolean

    Dim gSecureID As string = -1
    Sub New()
        gSecureID = _SecureID
    End Sub

    Public Function ckVar2(ByRef tVal as string) As String
        If tVal = "&nbsp;" Then
            tVal = ""
        End If
        Return tVal
    End Function

    'Public Sub ListDirs(ByRef Dirs$(), ByRef Files$(), ByVal TargetDir as string)
    '    'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
    '    'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
    '    ReDim Dirs$(0)
    '    ReDim Files$(0)
    '    Dim path$ = TargetDir$
    '    Try
    '        If Not Directory.Exists(path) Then
    '            Return
    '        Else
    '            Dirs = Directory.GetDirectories(path)
    '            Files = Directory.GetFiles(path)
    '        End If
    '    Catch ex As Exception
    '        If gDebug Then Console.WriteLine(ex.Source)
    '        If gDebug Then Console.WriteLine(ex.StackTrace)
    '        If gDebug Then Console.WriteLine(ex.Message)
    '        LogThis("clsDma : ListDirs : 52 : " + ex.Message)
    '        LogThis("clsDma : ListDirs : 55 : " + ex.Message)
    '        LogThis("clsDma : ListDirs : 58 : " + ex.Message)
    '    End Try
    'End Sub

    Public Function DownloadWebFile(ByVal WebFqn as string, byval ToFqn as string) As Boolean
        Dim B As Boolean = False
        WebFqn$ = "http://www.vb-helper.com/vbhelper_425_64.gif"
        ToFqn$ = gTempDir + "\vbhelper_425_64.gif"

        Try
            URLDownloadToFile(0, WebFqn$, ToFqn$, 0, 0)
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
        'shostname = Application.Current.Host.Source.Host
        shostname = System.Net.Dns.GetHostName
        CurrHostName = shostname
    End Sub

    Public Function getHostname() As String
        If CurrHostName = "" Then
            setHostName()
        End If
        Return CurrHostName
    End Function

    'Public Sub setIPAddr()

    '    Dim s As String = ""
    '    Dim dd As Boolean = False
    '    Dim server As String
    '    'server = System.Net.Dns.GetHostName
    '    server = Application.Current.Host.Source.Host
    '    Try
    '        Dim ASCII As New System.Text.UnicodeEncoding()

    '        ' Get server related information.
    '        Dim heserver As IPHostEntry = Dns.GetHostEntry(server)

    '        ' Loop on the AddressList
    '        Dim curAdd As IPAddress
    '        For Each curAdd In heserver.AddressList

    '            ' Display the type of address family supported by the server. If the
    '            ' server is IPv6-enabled this value is: InternNetworkV6. If the server
    '            ' is also IPv4-enabled there will be an additional value of InterNetwork.
    '            '** Console.WriteLine(("AddressFamily: " + curAdd.AddressFamily.ToString()))
    '            s = "AddressFamily: " & curAdd.AddressFamily.ToString()
    '            If gDebug Then Console.WriteLine(s)

    '            ' Display the ScopeId property in case of IPV6 addresses.
    '            If curAdd.AddressFamily.ToString() = ProtocolFamily.InterNetworkV6.ToString() Then
    '                s = "Scope Id: " + curAdd.ScopeId.ToString()
    '                If gDebug Then
    '                    If gDebug Then Console.WriteLine(s)
    '                End If
    '            End If

    '            ' Display the server IP address in the standard format. In 
    '            ' IPv4 the format will be dotted-quad notation, in IPv6 it will be
    '            ' in in colon-hexadecimal notation.
    '            s = "Address: " + curAdd.ToString()
    '            s = curAdd.ToString()
    '            Console.WriteLine(s)
    '            If isFourPartIP(s) Then
    '                MachineIP = s
    '                Exit For
    '            End If
    '            ' Display the server IP address in byte format.
    '            'Console.Write("AddressBytes: ")
    '            's = ""
    '            'Dim bytes As [Byte]() = curAdd.GetAddressBytes()
    '            'Dim i As Integer
    '            'For i = 0 To bytes.Length - 1
    '            '    Console.Write(bytes(i))
    '            '    s = s + bytes(i).ToString
    '            'Next i
    '            'Console.WriteLine(ControlChars.Cr + ControlChars.Lf)
    '            'Console.WriteLine(s)
    '        Next curAdd

    '    Catch e As Exception
    '        If gDebug Then Console.WriteLine(("[DoResolve] Exception: " + e.ToString()))
    '        LogThis("clsDma : setIPAddr : 87 : " + e.Message)
    '        LogThis("clsDma : setIPAddr : 92 : " + e.Message)
    '        LogThis("clsDma : setIPAddr : 97 : " + e.Message)
    '    End Try

    '    MachineIP = s

    'End Sub

    Function isFourPartIP(ByVal IP as string) As Boolean
        If InStr(IP, ":") > 0 Then
            Return False
        End If
        Dim A$() = IP.Split(".")
        If A.Length = 4 Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function getEnvVarTempDir() As String

        Dim td As String = ""
        Dim ISO As New clsIsolatedStorage
        td = ISO.getTempDir
        ISO = Nothing
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
        Dim CH$ = ""
        Dim S As String = tVal

        S.Replace("/", ".")
        S.Replace(":", ".")

        For i = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz-@$.", CH, CompareMethod.Text)
            If j = 0 Then
                tVal = RemoveChar(tVal$, CH)
            End If
        Next

        Return S

    End Function

    Public Function RemoveChar(ByVal tVal as string, byval CharToRemove as string) As String

        Dim i As Integer = Len(tVal)
        Dim A$()
        Dim S as string = ""
        A = tVal.Split(CharToRemove)
        For i = 0 To UBound(A)
            Dim Token = A(i).ToString
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
        tVal.Replace("^", ".")
        Return tVal
    End Function

    Public Function ReplaceChar(ByVal InputString As String, ByVal CharToReplace As String, ByVal ReplaceWith As String) As String
        Dim S As String = InputString
        S.Replace(CharToReplace, ReplaceWith)
        Return S
    End Function

    'Public Function GetFileName(ByVal FQN as string) As String
    '    Dim fn$ = ""

    '    Dim i# = 0
    '    Dim j# = 0
    '    Dim ch$ = ""
    '    For i = Len(FQN) To 1 Step -1
    '        ch = Mid(FQN, i, 1)
    '        If ch = "\" Then
    '            fn = Mid(FQN, i + 1)
    '            Exit For
    '        End If
    '        If ch = "/" Then
    '            fn = Mid(FQN, i + 1)
    '            Exit For
    '        End If
    '    Next
    '    If fn = "" And FQN.Length > 0 Then
    '        Return FQN
    '    Else
    '        Return fn
    '    End If

    'End Function

    Public Function GetFilePath(ByVal FQN As String) As String

        Dim fn$ = ""

        Try

            Dim i# = 0
            Dim j# = 0
            Dim ch$ = ""
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
            LOG.WriteToSqlLog("ERROR clsDma:GetFilePath: Could not get file path - " + ex.Message + Environment.NewLine + ex.StackTrace)
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

    Public Function getHelpFile() As String
        Dim URL As String
        URL = "WDM URL.hlp"
        '**WDM getHelpFile = App.Path & App.EXEName & ".HLP"
        getHelpFile = URL
    End Function

    '** Gets and returns a registry value for the current UserID
    'Public Function CapiInterface(ByVal Key1 As String, ByVal Key2 As String) As String

    '    Dim s As String = ""
    '    Dim rkCurrentUser As RegistryKey = Registry.CurrentUser
    '    Dim rkTest As RegistryKey = rkCurrentUser.OpenSubKey(Key1 + ":" + Key2)

    '    If rkTest Is Nothing Then
    '        s = ""
    '    Else
    '        s = rkTest.GetValue(Key1 + ":" + Key2)
    '        rkTest.Close()
    '        rkCurrentUser.Close()
    '    End If

    '    Return s

    'End Function

    ''** Sets a registry value for the current UserID
    'Public Function CApiSetLocalIniValue(ByVal Key1 As String, ByVal Key2 As String, ByVal SuppliedVal As String) As String
    '    Dim RegistryKey As String = Key1 + ":" + Key2
    '    'RegistryKey = Key1 + ":" + Key2
    '    Dim rkTest As RegistryKey = Registry.CurrentUser.OpenSubKey("RegistryOpenSubKeyExample", True)
    '    If rkTest Is Nothing Then
    '        Dim rk As RegistryKey = Registry.CurrentUser.CreateSubKey("RegistryOpenSubKeyExample")
    '        rk.Close()
    '    Else
    '        rkTest.SetValue(RegistryKey, SuppliedVal)
    '        '        Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
    '        rkTest.Close()
    '    End If
    '    Return SuppliedVal
    'End Function

    ' Modify a phone-number to the format "XXX-XXXX" or "(XXX) XXX-XXXX".
    Function xFormatPhoneNumber(ByVal text As String) As String
        Dim i As Long
        ' ignore empty strings
        If Len(text) = 0 Then
            Return ""
        End If
        ' get rid of dashes and invalid chars
        For i = Len(text) To 1 Step -1
            If InStr("0123456789", Mid$(text, i, 1)) = 0 Then
                text = Mid(text, 1, i - 1) & Mid$(text, i + 1)
            End If
        Next
        ' then, re-insert them in the correct position
        If Len(text) <= 7 Then
            Return Format$(text, "!@@@-@@@@")
        Else
            Return Format$(text, "!(@@@) @@@-@@@@")
        End If
    End Function

    Public Sub GetIPAddress(ByRef myIPAddress As Net.IPAddress)
        'This sub will get all IP addresses, the first one should be the adapters MAC
        'address, the second one the IP Address when connected to the internet.

        Debug.Print("myIPAddress2", myIPAddress.ToString())

    End Sub

    Public Function ckVar(ByRef sText As String) As String
        Dim i As Integer = 0
        Dim j As Integer = 0
        If sText$ = "&nbsp;" Then
            sText$ = ""
            Return sText$
        End If

        sText = ReplaceOccr(sText, "&gt", "<")
        sText = ReplaceOccr(sText, "&Lt", ">")
        sText = ReplaceOccr(sText, "&nbsp;", " ")

        sText = UTIL.RemoveSingleQuotes(sText)

        Return sText$
    End Function

    Private Function ReplaceOccr(ByVal tStr As String, ByVal TgtStr As String, ByVal ReplacementStr As String) As String
        Dim S1$ = ""
        Dim S2$ = ""
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

    Public Function SaveFile(ByVal sFileName As String, _
           ByVal bytFileByteArr As Byte()) As Integer

        ' Saves a file with no file extension

        ' Get the file name and set a new path 
        ' to the local storage folder
        Dim strFile As String = _
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
        Dim MimeTypes$ = "application/andrew-inset | ez,application/mac-binhex40 | hqx,application/mac-compactpro | cpt,application/msword | doc,application/octet-stream | bin,application/octet-stream | dms,application/octet-stream | lha,application/octet-stream | lzh,application/octet-stream | exe,application/x-rar-compressed | rar,application/octet-stream | class,application/octet-stream | so,application/octet-stream | dll,application/oda | oda,application/pdf | pdf,application/postscript | ai,application/postscript | eps,application/postscript | ps,application/smil | smi,application/smil | smil,application/vnd.mif | mif,application/vnd.ms-excel | xls,application/vnd.ms-powerpoint | ppt,application/vnd.wap.wbxml | wbxml,application/vnd.wap.wmlc | wmlc,application/vnd.wap.wmlscriptc | wmlsc,application/x-bcpio | bcpio,application/x-cdlink | vcd,application/x-chess-pgn | pgn,application/x-cpio | cpio,application/x-csh | csh,application/x-director | dcr,application/x-director | dir,application/x-director | dxr,application/x-dvi | dvi,application/x-futuresplash | spl,application/x-gtar | gtar,application/x-hdf | hdf,application/x-javascript | js,application/x-koan | skp,application/x-koan | skd,application/x-koan | skt,application/x-koan | skm,application/x-latex | latex,application/x-netcdf | nc,application/x-netcdf | cdf,application/x-sh | sh,application/x-shar | shar,application/x-shockwave-flash | swf,application/x-stuffit | sit,application/x-sv4cpio | sv4cpio,application/x-sv4crc | sv4crc,application/x-tar | tar,application/x-tcl | tcl,application/x-tex | tex,application/x-texinfo | texinfo,application/x-texinfo | texi,application/x-troff | t,application/x-troff | tr,application/x-troff | roff,application/x-troff-man | man,application/x-troff-me | me,application/x-troff-ms | ms,application/x-ustar | ustar,application/x-wais-source | src,application/xhtml+xml | xhtml,application/xhtml+xml | xht,application/zip | zip,audio/basic | au,audio/basic | snd,audio/midi | mid,audio/midi | midi,audio/midi | kar,audio/mpeg | mpga,audio/mpeg | mp2,audio/mpeg | mp3,audio/x-aiff | aif,audio/x-aiff | aiff,audio/x-aiff | aifc,audio/x-mpegurl | m3u,audio/x-pn-realaudio | ram,audio/x-pn-realaudio | rm,audio/x-pn-realaudio-plugin | rpm,audio/x-realaudio | ra,audio/x-wav | wav,chemical/x-pdb | pdb,chemical/x-xyz | xyz,image/bmp | bmp,image/gif | gif,image/ief | ief,image/jpeg | jpeg,image/jpeg | jpg,image/jpeg | jpe,image/png | png,image/tiff | tiff,image/tiff | tif,image/vnd.djvu | djvu,image/vnd.djvu | djv,image/vnd.wap.wbmp | wbmp,image/x-cmu-raster | ras,image/x-portable-anymap | pnm,image/x-portable-bitmap | pbm,image/x-portable-graymap | pgm,image/x-portable-pixmap | ppm,image/x-rgb | rgb,image/x-xbitmap | xbm,image/x-xpixmap | xpm,image/x-xwindowdump | xwd,model/iges | igs,model/iges | iges,model/mesh | msh,model/mesh | mesh,model/mesh | silo,model/vrml | wrl,model/vrml | vrml,text/css | css,text/html | html,text/html | htm,text/plain | asc,text/plain | txt,text/richtext | rtx,text/rtf | rtf,text/sgml | sgml,text/sgml | sgm,text/tab-separated-values | tsv,text/vnd.wap.wml | wml,text/vnd.wap.wmlscript | wmls,text/x-setext | etx,text/xml | xsl,text/xml | xml,video/mpeg | mpeg,video/mpeg | mpg,video/mpeg | mpe,video/quicktime | qt,video/quicktime | mov,video/vnd.mpegurl | mxu,video/x-msvideo | avi,video/x-sgi-movie | movie,x-conference/x-cooltal | ice"
        Dim A$() = Split(MimeTypes, ",")
        Dim I As Integer = 0
        Dim Classification$ = ""
        Dim TgtMime$ = ""
        For I = 0 To UBound(A)
            Dim b$() = Split(A(I), "|")
            Classification$ = b(0).Trim
            Dim tMime$ = b(1).Trim
            If StrComp(FileSuffix, tMime, CompareMethod.Text) = 0 Then
                TgtMime$ = tMime
                Exit For
            End If
        Next
        Return Classification$
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

    '    Function getFilesInDir(ByVal DirName as string, byref DirFiles$(), ByVal IncludedTypes As ArrayList, ByVal ExcludedTypes As ArrayList, ByVal ckArchiveFlag As Boolean) As Integer
    '        Dim I As Integer = UBound(DirFiles)
    '        Dim iFilesAdded As Integer = 0
    '        Dim xFileName$ = ""
    '        Try
    '            Dim FileAttributes = ""

    '            Dim strFileSize As String = ""
    '            Dim iFileSize As Integer = 0
    '            Dim di As New IO.DirectoryInfo(DirName)
    '            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
    '            Dim fi As IO.FileInfo

    '            Try
    '                For Each fi In aryFi

    '                    'If DirName$.Equals("D:\dev\ECM\EcmLibrary\Documentation") Or DirName$.Equals("D:\dev\ECM\EcmLibrary\Documentation") Then
    '                    '    Dim tMsg$ = "Files in: " + DirName$ + " : " + fi.Name
    '                    '    WriteToArchiveFileTraceLog(tMsg$, False)
    '                    'End If

    '                    Dim fExt$ = fi.Extension
    '                    If InStr(fi.FullName, ".") = 0 Then
    '                        LogThis("Warning: File '" + fi.Name + "' has no extension, skipping.")
    '                        GoTo NextFile
    '                    End If
    '                    If fExt.Length = 0 Then
    '                        fExt = getFileExtension(fi.FullName)
    '                    End If
    '                    FixFileExtension(fExt as string)

    '                    Dim bbExt As Boolean = isExtIncluded(fExt$, IncludedTypes)
    '                    If Not bbExt Then
    '                        GoTo NextFile
    '                    End If

    '                    bbExt = isExtExcluded(fExt$, ExcludedTypes)
    '                    If bbExt Then
    '                        GoTo NextFile
    '                    End If
    '                    If ckArchiveFlag = True Then
    '                        Dim bArch As Boolean = Me.isArchiveBitOn(fi.FullName)
    '                        If bArch = False Then
    '                            'This file does not need to be archived
    '                            GoTo NextFile
    '                        End If
    '                    End If

    '                    xFileName$ = fi.FullName

    '                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
    '                    FileAttributes = ""
    '                    FileAttributes = FileAttributes + fi.Name + "|"
    '                    FileAttributes = FileAttributes + fi.FullName + "|"
    '                    FileAttributes = FileAttributes + fi.Length.ToString + "|"
    '                    FileAttributes = FileAttributes + fi.Extension + "|"

    '                    Dim xdate As Date = fi.LastAccessTime
    '                    Dim sDate As String = UTIL.ConvertDate(xdate)

    '                    FileAttributes = FileAttributes & xdate & "|"

    '                    xdate = fi.CreationTime
    '                    sDate = UTIL.ConvertDate(xdate)
    '                    FileAttributes = FileAttributes & xdate & "|"

    '                    xdate = fi.LastWriteTime
    '                    sDate = UTIL.ConvertDate(xdate)
    '                    FileAttributes = FileAttributes & xdate

    '                    If I = 0 Then
    '                        DirFiles(0) = FileAttributes
    '                        iFilesAdded += 1
    '                    Else
    '                        ReDim Preserve DirFiles(UBound(DirFiles) + 1)
    '                        DirFiles(UBound(DirFiles)) = FileAttributes
    '                        iFilesAdded += 1
    '                    End If
    'NextFile:
    '                    I = I + 1
    '                Next
    '            Catch ex As Exception
    '                LogThis("ERROR - clsDma : getFilesInDir : 22012c : " + ex.Message + Environment.NewLine + "DIR: " + DirName$ + Environment.NewLine + "FILE: " + fi.Name)
    '            End Try

    '        Catch ex As Exception
    '            'MsgBox("Error 22013: " + ex.Message)
    '            NbrOfErrors += 1
    '            '''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
    '            LogThis("clsDma : getFilesInDir : 471 : " + ex.Message)
    '        End Try
    '        Return iFilesAdded
    '    End Function

    'Function getFileInDir(ByVal DirName as string, byref DirFiles$()) As Integer
    '    Dim I As Integer = 0

    '    Try
    '        ReDim DirFiles(0)
    '        Dim FileAttributes = ""

    '        Dim strFileSize As String = ""
    '        Dim iFileSize As Integer = 0
    '        Dim di As New IO.DirectoryInfo(DirName)
    '        Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
    '        Dim fi As IO.FileInfo

    '        Try
    '            For Each fi In aryFi
    '                strFileSize = (Math.Round(fi.Length / 1024)).ToString()
    '                FileAttributes = ""
    '                FileAttributes = FileAttributes + fi.Name + "|"
    '                FileAttributes = FileAttributes + fi.FullName + "|"
    '                FileAttributes = FileAttributes + fi.Length.ToString + "|"
    '                FileAttributes = FileAttributes + fi.Extension + "|"
    '                FileAttributes = FileAttributes + fi.LastAccessTime.ToString + "|"
    '                FileAttributes = FileAttributes + fi.CreationTime.ToString + "|"
    '                FileAttributes = FileAttributes + fi.LastWriteTime.ToString
    '                If I = 0 Then
    '                    DirFiles(0) = FileAttributes
    '                Else
    '                    ReDim Preserve DirFiles(I)
    '                    DirFiles(I) = FileAttributes
    '                End If
    '                I = I + 1
    '            Next
    '        Catch ex As Exception
    '            MsgBox("Error 22012a: " + ex.Message)
    '            LogThis("clsDma : getFileInDir : 480 : " + ex.Message)
    '            LogThis("clsDma : getFileInDir : 491 : " + ex.Message)
    '            LogThis("clsDma : getFileInDir : 502 : " + ex.Message)
    '        End Try

    '    Catch ex As Exception
    '        MsgBox("Error 22013: " + ex.Message)
    '        LogThis("clsDma : getFileInDir : 481 : " + ex.Message)
    '        LogThis("clsDma : getFileInDir : 493 : " + ex.Message)
    '        LogThis("clsDma : getFileInDir : 505 : " + ex.Message)
    '    End Try
    '    Return I
    'End Function

    Public Function getFilesInDir(ByVal DirName As String, ByRef DirFiles() As String, ByVal ExactFileName As String) As Integer

        DirName = UTIL.RemoveSingleQuotes(DirName)
        ExactFileName = UTIL.RemoveSingleQuotes(ExactFileName)

        Dim I As Integer = 0
        Dim FQN As String = DirName$ + "\" + ExactFileName
        Try
            ReDim DirFiles(0)
            Dim FileAttributes = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim fInfo As New IO.FileInfo(DirName + "\" + ExactFileName)
            'Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName as string)
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

                If I = 0 Then
                    DirFiles(0) = FileAttributes
                Else
                    ReDim Preserve DirFiles(I)
                    DirFiles(I) = FileAttributes
                End If
                I = I + 1
                'Next
            Catch ex As Exception
                LogThis("clsDma : getFilesInDir : 508 : " + ex.Message)
                LogThis("clsDma : getFilesInDir : 521 : " + ex.Message)
                LogThis("clsDma : getFilesInDir : 534 : " + ex.Message)
            End Try

        Catch ex As Exception
            LogThis("clsDma : getFilesInDir : 509 : " + ex.Message)
            LogThis("clsDma : getFilesInDir : 523 : " + ex.Message)
            LogThis("clsDma : getFilesInDir : 537 : " + ex.Message)
        End Try
        Return I
    End Function

    Sub ReplaceStar(ByRef tVal As String)
        If InStr(tVal, "*") = 0 Then
            Return
        End If
        tVal = tVal.Replace("*", "%")
    End Sub
    Sub ReplaceSingleTick(ByRef tVal As String)
        tVal = tVal.Trim
        Dim CH$ = ""
        If InStr(tVal, "'") = 0 Then
            Return
        End If
        tVal = tVal.Replace("'", "`")
    End Sub

    Sub GetStartAndStopDate(ByRef StartDate As Date, ByRef EndDate As Date)
        '5/14/2009 12:00:00 AM' 
        Dim S1 As String = StartDate.ToString
        Dim S2 As String = EndDate.ToString

        S2 = S2.Replace("12:00:00 AM", "11:59:59 PM")

        StartDate = CDate(S1)
        EndDate = CDate(S2)


    End Sub

    Function ckQryDate(ByVal StartDate As String, ByVal EndDate As String, ByVal Evaluator As String, ByVal DbColName As String, ByRef FirstTime As Boolean) As String

        '** Set to false by WDM on 3/10/2010 to allow for parens and the AND operator
        FirstTime = False

        Dim S As String = ""
        Dim CH$ = ""
        Dim WhereClause$ = ""
        If UCase(Evaluator).Equals("OFF") Then
            Return WhereClause$
        Else
            If Evaluator$.Equals("OFF") Then
                Return WhereClause$
            ElseIf Evaluator$.Equals("After") Then
                If FirstTime Then
                    WhereClause$ = " " + DbColName + " > '" + CDate(StartDate).ToString + "'" + Environment.NewLine
                    FirstTime = False
                Else
                    WhereClause$ = " AND (" + DbColName + " > '" + CDate(StartDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator$.Equals("Before") Then
                If FirstTime Then
                    WhereClause$ = " " + DbColName + " < '" + CDate(StartDate).ToString + "'" + Environment.NewLine
                    FirstTime = False
                Else
                    WhereClause$ = " AND (" + DbColName + " < '" + CDate(StartDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator$.Equals("Between") Then
                GetStartAndStopDate(StartDate$, EndDate)
                'select * from Production.Product where Sellcdate(StartDate).tostring between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "' " + Environment.NewLine
                Else
                    WhereClause$ = " AND (" + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator$.Equals("Not Between") Then
                GetStartAndStopDate(StartDate$, EndDate)
                'select * from Production.Product where SellStartDate between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "'" + Environment.NewLine
                Else
                    WhereClause$ = " AND (" + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            ElseIf Evaluator$.Equals("On") Then
                GetStartAndStopDate(StartDate$, EndDate)
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "'" + Environment.NewLine
                Else
                    WhereClause$ = " AND (" + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + Environment.NewLine
                End If
            Else
                Return WhereClause$
            End If

        End If
        Return WhereClause$
    End Function

    Sub AddSlashToDirName(ByRef tDir As String)

        If tDir$.Trim.Length = 0 Then
            Return
        End If

        Dim I As Integer = 0
        tDir = tDir.Trim
        I = tDir.Length
        Dim CH$ = Mid(tDir, I, 1)
        If CH = "\" Then
            Return
        Else
            tDir = tDir + "\"
        End If

    End Sub

    'Sub ListRegistryKeys(ByVal FileExt as string, byref LB As List(Of String))
    '    Try
    '        Dim rootKey As RegistryKey
    '        rootKey = Registry.ClassesRoot
    '        Dim S as string

    '        Dim regSubKey As RegistryKey

    '        Dim subk As String

    '        Dim tmp As RegistryKey
    '        rootKey = rootKey.OpenSubKey(FileExt, False)
    '        Debug.Print(rootKey.GetValue("").ToString())
    '        Debug.Print(rootKey.GetValue("Content Type").ToString())

    '        Dim ControlApp$ = rootKey.GetValue("Content Type").ToString()

    '        LB.Add("Content Type: " + rootKey.GetValue("Content Type").ToString())

    '        For Each subk In rootKey.GetSubKeyNames()
    '            'MessageBox.Show(subk)
    '            S = subk + " : "
    '            tmp = rootKey.OpenSubKey(subk)
    '            S = tmp.ToString
    '            LB.Add(S)
    '        Next
    '    Catch ex As Exception
    '        Debug.Print(ex.Message)
    '        LogThis("clsDma : ListRegistryKeys : 595 : " + ex.Message)
    '        LogThis("clsDma : ListRegistryKeys : 610 : " + ex.Message)
    '        LogThis("clsDma : ListRegistryKeys : 625 : " + ex.Message)
    '    End Try

    'End Sub

    'Function GetCurrUserName() As String
    '    Dim S as string = ""
    '    S = Environment.UserName.ToString
    '    Return S
    'End Function

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
        S = Environment.CurrentDirectory.ToString
        Return S
    End Function

    Function GetCurrUptime() As String
        Dim S As String = ""
        S = Mid((Environment.TickCount / 3600000), 1, 5) & " :Hours"
        Return S
    End Function

    Function GetCurrMachineName() As String
        Dim S As String = ""
        S = Environment.MachineName
        Return S
    End Function

    Function GetCurrentDirectory() As String
        Dim S As String = ""
        S = Environment.CurrentDirectory.ToString
        Return S
    End Function

    'Function GetUserDomainName() As String
    '    Dim S as string = ""
    '    S = Environment.UserDomainName.ToString
    '    Return S
    'End Function

    'Function GetWorkingSet() As String
    '    Dim S as string = ""
    '    S = Environment.WorkingSet.ToString
    '    Return S
    'End Function

    'Function isFileArchiveAttributeSet(ByVal FQN as string) As Boolean

    '    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
    '    'Console.WriteLine(fileDetail.IsReadOnly)
    '    Dim A As Integer = fileDetail.Attributes.Archive
    '    Dim R As Integer = fileDetail.Attributes.ReadOnly
    '    Dim H As Integer = fileDetail.Attributes.Hidden
    '    Dim C As Integer = fileDetail.Attributes.Compressed
    '    Dim D As Integer = fileDetail.Attributes.Directory
    '    Dim E As Integer = fileDetail.Attributes.Encrypted
    '    Dim N As Integer = fileDetail.Attributes.Normal
    '    Dim NCI As Integer = fileDetail.Attributes.NotContentIndexed
    '    Dim OL As Integer = fileDetail.Attributes.Offline
    '    Dim S As Integer = fileDetail.Attributes.System
    '    Dim T As Integer = fileDetail.Attributes.Temporary

    '    'Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))

    '    If (fileDetail.Attributes And fileDetail.Attributes.Archive) = fileDetail.Attributes.Archive Then
    '        'MessageBox.Show(fileDetail.Name & " is Archived")
    '        Return False
    '    Else
    '        'MessageBox.Show(fileDetail.Name & " is NOT Archived")
    '        Return True
    '    End If

    'End Function

    'Function setFileArchiveAttributeSet(ByVal FQN as string, byval SetOn As Boolean) As Boolean

    '    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)

    '    If SetOn = True Then
    '        fileDetail.Attributes = fileDetail.Attributes And fileDetail.Attributes.Archive
    '    Else
    '        fileDetail.Attributes = fileDetail.Attributes And Not fileDetail.Attributes.Archive
    '    End If

    'End Function

    'Function setFileArchiveBitOn(ByVal FQN as string) As Boolean
    '    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
    '    fileDetail.Attributes = fileDetail.Attributes + fileDetail.Attributes.Archive
    'End Function

    'Function setFileArchiveBitOff(ByVal FQN as string) As Boolean
    '    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
    '    fileDetail.Attributes = fileDetail.Attributes - fileDetail.Attributes.Archive
    'End Function
    ''WDM This could be a problem 
    'Function ToggleArchiveBit(ByVal filespec as string) As Boolean

    '    filespec$ = UTIL.ReplaceSingleQuotes(filespec as string)

    '    Try
    '        Dim fso, f
    '        fso = CreateObject("Scripting.FileSystemObject")
    '        f = fso.GetFile(filespec)

    '        If f.attributes And 32 Then
    '            f.attributes = f.attributes - 32
    '            'ToggleArchiveBit = "Archive bit is cleared."
    '            Return True
    '        Else
    '            f.attributes = f.attributes + 32
    '            'ToggleArchiveBit = "Archive bit is set."
    '            Return False
    '        End If
    '    Catch ex As Exception
    '        LogThis("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
    '        Return False
    '    End Try
    'End Function

    'Function isArchiveBitOn(ByVal filespec as string) As Boolean

    '    'Dim skipThis As Boolean = True
    '    'If skipThis = True Then
    '    'Return False
    '    'End If

    '    Dim B As Boolean = False

    '    Try

    '        Dim MyAttr As FileAttribute
    '        ' Assume file TESTFILE is normal and readonly.
    '        MyAttr = GetAttr(filespec as string)   ' Returns vbNormal.
    '        'Dim iAttr As Integer = GetAttr(filespec)

    '        ' Test for Archived.
    '        If (MyAttr And FileAttribute.Archive) = FileAttribute.Archive Then
    '            'If (MyAttr And FileAttribute.Archive) = 1 Then
    '            'The "A" is showing.
    '            Return True
    '        Else
    '            Return False
    '        End If

    '        'Feb 7, 2010 - Set the above code in place and removed the following - WDM
    '        'Dim fso, f
    '        'fso = CreateObject("Scripting.FileSystemObject")
    '        'f = fso.GetFile(filespec)

    '        'If f.attributes And 32 Then
    '        '    'f.attributes = f.attributes - 32
    '        '    'ToggleArchiveBit = "Archive bit is cleared."
    '        '    B = True
    '        'Else
    '        '    'f.attributes = f.attributes + 32
    '        '    'ToggleArchiveBit = "Archive bit is set."
    '        '    B = False
    '        'End If
    '    Catch ex As Exception
    '        LOG.WriteToSqlLog("Warning: clsDMa:isArchiveBitOn 100 - " + ex.Message)
    '        B = False
    '    End Try

    '    Return B
    'End Function

    'Function setArchiveBitOff(ByVal filespec as string) As Boolean

    '    Dim B As Boolean = False
    '    filespec$ = UTIL.ReplaceSingleQuotes(filespec as string)

    '    Try
    '        ''Dim MyAttr As FileAttribute
    '        ''' Assume file TESTFILE is normal and readonly.
    '        ''MyAttr = GetAttr(filespec as string)   ' Returns vbNormal.
    '        'If F.Exists(filespec) Then
    '        '    F.SetAttributes(filespec, FileAttributes.Archive)
    '        '    'SetAttr(filespec$, FileAttribute.Archive)
    '        'End If

    '        Dim f As New FileInfo(filespec as string)
    '        f.Attributes = f.Attributes And Not FileAttributes.Archive
    '        f = Nothing

    '        'SetAttr(filespec$, FileAttribute.Archive)
    '        'B = True
    '    Catch ex As Exception
    '        LOG.WriteToSqlLog("Warning: clsDMa:setArchiveBitOn 100 - " + ex.Message)
    '        B = False
    '    End Try

    '    Return B
    'End Function

    'Public Sub smoLoadServers(ByRef CB As List(Of String))

    '    Dim dt As DataTable = SmoApplication.EnumAvailableSqlServers(False)
    '    Dim ServersFound As Boolean = False

    '    If dt.Rows.Count > 0 Then
    '        For Each dr As DataRow In dt.Rows
    '            ServersFound = True
    '            If gDebug Then Console.WriteLine(dr("Name"))
    '            CB.Add(dr("Name"))
    '        Next
    '    End If
    '    If Not ServersFound Then
    '        CB.Add("NO SQL SERVERS FOUND")
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
    '        CB.Add(oNames.Item(i))
    '    Next i
    '    If oNames.Count = 0 Then
    '        CB.Add("NO SQL SERVERS FOUND")
    '    End If
    'End Sub



    'Public Sub LoadDatabases(ByVal ServerName as string, byval UserID as string, byval PW as string, byref CB As Windows.Forms.ComboBox)
    '    Dim oSQLServer As New SQLDMO.SQLServer
    '    Dim i As Integer
    '    CB.Items.Clear()
    '    Try
    '        If UserID = "" And PW = "" Then
    '            oSQLServer.LoginSecure = True
    '        End If
    '        oSQLServer.Connect(ServerName, UserID, PW)
    '        For i = 1 To oSQLServer.Databases.Count
    '            Dim dbName$ = oSQLServer.Databases.Item(i).Name.ToString
    '            CB.Add(dbName)
    '        Next i
    '    Catch ex As Exception
    '        CB.Items.Clear()
    '        CB.Add(ex.Message.Trim)
    '    End Try
    'End Sub

    Public Function formatTextSearch(ByVal SearchString As String) As String
        If SearchString.Trim.Length = 0 Then
            Return ""
        End If
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim CH$ = ""
        Dim currWord$ = ""
        Dim prevWord$ = ""
        Dim prevWordIsKeyWord As Boolean = False
        Dim currWordIsKeyWord As Boolean = False
        Dim tStack As New List(Of String)
        Dim aList As New List(Of String)

        SearchString = SearchString.Replace(" ", ChrW(254))
        For I = 1 To SearchString.Length
            CH = Mid(SearchString, I, 1)
            If CH = ChrW(34) Then
                I = I + 1
                CH = Mid(SearchString, I, 1)
                Do While CH <> ChrW(34) And I < SearchString.Length
                    I = I + 1
                    CH = Mid(SearchString, I, 1)
                Loop
                'ElseIf CH = " " Then
                '    Mid(SearchString, I, 1) = ChrW(254)
            End If
        Next

        Dim NewText As New List(Of String)
        Dim A$() = SearchString.Split(ChrW(254))
        For I = 0 To UBound(A)
            currWord = A(I)
            currWordIsKeyWord = ckKeyWord(currWord)
            prevWordIsKeyWord = ckKeyWord(prevWord)
            If gDebug Then Console.WriteLine(SearchString)
            If gDebug Then Console.WriteLine(currWord, currWordIsKeyWord)
            If gDebug Then Console.WriteLine(currWord, prevWordIsKeyWord)
            If currWordIsKeyWord = False And prevWordIsKeyWord = False Then
                If prevWord.Trim.Length > 0 And currWord.Trim.Length > 0 Then
                    Dim CH1$ = Mid(currWord, 1, 1)
                    If CH1.Equals(ChrW(34)) Then
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
        Dim ReformattedSearch$ = ""
        For I = 0 To NewText.Count - 1
            Dim isContainsDoubleQuote As Boolean = False
            Dim isContainsStar As Boolean = False
            Dim tWord As String = NewText.Item(I).ToString
            If InStr(tWord, "*") > 0 Then
                isContainsStar = True
            End If
            If InStr(tWord, ChrW(34)) > 0 Then
                isContainsDoubleQuote = True
            End If
            If isContainsDoubleQuote = False And isContainsStar = True Then
                '** Wrap this word in double quotes
                tWord = tWord.Trim
                tWord = ChrW(34) + tWord + ChrW(34)
            End If
            ReformattedSearch$ += tWord + " "
        Next
        Return ReformattedSearch$
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
            Dim A$() = Split(S, " ")
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

    'Public Function getDebug(ByVal FormID as string) As Boolean
    '    Dim bUseConfig As Boolean = True
    '    Dim S as string = ""
    '    Dim B As Boolean = False

    '    Try
    '        FormID = "debug_" + FormID
    '        S = System.Configuration.ConfigurationManager.AppSettings(FormID as string)
    '        If S.Equals("0") Then
    '            B = False
    '        ElseIf S.Equals("1") Then
    '            B = True
    '        ElseIf S.Equals("-1") Then
    '            B = True
    '        ElseIf UCase(S).Equals("TRUE") Then
    '            B = True
    '        ElseIf UCase(S).Equals("FALSE") Then
    '            B = False
    '        End If
    '    Catch ex As Exception
    '        B = False
    '        LogThis("clsDma : getDebug : 928 : " + ex.Message)
    '        LogThis("clsDma : getDebug : 953 : " + ex.Message)
    '        LogThis("clsDma : getDebug : 971 : " + ex.Message)
    '    End Try

    '    Return B

    'End Function

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

        Return S$

    End Function

    'Public Function App_Path() As String
    '    Return System.AppDomain.CurrentDomain.BaseDirectory()
    'End Function

    'Public Function setHelpDir(ByVal HelpFile as string) As String
    '    Dim tDir$ = App_Path()
    '    tDir$ = tDir$ + "HelpFiles\" + HelpFile
    '    Return tDir
    'End Function

    'Function isConnected() As Boolean
    '    Dim bDebugConnection As Boolean = False
    '    Dim B As Boolean = False
    '    ' Returns True if connection is available
    '    ' Replace www.yoursite.com with a site that
    '    ' is guaranteed to be online - perhaps your
    '    ' corporate site, or microsoft.com

    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 1.")
    '    Dim objUrl As New System.Uri("http://www.ecmlibrary.com/")
    '    ' Setup WebRequest

    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 2.")
    '    Dim objWebReq As System.Net.WebRequest

    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 3.")
    '    objWebReq = System.Net.WebRequest.Create(objUrl)

    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 4.")
    '    Dim objResp As System.Net.WebResponse

    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 5.")
    '    Try
    '        ' Attempt to get response and return True
    '        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 6.")
    '        objResp = objWebReq.GetResponse

    '        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 7.")
    '        objResp.Close()

    '        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 8.")
    '        objWebReq = Nothing

    '        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 9.")
    '        B = True
    '    Catch ex As Exception
    '        ' Error, exit and return False
    '        'objResp.Close()
    '        'objWebReq = Nothing
    '        B = False
    '        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 10.")
    '        LogThis("FAILED TO CONNECT clsDma : isConnected : 987 : " + ex.Message)
    '    End Try
    '    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 11.")
    '    Return B
    'End Function

    'Public Sub SetSearchFields(ByVal txtSearch as string, byval txtThesaurus as string)
    '    Try
    '        frmQuickSearch.txtThesaurus.Text = txtThesaurus
    '        frmQuickSearch.txtSearch.Text = txtSearch$
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    '    Try
    '        frmDocSearch.txtThesaurus.Text = txtThesaurus
    '        frmDocSearch.txtSearch.Text = txtSearch$
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    '    Try
    '        frmEmailSearch.txtThesaurus.Text = txtThesaurus
    '        frmEmailSearch.txtSearch.Text = txtSearch$
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '    End Try
    'End Sub


    ' Only the first X bytes of the file are read into a byte array.
    ' BUFFERSIZE is X.  A larger number will use more memory and
    ' be slower.  A smaller number may not be able to decode all
    ' JPEG files.  Feel free to play with this number.
    '
    ' CImageInfo
    '
    ' Author: David Crowell
    ' davidc@qtm.net
    ' http://www.qtm.net/~davidc
    '
    ' Released to the public domain
    ' use however you wish
    '
    ' CImageInfo will get the image type ,dimensions, and
    ' color depth from JPG, PNG, BMP, and GIF files.
    '
    ' version date: June 16, 1999
    '
    ' http://www.wotsit.org is a good source of
    ' file format information.  This code would not have been
    ' possible without the files I found there.
    '

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

    '    ' Byte array buffer to store part of the file
    '    Dim bBuf(BUFFERSIZE) As Byte
    '    ' Open file number
    '    Dim iFN As Integer

    '    ' Set all properties to default values
    '    GraphicWidth = 0
    '    GraphicHeight = 0
    '    GraphicDepth = 0
    '    ImageType = itUNKNOWN

    '    ' here we will load the first part of a file into a byte 
    '    'array the amount of the file stored here depends on 
    '    'the BUFFERSIZE constant
    '    iFN = FreeFile()
    'Open sFileName For Binary As iFN
    'Get #iFN, 1, bBuf()
    '    Close(iFN)

    '    If bBuf(0) = 137 And bBuf(1) = 80 And bBuf(2) = 78 Then
    '        ' this is a PNG file

    '        m_ImageType = itPNG

    '        ' get bit depth
    '        Select Case bBuf(25)
    '            Case 0
    '                ' greyscale
    '                m_Depth = bBuf(24)

    '            Case 2
    '                ' RGB encoded
    '                m_Depth = bBuf(24) * 3

    '            Case 3
    '                ' Palette based, 8 bpp
    '                m_Depth = 8

    '            Case 4
    '                ' greyscale with alpha
    '                m_Depth = bBuf(24) * 2

    '            Case 6
    '                ' RGB encoded with alpha
    '                m_Depth = bBuf(24) * 4

    '            Case Else
    '                ' This value is outside of it's normal range, so
    '                'we'll assume
    '                ' that this is not a valid file
    '                m_ImageType = itUNKNOWN

    '        End Select

    '        If m_ImageType Then
    '            ' if the image is valid then

    '            ' get the width
    '            m_Width = Mult(bBuf(19), bBuf(18))

    '            ' get the height
    '            m_Height = Mult(bBuf(23), bBuf(22))
    '        End If

    '    End If

    '    If bBuf(0) = 71 And bBuf(1) = 73 And bBuf(2) = 70 Then
    '        ' this is a GIF file

    '        m_ImageType = itGIF

    '        ' get the width
    '        m_Width = Mult(bBuf(6), bBuf(7))

    '        ' get the height
    '        m_Height = Mult(bBuf(8), bBuf(9))

    '        ' get bit depth
    '        m_Depth = (bBuf(10) And 7) + 1
    '    End If

    '    If bBuf(0) = 66 And bBuf(1) = 77 Then
    '        ' this is a BMP file

    '        m_ImageType = itBMP

    '        ' get the width
    '        m_Width = Mult(bBuf(18), bBuf(19))

    '        ' get the height
    '        m_Height = Mult(bBuf(22), bBuf(23))

    '        ' get bit depth
    '        m_Depth = bBuf(28)
    '    End If

    '    If m_ImageType = itUNKNOWN Then
    '        ' if the file is not one of the above type then
    '        ' check to see if it is a JPEG file
    '        Dim lPos As Long

    '        Do
    '            ' loop through looking for the byte sequence FF,D8,FF
    '            ' which marks the begining of a JPEG file
    '            ' lPos will be left at the postion of the start
    '            If (bBuf(lPos) = &HFF And bBuf(lPos + 1) = &HD8 _
    '                 And bBuf(lPos + 2) = &HFF) _
    '                 Or (lPos >= BUFFERSIZE - 10) Then Exit Do

    '            ' move our pointer up
    '            lPos = lPos + 1

    '            ' and continue
    '        Loop

    '        lPos = lPos + 2
    '        If lPos >= BUFFERSIZE - 10 Then Exit Sub


    '        Do
    '            ' loop through the markers until we find the one 
    '            'starting with FF,C0 which is the block containing the 
    '            'image information

    '            Do
    '                ' loop until we find the beginning of the next marker
    '                If bBuf(lPos) = &HFF And bBuf(lPos + 1) _
    '               <> &HFF Then Exit Do
    '                lPos = lPos + 1
    '                If lPos >= BUFFERSIZE - 10 Then Exit Sub
    '            Loop

    '            ' move pointer up
    '            lPos = lPos + 1

    '            Select Case bBuf(lPos)
    '                Case &HC0 To &HC3, &HC5 To &HC7, &HC9 To &HCB, _
    '                &HCD To &HCF
    '                    ' we found the right block
    '                    Exit Do
    '            End Select

    '            ' otherwise keep looking
    '            lPos = lPos + Mult(bBuf(lPos + 2), bBuf(lPos + 1))

    '            ' check for end of buffer
    '            If lPos >= BUFFERSIZE - 10 Then Exit Sub

    '        Loop

    '        ' If we've gotten this far it is a JPEG and we are ready
    '        ' to grab the information.

    '        m_ImageType = itJPEG

    '        ' get the height
    '        m_Height = Mult(bBuf(lPos + 5), bBuf(lPos + 4))

    '        ' get the width
    '        m_Width = Mult(bBuf(lPos + 7), bBuf(lPos + 6))

    '        ' get the color depth
    '        m_Depth = bBuf(lPos + 8) * 8

    '    End If

    'End Sub
    'Private Function Mult(ByVal lsb As Byte, ByVal msb As Byte) As Long
    '    Mult = lsb + (msb * CLng(256))
    'End Function

    '    Sub SayWords(ByVal Words as string)
    '        If gVoiceOn = False Then
    '            Return
    '        End If
    '#If Offfice2007 Then
    '        Dim Voice As New SpeechSynthesizer
    '        Voice.Rate = 0
    '        Voice.Speak(Words)
    '#End If
    '    End Sub


    Sub ckFreetextSearchLine(ByRef SearchText As TextBox)
        Dim S As String = SearchText.Text.Trim
        Dim A() As String = S.Split(" ")

        For I As Integer = 0 To UBound(A)
            Dim token As String = A(I)
            If InStr(1, token, ChrW(34)) > 0 Then
                token = token.Replace(ChrW(34), " ")
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
        Dim S As String = SqlQuery$.Trim
        Dim I As Integer = 0
        Dim J As Integer = 0

        Dim Part1$ = ""
        Dim Part2$ = ""

        I = InStr(1, SqlQuery, LocatorPhrase$, CompareMethod.Binary)
        If I = 0 Then
            Return
        End If

        I = InStr(I + 2, SqlQuery, "'", CompareMethod.Binary)
        J = InStr(I + 1, SqlQuery, "'", CompareMethod.Binary)

        Part1 = Mid(SqlQuery, 1, I).Trim
        Part2 = Mid(SqlQuery, J).Trim

        'Clipboard.Clear()
        'Clipboard.SetText(Part1)


        Dim S2$ = Mid(S, I + 1, J - I - 1).Trim
        Dim A$() = S2.Split(" ")

        For I = 0 To UBound(A)
            Dim Token = A(I)
            'If InStr(1, token, Chrw(34)) > 0 Then
            '    Do While InStr(1, token, Chrw(34)) > 0
            '        Dim II As Integer = InStr(1, token, Chrw(34))
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
        SqlQuery$ = S
    End Sub

    'Function CalcCRC(ByVal FQN as string) As String

    '    If InStr(FQN$, "''") > 0 Then
    '        FQN$ = UTIL.ReplaceSingleQuotes(FQN as string)
    '    End If

    '    Dim zipCrc As New Chilkat.ZipCrc()
    '    Dim crc As Long = 0
    '    crc = zipCrc.FileCrc(FQN as string)
    '    Dim hexStr As String
    '    hexStr = zipCrc.ToHex(crc)
    '    Return hexStr

    'End Function

    Public Function getFileNameWithoutExtension(ByVal FullPath As String) As String
        Return System.IO.Path.GetFileNameWithoutExtension(FullPath)
    End Function
    Public Function getDirName(ByVal FQN as string) As String
        Dim dirName As String = IO.Path.GetDirectoryName(FQN)
        Return dirName
    End Function
    Public Function getFileName(ByVal FQN as string) As String
        Try
            Dim dirName As String = IO.Path.GetFileName(FQN)
            Return dirName
        Catch ex As Exception
            Return FQN
        End Try
    End Function
    Public Function getFullPath(ByVal FQN as string) As String
        Dim dirName As String = IO.Path.GetFullPath(FQN)
        Return dirName
    End Function
    Public Function getFileExtension(ByVal FQN as string) As String
        Dim dirName As String = IO.Path.GetExtension(FQN)
        Return dirName
    End Function


    ' <summary>
    ' This method starts at the specified directory, and traverses all subdirectories.
    ' It returns a List of those directories.
    ' </summary>
    'Public Function GetFilesRecursive(ByVal initial As String) As List(Of String)
    '    ' This list stores the results.
    '    Dim result As New List(Of String)

    '    ' This stack stores the directories to process.
    '    Dim stack As New Stack(Of String)

    '    ' Add the initial directory
    '    stack.Push(initial)

    '    ' Continue processing for each stacked directory
    '    Do While (stack.Count > 0)
    '        ' Get top directory string
    '        Dim dir As String = stack.Pop
    '        Try
    '            ' Add all immediate file paths
    '            result.AddRange(Directory.GetFiles(dir, "*.*"))

    '            ' Loop through all subdirectories and add them to the stack.
    '            Dim directoryName As String
    '            For Each directoryName In Directory.GetDirectories(dir)
    '                stack.Push(directoryName)
    '            Next

    '        Catch ex As Exception
    '        End Try
    '    Loop

    '    ' Return the list
    '    Return result
    'End Function

    'Public Sub GetFilesRecursive(ByVal initial As String, ByVal List As List(Of String))
    '    ' This list stores the results.
    '    Dim result As New List(Of String)

    '    ' This stack stores the directories to process.
    '    Dim stack As New Stack(Of String)

    '    ' Add the initial directory
    '    stack.Push(initial)

    '    ' Continue processing for each stacked directory
    '    Do While (stack.Count > 0)
    '        ' Get top directory string
    '        Dim dir As String = stack.Pop
    '        Try
    '            ' Add all immediate file paths
    '            result.AddRange(Directory.GetFiles(dir, "*.*"))

    '            ' Loop through all subdirectories and add them to the stack.
    '            Dim directoryName As String
    '            For Each directoryName In Directory.GetDirectories(dir)
    '                stack.Push(directoryName)
    '            Next

    '        Catch ex As Exception
    '        End Try
    '    Loop

    '    ' Return the list
    '    CombineLists(List, result)
    'End Sub

    Sub CombineLists(ByRef ParentList As List(Of String), ByRef ChildList As List(Of String))
        Dim I As Integer = 0
        For I = 0 To ChildList.Count - 1
            Dim S as string = ChildList.Item(I)
            ParentList.Add(S)
        Next
        ChildList.Clear()
    End Sub

    Sub FixFileExtension(ByRef Extension As String)
        Extension = Extension$.Trim
        Extension = Extension$.ToLower
        If InStr(1, Extension, ".") = 0 Then
            Extension = "." + Extension
        End If
        Extension = Extension.Replace(",", ".")
        Return
    End Sub

    Function isExtIncluded(ByVal fExt As String, ByVal IncludedTypes As List(Of String)) As Boolean
        fExt = UCase(fExt)
        fExt = fExt.Replace(".", " ")

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
    Function isExtExcluded(ByVal fExt As String, ByVal ExcludedTypes As List(Of String)) As Boolean

        fExt = UCase(fExt)
        fExt = fExt.Replace(".", " ")

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
    Function commentOutOrderBy(ByVal sTxt as string) As String
        Dim S as string = sTxt$
        If S.Trim.Length = 0 Then
            Return ""
        End If
        '** Find the starting point of the order by and start the comment there 
        Dim X As Integer = 0
        X = InStr(S, "order by", CompareMethod.Text)
        Dim S1$ = Mid(S, 1, X - 1)
        Dim S2$ = Mid(S, X)
        Dim S3$ = S1 + Environment.NewLine + "  /* " + S2 + "  */"
        S = S3
        Return S
    End Function

    Function CreateMissingDir(ByVal DirFQN as string) As Boolean

        Dim B As Boolean = False
        If System.IO.Directory.Exists(DirFQN) Then
            Return True
        End If
        Try
            System.IO.Directory.CreateDirectory(DirFQN)
            Return True
        Catch ex As Exception
            LogThis("ERROR 76.54.32 - Could not create restore directory. " + Environment.NewLine + ex.Message)
            MessageBox.Show("ERROR 76.54.32 - Could not create restore directory. " + Environment.NewLine + Environment.NewLine + "Please verify that you have authority to create this directory." + ex.Message)
            Return False
        Finally
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Function

    Function LoadLicenseFile(ByVal FQN as string) As String
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            MessageBox.Show("Failed to load License file: " + Environment.NewLine + Ex.Message)
            LogThis("clsDatabase : LoadLicenseFile : 5914 : " + Ex.Message)
            Return False
        End Try
        Return strContents
    End Function

    Sub LogThis(ByVal MSG as string)
        Dim LOG As New clsLogMain
        LOG.WriteToSqlLog(MSG)
        LOG = Nothing
    End Sub
    Function ReadFile(ByVal fName as string) As String
        Dim SR As New IO.StreamReader(fName)
        Dim FullText$ = ""
        Do While Not SR.EndOfStream
            Dim S as string = SR.ReadLine
            FullText$ = FullText$ + S$ + Environment.NewLine
        Loop
        SR.Close()
        Return FullText$
    End Function
    Sub WriteFile(ByVal FQN as string, byval sText as string)
        Try
            Dim SW As New IO.StreamWriter(FQN)
            Dim S as string = sText.Trim

            If S.Length > 0 Then
                SW.WriteLine(S)
            End If
            SW.Close()
        Catch ex As Exception
            LogThis("clsDMa:WriteFile - " + ex.Message)
        End Try

    End Sub

    'Sub ModifyAppConfig(ByVal ServerName as string, byval ItemToModify as string)
    '    Dim AppConfigBody As String = ""
    '    Dim aPath$ = App_Path()
    '    Dim AppName$ = aPath$ + "ECMLibrary.exe.config"

    '    Dim F As File
    '    If F.Exists(AppName) Then
    '        AppConfigBody = ReadFile(AppName)
    '        If AppConfigBody.Trim.Length > 0 Then
    '            ApplyAppConfigChange(ServerName$, ItemToModify$, AppConfigBody)
    '            If AppConfigBody.Trim.Length > 0 Then
    '                WriteFile(AppName, AppConfigBody)
    '                SetUserConnectionString(ServerName as string)
    '                SetThesaurusConnectionStringToConfig(ServerName as string)
    '            End If
    '        End If
    '    End If
    'End Sub

    'Sub SetUserConnectionString(ByVal ServerName as string)

    '    Dim sCurr$ = ServerName$

    '    My.Settings("UserDefaultConnString") = "?"
    '    My.Settings.Save()

    '    Dim S as string = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")

    '    '*****************************************************************************
    '    Dim Str1$ = ""
    '    Dim Str2$ = ""
    '    Dim NewStr$ = ServerName$

    '    Dim NumberOfCycles As Integer = 0
    '    Dim I As Integer = 1
    '    Do While InStr(I, S$, "Data Source=", CompareMethod.Text) > 0

    '        I = InStr(I, S$, "Data Source=", CompareMethod.Text)
    '        I = InStr(I + 1, S$, "=", CompareMethod.Text)
    '        Dim J As Integer = InStr(I + 1, S$, ";", CompareMethod.Text)
    '        Str1 = Mid(S$, 1, I)
    '        Str2 = Mid(S$, J)
    '        S$ = Str1 + sCurr$ + Str2
    '        NumberOfCycles += 1
    '        If NumberOfCycles > 50 Then
    '            Exit Do
    '        End If
    '        I = J + 1

    '    Loop
    '    '*****************************************************************************

    '    UTIL.setConnectionStringTimeout(S, TimeOutSecs)
    '    'S = ENC.AES256DecryptString(S)

    '    My.Settings.Reload()
    '    Console.WriteLine(My.Settings("UserDefaultConnString"))
    '    My.Settings("UserDefaultConnString") = S
    '    Console.WriteLine(My.Settings("UserDefaultConnString"))
    '    My.Settings.Save()

    'End Sub

    'Sub SetThesaurusConnectionStringToConfig(ByVal ServerName as string)

    '    Dim sCurr$ = ServerName$

    '    My.Settings("UserThesaurusConnString") = "?"
    '    My.Settings.Save()
    '    Dim S as string = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString").ToString

    '    '*****************************************************************************
    '    Dim Str1$ = ""
    '    Dim Str2$ = ""
    '    Dim NewStr$ = ServerName$

    '    Dim NumberOfCycles As Integer = 0
    '    Dim I As Integer = 1
    '    Do While InStr(I, S$, "Data Source=", CompareMethod.Text) > 0

    '        I = InStr(I, S$, "Data Source=", CompareMethod.Text)
    '        I = InStr(I + 1, S$, "=", CompareMethod.Text)
    '        Dim J As Integer = InStr(I + 1, S$, ";", CompareMethod.Text)
    '        Str1 = Mid(S$, 1, I)
    '        Str2 = Mid(S$, J)
    '        S$ = Str1 + sCurr$ + Str2
    '        NumberOfCycles += 1
    '        If NumberOfCycles > 50 Then
    '            Exit Do
    '        End If
    '        I = J + 1

    '    Loop
    '    '*****************************************************************************

    '    UTIL.setConnectionStringTimeout(S, TimeOutSecs)
    '    'S = ENC.AES256DecryptString(S)

    '    My.Settings.Reload()
    '    Console.WriteLine(My.Settings("UserDefaultConnString"))
    '    My.Settings("UserThesaurusConnString") = S
    '    Console.WriteLine(My.Settings("UserDefaultConnString"))
    '    My.Settings.Save()

    'End Sub

    Sub ApplyAppConfigChange(ByVal ServerName as string, byval ItemToModify as string, byref AppConFigBody As String)

        If ServerName$.Trim.Length = 0 Then
            Return
        End If

        Dim AppText$ = AppConFigBody
        Dim Str1$ = ""
        Dim Str2$ = ""
        Dim NewStr$ = ServerName$

        Dim NumberOfCycles As Integer = 0
        Dim I As Integer = 1
        Do While InStr(I, AppText, "Data Source=", CompareMethod.Text) > 0
            I = InStr(I, AppText, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, AppText, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, AppText, ";", CompareMethod.Text)
            Str1 = Mid(AppText, 1, I)
            'MsgBox(Str1)
            Str2 = Mid(AppText, J)
            'MsgBox(Str2)
            AppText = Str1 + ServerName$ + Str2
            'MsgBox(AppText)
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

    'Public Sub deleteDirectoryFiles(ByVal DirFQN as string)
    '    Dim FileName As String
    '    Try
    '        For Each FileName In System.IO.Directory.GetFiles(DirFQN as string)
    '            Try
    '                System.IO.File.Delete(FileName)
    '            Catch ex As System.Exception
    '                LOG.WriteToSqlLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.")
    '            End Try
    '        Next FileName
    '    Catch ex As System.Exception
    '        LOG.WriteToSqlLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN$ + "'.")
    '    End Try

    'End Sub



End Class

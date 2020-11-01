'clsDma: A set of standard utilities to perofrm repetitive tasks through a public class
'Copyright @DMA, Limited, Chicago, IL., June 2003, all rights reserved.
'Licensed on a use only basis for clients of DMA, Limited. 

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
'Imports System.Web.UI.WebControls.GridView
'Imports System.Windows.Forms
'Imports System.Web.Security
'Imports System.Web
'Imports System.Web.Services
'Imports System.Web.Services.Protocols

Imports System.Text
Imports System.Data.Sql
'Imports System.Windows.Forms.PictureBox
'Imports System.Web.UI
'Imports System.Web.UI.Page

Public Class clsDma
    'Dim owner As IWin32Window

    Private Declare Function URLDownloadToFile Lib "urlmon" _
        Alias "URLDownloadToFileA" (ByVal pCaller As Long, _
        ByVal szURL As String, ByVal szFileName As String, _
        ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

    Dim dDeBug As Boolean = True
    Dim bb As Boolean = False
    Public TempEnvironDir As String = getEnvironmentTempDir()
    Private CurrHostName As String = ""
    Private MachineIP As String = ""

    Dim myIPAddress, MacAddr, x As Net.IPAddress
    Dim myIPHostEntry As New Net.IPHostEntry()

    'Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

    Dim oReg As Microsoft.Win32.Registry
    Dim oRegKey As Microsoft.Win32.RegistryKey

    Public RetC As Boolean

    Public Sub getSubDirs(ByRef Dirs$(), ByVal TargetDir$)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        ReDim Dirs$(0)
        'ReDim Files$(0)
        Dim path$ = TargetDir$
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                Dirs = Directory.GetDirectories(path)
                'Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            Console.WriteLine(ex.Source)
            Console.WriteLine(ex.StackTrace)
            Console.WriteLine(ex.Message)
        End Try
    End Sub
    Public Sub getDirFiles(ByRef Files$(), ByVal TargetDir$)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        'ReDim Dirs$(0)
        ReDim Files$(0)
        Dim path$ = TargetDir$
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                'Dirs = Directory.GetDirectories(path)
                Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            Console.WriteLine(ex.Source)
            Console.WriteLine(ex.StackTrace)
            Console.WriteLine(ex.Message)
        End Try
    End Sub
    Public Function ckVar2(ByRef tVal$) As String
        If tVal = "&nbsp;" Then
            tVal = ""
        End If
        Return tVal
    End Function
    Public Sub ListDirs(ByRef Dirs$(), ByRef Files$(), ByVal TargetDir$)
        'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
        'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
        ReDim Dirs$(0)
        ReDim Files$(0)
        Dim path$ = TargetDir$
        Try
            If Not Directory.Exists(path) Then
                Return
            Else
                Dirs = Directory.GetDirectories(path)
                Files = Directory.GetFiles(path)
            End If
        Catch ex As Exception
            Console.WriteLine(ex.Source)
            Console.WriteLine(ex.StackTrace)
            Console.WriteLine(ex.Message)
        End Try
    End Sub
    Public Function DownloadWebFile(ByVal WebFqn$, ByVal ToFqn$) As Boolean
        Dim B As Boolean = False
        WebFqn$ = "http://www.vb-helper.com/vbhelper_425_64.gif"
        ToFqn$ = "C:\vbhelper_425_64.gif"

        Try
            URLDownloadToFile(0, WebFqn$, ToFqn$, 0, 0)
            B = True
        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function
    Public Sub setHostName()
        Dim shostname As String = ""
        shostname = System.Net.Dns.GetHostName
        If dDeBug Then Console.WriteLine("Your Machine Name = " & shostname)
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
                If dDeBug Then Console.WriteLine(s)

                ' Display the ScopeId property in case of IPV6 addresses.
                If curAdd.AddressFamily.ToString() = ProtocolFamily.InterNetworkV6.ToString() Then
                    s = "Scope Id: " + curAdd.ScopeId.ToString()
                    If dDeBug Then
                        Console.WriteLine(s)
                    End If
                End If

                ' Display the server IP address in the standard format. In 
                ' IPv4 the format will be dotted-quad notation, in IPv6 it will be
                ' in in colon-hexadecimal notation.
                s = "Address: " + curAdd.ToString()
                s = curAdd.ToString()

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
            Console.WriteLine(("[DoResolve] Exception: " + e.ToString()))
        End Try

        MachineIP = s

    End Sub

    Public Function getIpAddr() As String
        If MachineIP = "" Then
            setIPAddr()
        End If
        Return MachineIP
    End Function

    Public Function getEnvironmentTempDir() As String
        Dim td$ = ""
        td = Environ$("TEMP")
        TempEnvironDir = td
        'Console.WriteLine("Machine Information")
        'Console.WriteLine("======================")
        'Console.WriteLine("Machine Name: " + Environment.MachineName.)
        'Console.WriteLine("OS Version: " & Environment.OSVersion.ToString())
        'Console.WriteLine("System Directory: " + Environment.SystemDirectory)
        'Console.WriteLine("User Name: " + Environment.UserName)
        'Console.WriteLine("Version: " + Environment.Version.ToString())
        'Console.WriteLine("Current Directory: " + Environment.CurrentDirectory)
        'Console.WriteLine()
        Return td
    End Function
    Public Function getEnvironmentUserID() As String
        Return Environment.UserName
        'Console.WriteLine("Machine Information")
        'Console.WriteLine("======================")
        'Console.WriteLine("Machine Name: " + Environment.MachineName.)
        'Console.WriteLine("OS Version: " & Environment.OSVersion.ToString())
        'Console.WriteLine("System Directory: " + Environment.SystemDirectory)
        'Console.WriteLine("User Name: " + Environment.UserName)
        'Console.WriteLine("Version: " + Environment.Version.ToString())
        'Console.WriteLine("Current Directory: " + Environment.CurrentDirectory)
        'Console.WriteLine()        
    End Function

    Public Function LoadGraphic(ByVal filePath As String) As Byte()
        Dim stream As FileStream = New FileStream( _
           filePath, FileMode.Open, FileAccess.Read)
        Dim reader As BinaryReader = New BinaryReader(stream)

        Dim photo() As Byte = reader.ReadBytes(stream.Length)

        reader.Close()
        stream.Close()

        Return photo
    End Function

    Public Function RemoveSingleQuotes(ByVal tVal$) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "'" Then
                Mid(tVal, i, 1) = "`"
            End If
        Next
        Return tVal
    End Function
    Public Function fixSingleQuotes(ByVal tVal$) As String
        Dim tempStr$ = ""
        Dim bLastCharIsQuote As Boolean = False

        tVal = tVal.Trim
        Dim CH$ = Mid(tVal, tVal.Length, 1)
        If CH.Equals("'") Then
            bLastCharIsQuote = True
        End If

        Dim A$() = Split(tVal, "'")
        If InStr(tVal, "'") > 0 Then
            For i As Integer = 0 To UBound(A)
                tempStr += A$(i) + "''"
            Next
        Else
            tempStr$ = tVal
            Return tempStr
        End If

        tempStr$ = Mid(tempStr$, 1, tempStr$.Length - 2)

        Return tempStr
    End Function
    Public Function ReplaceSingleQuotes(ByVal tVal$) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "`" Then
                Mid(tVal, i, 1) = "'"
            End If
        Next
        Return tVal
    End Function
    Public Function ReplaceVerticalBar(ByVal tVal$) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "|" Then
                Mid(tVal, i, 1) = "_"
            End If
        Next
        Return tVal
    End Function
    Public Function RemoveCommas(ByVal tVal$) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "," Then
                Mid(tVal, i, 1) = "^"
            End If
        Next
        Return tVal
    End Function
    Public Function CheckFileName(ByVal tVal$) As String
        Dim i As Integer = Len(tVal)
        Dim j As Integer = 0
        Dim CH$ = ""
        For i = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz.-@$", CH, CompareMethod.Text)
            If j = 0 Then
                tVal = RemoveChar(tVal$, CH)
            End If
        Next

        Return tVal

    End Function
    Public Function RemoveChar(ByVal tVal$, ByVal tChar$) As String
        Dim i As Integer = Len(tVal)
        Dim A$()
        Dim S = ""
        A = tVal.Split(tChar)
        For i = 0 To UBound(A)
            S = S + A(i)
        Next
        If S.Length > 0 Then
            Return S
        Else
            Return tVal
        End If

    End Function
    Public Function ReplaceCommas(ByVal tVal$) As String
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



    Public Function GetFileName(ByVal FQN$) As String
        Dim fn$ = ""

        Dim i# = 0
        Dim j# = 0
        Dim ch$ = ""
        For i = Len(FQN) To 1 Step -1
            ch = Mid(FQN, i, 1)
            If ch = "\" Then
                fn = Mid(FQN, i + 1)
                Exit For
            End If
            If ch = "/" Then
                fn = Mid(FQN, i + 1)
                Exit For
            End If
        Next
        If fn = "" And FQN.Length > 0 Then
            Return FQN
        Else
            Return fn
        End If

    End Function
    Public Function GetFilePath(ByVal FQN$) As String
        Dim fn$ = ""

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


    Public Function FileExist(ByVal fqn$) As Boolean
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
        Dim MyFile$
        If Len(Trim(fqn)) = 0 Then
            FileExist = False
            Exit Function
        End If
        MyFile = fqn$
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
            '        Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
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

    Public Function ckVar(ByRef sText$) As String
        Dim i As Integer = 0
        Dim j As Integer = 0
        If sText$ = "&nbsp;" Then
            sText$ = ""
            Return sText$
        End If

        sText = ReplaceOccr(sText, "&gt", "<")
        sText = ReplaceOccr(sText, "&Lt", ">")
        sText = ReplaceOccr(sText, "&nbsp;", " ")

        sText = RemoveSingleQuotes(sText)

        Return sText$
    End Function
    Private Function ReplaceOccr(ByVal tStr$, ByVal TgtStr$, ByVal ReplacementStr$) As String
        Dim S1$ = ""
        Dim S2$ = ""
        Dim L As Integer = Len(TgtStr$)
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

            Return 1

        End Try

    End Function

    Public Function getFileSuffix(ByVal FQN$) As String
        Dim i As Integer = 0
        Dim ch$ = ""
        Dim suffix$ = ""
        For i = FQN.Length To 1 Step -1
            ch = Mid(FQN, i, 1)
            If ch = "." Then
                suffix = Mid(FQN, i + 1)
                Exit For
            End If
        Next
        Return suffix
    End Function
    Function GetMimeType(ByVal FileSuffix$) As String
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

    Public Function SaveErrMsg(ByVal ErrMsg$, ByVal ErrStack$) As String

        Dim DB As New clsDatabase
        Dim TxName As String = "TX001"
        Dim rc$ = ""
        Dim SQL$ = ""


        Dim ConnectionString$ = "FIX THIS"
        Dim CN As New SqlConnection

        Try
            CN.Open()

            ErrMsg$ = Me.RemoveSingleQuotes(ErrMsg$)
            ErrStack$ = Me.RemoveSingleQuotes(ErrStack$)

            Dim MySql$ = "INSERT INTO [RuntimeErrors] "
            MySql$ = MySql$ + "([ErrorMsg]"
            MySql$ = MySql$ + ",[StackTrace]"
            MySql$ = MySql$ + ",[EntryDate])"
            MySql$ = MySql$ + "VALUES "
            MySql$ = MySql$ + "('" + ErrMsg + "'"
            MySql$ = MySql$ + ",'" + ErrStack + "'"
            MySql$ = MySql$ + ",'" + Now + "')"


            Using CN

                Dim dbCmd As SqlCommand = CN.CreateCommand()
                Dim transaction As SqlTransaction

                ' Start a local transaction
                transaction = CN.BeginTransaction(TxName)

                ' Must assign both transaction object and connection
                ' to dbCmd object for a pending local transaction.
                dbCmd.Connection = CN
                dbCmd.Transaction = transaction

                Try
                    dbCmd.CommandText = SQL
                    dbCmd.ExecuteNonQuery()
                    ' Attempt to commit the transaction.
                    transaction.Commit()


                    'Audit(sql)

                    Dim debug As Boolean = True
                    If debug Then
                        Console.WriteLine("Successful execution: " + vbCrLf + SQL)
                    End If
                    rc = True
                Catch ex As Exception
                    rc = "SaveErrMsg" + vbCrLf + ex.Message + vbCrLf + vbCrLf + ex.StackTrace
                    ' Attempt to roll back the transaction.
                    Try
                        transaction.Rollback()
                    Catch ex2 As Exception
                        ' This catch block will handle any errors that may have occurred
                        ' on the server that would cause the rollback to fail, such as
                        ' a closed connection.
                        Console.WriteLine("Rollback Exception Type: {0}", ex2.GetType())
                        Console.WriteLine("  Message: {0}", ex2.Message)
                        rc = rc + "SaveErrMsg" + vbCrLf + ex.Message + vbCrLf + vbCrLf + ex.StackTrace
                    End Try
                End Try
            End Using

        Catch ex As Exception
            rc = "SaveErrMsg" + vbCrLf + ex.Message + vbCrLf + vbCrLf + ex.StackTrace
        End Try

        If CN.State = Data.ConnectionState.Open Then
            CN.Close()
        End If
        If Not CN Is Nothing Then
            CN = Nothing
        End If

        Return rc

    End Function

    'Public Function RecursiveSearch(ByVal path As String, ByRef A$()) As Boolean
    '    Try
    '        Dim dirfound As Boolean = False
    '        path = ReplaceSingleQuotes(path)
    '        Dim dirInfo As New IO.DirectoryInfo(path)
    '        Dim fileObject As FileSystemInfo
    '        For Each fileObject In dirInfo.GetFileSystemInfos()
    '            If fileObject.Attributes = FileAttributes.Directory Then
    '                'Dim tDir$ = GetFilePath(fileObject.FullName)
    '                dirfound = True
    '                ReDim Preserve A(UBound(A) + 1)
    '                A(UBound(A)) = fileObject.FullName
    '                frmReconMain.SubDirectories.Add(fileObject.FullName)
    '                RecursiveSearch(fileObject.FullName, A)
    '            End If
    '        Next
    '        Return dirfound
    '    Catch ex As Exception
    '        Debug.Print(ex.Message)            
    '        Return False
    '    End Try

    'End Function
    Function getFilesInDir(ByVal DirName$, ByRef DirFiles$()) As Integer
        Dim I As Integer = UBound(DirFiles)

        Try
            Dim FileAttributes$ = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo

            Try
                For Each fi In aryFi
                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                    FileAttributes$ = ""
                    FileAttributes$ = FileAttributes$ + fi.Name + "|"
                    FileAttributes$ = FileAttributes$ + fi.FullName + "|"
                    FileAttributes$ = FileAttributes$ + fi.Length.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.Extension + "|"
                    FileAttributes$ = FileAttributes$ + fi.LastAccessTime.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.CreationTime.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.LastWriteTime.ToString
                    If I = 0 Then
                        DirFiles(0) = FileAttributes
                    Else
                        ReDim Preserve DirFiles(UBound(DirFiles) + 1)
                        DirFiles(UBound(DirFiles)) = FileAttributes
                    End If
                    I = I + 1
                Next
            Catch ex As Exception
                MsgBox("Error 22012: " + ex.Message)
            End Try

        Catch ex As Exception
            MsgBox("Error 22013: " + ex.Message)
        End Try
        Return I
    End Function
    Function getFileInDir(ByVal DirName$, ByRef DirFiles$()) As Integer
        Dim I As Integer = 0

        Try
            ReDim DirFiles(0)
            Dim FileAttributes$ = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo

            Try
                For Each fi In aryFi
                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                    FileAttributes$ = ""
                    FileAttributes$ = FileAttributes$ + fi.Name + "|"
                    FileAttributes$ = FileAttributes$ + fi.FullName + "|"
                    FileAttributes$ = FileAttributes$ + fi.Length.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.Extension + "|"
                    FileAttributes$ = FileAttributes$ + fi.LastAccessTime.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.CreationTime.ToString + "|"
                    FileAttributes$ = FileAttributes$ + fi.LastWriteTime.ToString
                    If I = 0 Then
                        DirFiles(0) = FileAttributes
                    Else
                        ReDim Preserve DirFiles(I)
                        DirFiles(I) = FileAttributes
                    End If
                    I = I + 1
                Next
            Catch ex As Exception
                MsgBox("Error 22012: " + ex.Message)
            End Try

        Catch ex As Exception
            MsgBox("Error 22013: " + ex.Message)
        End Try
        Return I
    End Function
    Public Function getFilesInDir(ByVal DirName$, ByRef DirFiles$(), ByVal ExactFileName$) As Integer
        Dim I As Integer = 0
        Dim FQN$ = DirName$ + "\" + ExactFileName$
        Try
            ReDim DirFiles(0)
            Dim FileAttributes$ = ""

            Dim strFileSize As String = ""
            Dim iFileSize As Integer = 0
            Dim di As New IO.DirectoryInfo(DirName)
            Dim fInfo As New IO.FileInfo(DirName + "\" + ExactFileName$)
            'Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName$)
            'Dim fi As IO.FileInfo

            Try
                'For Each fi In aryFi
                strFileSize = (Math.Round(fInfo.Length / 1024)).ToString()
                FileAttributes$ = ""
                FileAttributes$ = FileAttributes$ + fInfo.Name + "|"
                FileAttributes$ = FileAttributes$ + fInfo.FullName + "|"
                FileAttributes$ = FileAttributes$ + fInfo.Length.ToString + "|"
                FileAttributes$ = FileAttributes$ + fInfo.Extension + "|"
                FileAttributes$ = FileAttributes$ + fInfo.LastAccessTime.ToString + "|"
                FileAttributes$ = FileAttributes$ + fInfo.CreationTime.ToString + "|"
                FileAttributes$ = FileAttributes$ + fInfo.LastWriteTime.ToString
                If I = 0 Then
                    DirFiles(0) = FileAttributes
                Else
                    ReDim Preserve DirFiles(I)
                    DirFiles(I) = FileAttributes
                End If
                I = I + 1
                'Next
            Catch ex As Exception
                MsgBox("Error 22012: " + ex.Message)
            End Try

        Catch ex As Exception
            MsgBox("Error 22013: " + ex.Message)
        End Try
        Return I
    End Function
    Sub ReplaceStar(ByRef tVal$)
        Dim CH$ = ""
        If InStr(tVal, "*") = 0 Then
            Return
        End If
        If tVal$.Length > 0 Then
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
    Function genContainsSyntax(ByVal S) As String
        '** Get all the OR's and build a search term then
        '** get all the AND's and build a search term then
        '** Apply any NEAR's to the mess.

        ' "dale miller" "susan miller" near Jessie
        ' "dale miller" "susan miller" +Jessie Shelby
        ' "dale miller" +"susan miller" +Jessie
        'Dale Susan near Jessie
        '+dale +susan near Jessie
        '+dale +susan Jessie
        '+dale +susan +Jessie

        'WHERE CONTAINS(*, '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm"')
        '** '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm" and "Corporate"'
        '** 'ECA or "Enterprise Content" AND Content* and state NEAR "State Farm" and Corporate'
        '** 'ECA "Enterprise Content" +Content* +state NEAR "State Farm" +Corporate'
        Dim A$(0)
        Dim I As Integer = 0
        Dim Ch$ = ""
        Dim tWord$ = ""
        Dim WordCnt As Integer = 0
        Dim isOr As Boolean = True
        Dim isAnd As Boolean = False
        Dim isNear As Boolean = False
        Dim isPhrase As Boolean = False
        'Dim ORs$(0)
        'Dim ANDs$(0)
        'Dim Near$(0)
        ReDim A(0)

        S = S.Trim

        For I = 1 To S.Length
            Ch = Mid(S, I, 1)
NextWord:
            If Ch = " " Then
                tWord = ""
                isOr = True
                isNear = False
                isAnd = False
                I += 1
                Ch = Mid(S, I, 1)
                Dim KK As Integer = S.Length
                Do Until (Ch <> " " And I <= KK)
                    I += 1
                    Ch = Mid(S, I, 1)
                    If I > S.Length Then
                        Exit Do
                    End If
                Loop
            End If
            If Ch = "+" Then
                tWord = ""
                isAnd = True
                isOr = False
                isNear = False
                I += 1
                Ch = Mid(S, I, 1)
                Dim KK As Integer = S.Length
                Do Until (Ch <> " " And I <= KK)
                    I += 1
                    Ch = Mid(S, I, 1)
                    If I > S.Length Then
                        Exit Do
                    End If
                Loop
            End If

            If Ch = Chr(34) Then
                tWord = ""
                tWord += Chr(34)
                I += 1
                Ch = Mid(S, I, 1)
                Dim KK As Integer = S.Length
                Do Until (Ch = Chr(34) And I <= KK)
                    tWord += Ch
                    I += 1
                    Ch = Mid(S, I, 1)
                    If I > S.Length Then
                        Exit Do
                    End If
                Loop
                tWord += Chr(34)
                'Debug.Print(tWord)
            ElseIf Ch = "(" Or Ch = ")" Then
                tWord = Ch
                isAnd = False
                isOr = False
                isNear = False
            ElseIf Ch = "?" Then
                isAnd = False
                isOr = False
                isNear = False
                Ch = Mid(S, I, 1)
                Dim KK As Integer = S.Length
                Do Until (Ch = " " And I <= KK)
                    tWord += Ch
                    I += 1
                    Ch = Mid(S, I, 1)
                    If I > S.Length Then
                        Exit Do
                    End If
                Loop
            Else
                Ch = Mid(S, I, 1)
                Dim KK As Integer = S.Length
                Do Until (Ch = " " And I <= KK)
                    tWord += Ch
                    I += 1
                    Ch = Mid(S, I, 1)
                    If I > S.Length Then
                        Exit Do
                    End If
                Loop
                Debug.Print(tWord)
            End If
ProcessImmediately:
            If UCase(tWord).Trim.Equals("(") Then
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "~" + tWord
            ElseIf UCase(tWord).Trim.Equals(")") Then
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "~" + tWord
            ElseIf UCase(tWord).Trim.Equals("NEAR") Then
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "~" + tWord
            ElseIf UCase(tWord).Trim.Equals("AND") Then
                'ReDim Preserve A$(UBound(A$) + 1)
                'A$(UBound(A$)) = "~" + tWord
                Ch = "+"
                GoTo NextWord
            ElseIf UCase(tWord).Trim.Equals("OR") Then
                'ReDim Preserve A$(UBound(A$) + 1)
                'A$(UBound(A$)) = "~" + tWord
                Ch = " "
                GoTo NextWord
            ElseIf isOr And tWord.Trim.Length > 0 Then
                'AddOrWord(ORs$, tWord$)
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "|" + tWord
            ElseIf isAnd And tWord.Trim.Length > 0 Then
                'AddAndWord(ANDs, tWord$)
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "+" + tWord
                'ElseIf isNear And tWord.Trim.Length > 0 Then
                '    'AddNearWord(Near$, tWord$)
                '    ReDim Preserve A$(UBound(A$) + 1)
                '    A$(UBound(A$)) = "+" + tWord
            Else
                ReDim Preserve A$(UBound(A$) + 1)
                A$(UBound(A$)) = "?" + tWord
            End If
            Debug.Print(I.ToString + ":" + tWord)
            Debug.Print(S)
            tWord = ""
            'isOr = True
            For II As Integer = 0 To UBound(A)
                If A(II) = Nothing Then
                    Debug.Print(II.ToString + ":Nothing")
                Else
                    Debug.Print(II.ToString + ":" + A(II).ToString)
                End If

            Next
        Next


        If dDeBug Then Debug.Print(S)
        Dim Stmt$ = ""
        Dim bFirst As Boolean = True
        For I = 0 To UBound(A)
            If A(I) <> Nothing Then
                If A(I).Trim.Length > 0 Then
                    Ch = Mid(A(I), 1, 1)
                    Dim KeyWord$ = Mid(A(I), 2)
                    If UCase(KeyWord$).Equals("NEAR") Then
                        I += 1
                        Ch = Mid(A(I), 1, 1)
                        Dim NearWord$ = Mid(A(I), 2)
                        Stmt = Stmt + " NEAR " + NearWord$
                    ElseIf UCase(KeyWord$).Equals("(") Or UCase(KeyWord$).Equals(")") Then
                        Ch = Mid(A(I), 1, 1)
                        Dim Paren$ = Mid(A(I), 2)
                        Stmt = Stmt + KeyWord$
                    ElseIf Ch.Equals("?") Then
                        '** A near is found
                        tWord = Mid(A(I), 2)
                        Stmt = Stmt + " " + tWord
                    ElseIf Ch.Equals(Chr(254)) Then
                        '** A near is found
                        tWord = Mid(A(I), 2)
                        Stmt = Stmt + " " + tWord
                        I += 1
                        tWord = Mid(A(I), 2)
                        Stmt = Stmt + " " + tWord
                    ElseIf Ch.Equals("+") Then
                        tWord = Mid(A(I), 2)
                        If bFirst Then
                            Stmt = tWord
                        Else
                            Stmt = Stmt + " AND " + tWord
                        End If
                    ElseIf Ch.Equals("-") Then
                        tWord = Mid(A(I), 2)
                        If bFirst Then
                            Stmt = tWord
                        Else
                            Stmt = Stmt + " AND NOT " + tWord
                        End If
                    ElseIf Ch.Equals("|") Then
                        tWord = Mid(A(I), 2)
                        If bFirst Then
                            Stmt = tWord
                        Else
                            Stmt = Stmt + " OR " + tWord
                        End If
                    End If
                    bFirst = False
                End If
            End If
            If dDeBug Then Debug.Print("Passsed In: " + S)
            If dDeBug Then Debug.Print("Generated : " + Stmt)
        Next
        If dDeBug Then Debug.Print(Stmt)
        Return Stmt

    End Function
    Sub genContainsClause(ByVal InputSearchString$, ByRef WhereClause$, ByVal useFreetext As Boolean, ByVal ckWeighted As Boolean, ByVal isEmail As Boolean)

        Dim S = ""
        WhereClause = ""

        If ckWeighted Then
            If isEmail Then
                If useFreetext = True Then
                    If InputSearchString$.Length > 0 Then
                        WhereClause += " ( freetext (body, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "')"
                        WhereClause += " or freetext (subject, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "'))"
                    End If
                Else
                    If InputSearchString$.Length > 0 Then
                        WhereClause += " ( CONTAINS(body, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "')"
                        WhereClause += " or CONTAINS(subject, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "'))"
                    End If
                End If
            Else
                If useFreetext = True Then
                    If InputSearchString$.Length > 0 Then
                        WhereClause += " FREETEXT (SourceImage, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "')"
                    End If
                Else
                    If InputSearchString$.Length > 0 Then
                        WhereClause += " CONTAINS(SourceImage, '"
                        S = InputSearchString$
                        WhereClause += genContainsSyntax(S)
                        WhereClause += "')"
                    End If
                End If
            End If
        Else
            If useFreetext = True Then
                If InputSearchString$.Length > 0 Then
                    WhereClause += " FREETEXT (*, '"
                    S = InputSearchString$
                    WhereClause += genContainsSyntax(S)
                    WhereClause += "')"
                End If
            Else
                If InputSearchString$.Length > 0 Then
                    WhereClause += " CONTAINS(*, '"
                    S = InputSearchString$
                    WhereClause += genContainsSyntax(S)
                    WhereClause += "')"
                End If
            End If
        End If

    End Sub
    Function ckQryDate(ByVal StartDate$, ByVal EndDate$, ByVal Evaluator$, ByVal DbColName$, ByRef FirstTime As Boolean) As String

        Dim S = ""
        Dim CH$ = ""
        Dim WhereClause$ = ""
        If UCase(Evaluator$).Equals("OFF") Then
            Return WhereClause$
        Else
            If Evaluator$.Equals("OFF") Then
                Return WhereClause$
            ElseIf Evaluator$.Equals("After") Then
                If FirstTime Then
                    WhereClause$ = " " + DbColName + " > '" + CDate(StartDate).ToString + "'" + vbCrLf
                    FirstTime = False
                Else
                    WhereClause$ = " AND (" + DbColName + " > '" + CDate(StartDate).ToString + "')" + vbCrLf
                End If
            ElseIf Evaluator$.Equals("Before") Then
                If FirstTime Then
                    WhereClause$ = " " + DbColName + " < '" + CDate(StartDate).ToString + "'" + vbCrLf
                    FirstTime = False
                Else
                    WhereClause$ = " AND (" + DbColName + " < '" + CDate(StartDate).ToString + "')" + vbCrLf
                End If
            ElseIf Evaluator$.Equals("Between") Then
                'select * from Production.Product where Sellcdate(StartDate).tostring between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "' " + vbCrLf
                Else
                    WhereClause$ = " AND (" + DbColName + " between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
            ElseIf Evaluator$.Equals("Not Between") Then
                'select * from Production.Product where SellStartDate between ‘2001-06-29′ and ‘2001-07-02′
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "'" + vbCrLf
                Else
                    WhereClause$ = " AND (" + DbColName + " NOT between '" + CDate(StartDate).ToString + "' and '" + CDate(EndDate).ToString + "')" + vbCrLf
                End If
            ElseIf Evaluator$.Equals("On") Then
                If FirstTime Then
                    FirstTime = False
                    WhereClause$ = " " + DbColName + " = '" + CDate(StartDate).ToString + "'" + vbCrLf
                Else
                    WhereClause$ = " AND (" + DbColName + " = '" + CDate(StartDate).ToString + "')" + vbCrLf
                End If
            Else
                Return WhereClause$
            End If

        End If
        Return WhereClause$
    End Function
    Sub AddSlashToDirName(ByRef tDir$)

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
    Sub ListRegistryKeys(ByVal FileExt$, ByRef LB As List(Of String))
        Try
            Dim rootKey As RegistryKey
            rootKey = Registry.ClassesRoot
            Dim S

            Dim regSubKey As RegistryKey

            Dim subk As String

            Dim tmp As RegistryKey
            rootKey = rootKey.OpenSubKey(FileExt, False)
            Debug.Print(rootKey.GetValue("").ToString())
            Debug.Print(rootKey.GetValue("Content Type").ToString())

            Dim ControlApp$ = rootKey.GetValue("Content Type").ToString()

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
        End Try

    End Sub
    Function GetCurrUserName() As String
        Dim S = ""
        S = Environment.UserName.ToString
        Return S
    End Function
    Function GetCurrOsVersionName() As String
        Dim S = ""
        S = Environment.OSVersion.ToString
        Return S
    End Function
    Function GetCurrEnvironmentVersionName() As String
        Dim S = ""
        S = Environment.Version.ToString
        Return S
    End Function
    Function GetCurrSystemDirectory() As String
        Dim S = ""
        S = Environment.SystemDirectory.ToString
        Return S
    End Function
    Function GetCurrUptime() As String
        Dim S = ""
        S = Mid((Environment.TickCount / 3600000), 1, 5) & " :Hours"
        S = Environment.SystemDirectory.ToString
        Return S
    End Function
    Function GetCurrMachineName() As String
        Dim S = ""
        S = Environment.MachineName.ToString
        Return S
    End Function
    Function GetCurrentDirectory() As String
        Dim S = ""
        S = Environment.CurrentDirectory.ToString
        Return S
    End Function
    Function GetUserDomainName() As String
        Dim S = ""
        S = Environment.UserDomainName.ToString
        Return S
    End Function
    Function GetWorkingSet() As String
        Dim S = ""
        S = Environment.WorkingSet.ToString
        Return S
    End Function

    Function isFileArchiveAttributeSet(ByVal FQN$) As Boolean

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

        Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))

        If (fileDetail.Attributes And fileDetail.Attributes.Archive) = fileDetail.Attributes.Archive Then
            'MessageBox.Show(fileDetail.Name & " is Archived")
            Return False
        Else
            'MessageBox.Show(fileDetail.Name & " is NOT Archived")
            Return True
        End If

    End Function
    Function setFileArchiveAttributeSet(ByVal FQN$, ByVal SetOn As Boolean) As Boolean

        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)

        If SetOn = True Then            
            fileDetail.Attributes = fileDetail.Attributes And fileDetail.Attributes.Archive
        Else
            fileDetail.Attributes = fileDetail.Attributes And Not fileDetail.Attributes.Archive
        End If
        
    End Function
    Function setFileArchiveBitOn(ByVal FQN$) As Boolean
        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
        fileDetail.Attributes = fileDetail.Attributes + fileDetail.Attributes.Archive
    End Function
    Function setFileArchiveBitOff(ByVal FQN$) As Boolean
        Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
        fileDetail.Attributes = fileDetail.Attributes - fileDetail.Attributes.Archive
    End Function
    Function ToggleArchiveBit(ByVal filespec)
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
    End Function
    Function isArchiveBitOn(ByVal filespec) As Boolean
        Dim B As Boolean = False
        Dim fso, f
        fso = CreateObject("Scripting.FileSystemObject")
        f = fso.GetFile(filespec)
        If f.attributes And 32 Then
            'f.attributes = f.attributes - 32
            'ToggleArchiveBit = "Archive bit is cleared."
            B = True
        Else
            'f.attributes = f.attributes + 32
            'ToggleArchiveBit = "Archive bit is set."
            B = False
        End If
        Return B
    End Function
    Function genIsAbout(ByVal useFreetext As Boolean, ByVal SearchText$, ByVal isEmailSearch As Boolean) As String
        Dim isAboutClause$ = ""
        Dim SearchStr$ = SearchText$
        Dim CorrectedSearchClause$ = CleanSearchText(SearchText$)
        If isEmailSearch = True Then
            If useFreetext = True Then
                'INNER JOIN FREETEXTTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN FREETEXTTABLE(EMAIL, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT (" + vbCrLf
                isAboutClause$ += CorrectedSearchClause$ + vbCrLf
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + vbCrLf
            Else
                '    INNER JOIN CONTAINSTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", 
                '"susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN CONTAINSTABLE(EMAIL, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT (" + vbCrLf
                isAboutClause$ += CorrectedSearchClause$ + vbCrLf
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + vbCrLf
            End If
        Else
            If useFreetext = True Then
                'INNER JOIN FREETEXTTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN FREETEXTTABLE(dataSource, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT (" + vbCrLf
                isAboutClause$ += CorrectedSearchClause$ + vbCrLf
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + vbCrLf
            Else
                '    INNER JOIN CONTAINSTABLE(dataSource, *,
                '    'ISABOUT ("dale miller", 
                '"susan miller", jessica )' ) AS KEY_TBL
                '    ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause$ += "INNER JOIN CONTAINSTABLE(dataSource, *, " + vbCrLf
                isAboutClause$ += "     'ISABOUT (" + vbCrLf
                isAboutClause$ += CorrectedSearchClause$ + vbCrLf
                isAboutClause$ += ")' ) as KEY_TBL" + vbCrLf
                isAboutClause$ += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + vbCrLf
            End If
        End If

        Return isAboutClause

    End Function
    Function CleanSearchText(ByVal SearchText$) As String
        Dim I As Integer = 0
        Dim A As New ArrayList
        Dim CH As String = ""
        Dim Token$ = ""
        Dim S = ""
        For I = 1 To SearchText.Trim.Length
REEVAL:
            CH = Mid(SearchText, I, 1)
            If CH.Equals(Chr(34)) Then
                '** Get the token in quotes
                Dim PreceedingPlusSign As Boolean = False
                Dim PreceedingMinusSign As Boolean = False
                If Token.Equals("+") Or Token.Equals("-") Then
                    PreceedingPlusSign = True
                    Token = ""
                ElseIf Token.Equals("+") Or Token.Equals("-") Then
                    PreceedingMinusSign = True
                    Token = ""
                Else
                    If Token.Length > 0 Then
                        A.Add(Token)
                    End If
                    Token = ""
                End If

                '** go to the next one
                I += 1
                CH = Mid(SearchText, I, 1)
                Token += CH
                Do While CH <> Chr(34) And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                    Token += CH
                Loop
                'Token = Chr(34) + Token
                If PreceedingPlusSign = True Then
                    Token = "+" + Chr(34) + Token
                ElseIf PreceedingMinusSign = True Then
                    Token = "-" + Chr(34) + Token
                Else
                    Token = Chr(34) + Token
                End If
                A.Add(Token)

                Token = ""
            ElseIf CH.Equals(" ") Then
                '** Skip the blank spaces
                If Token.Equals("+") Or Token.Equals("-") Then
                Else
                    If Token.Length > 0 Then
                        A.Add(Token)
                    End If
                    Token = ""
                End If

                '** go to the next one
                I += 1
                CH = Mid(SearchText, I, 1)
                Do While CH = " " And I <= SearchText.Length
                    I += 1
                    CH = Mid(SearchText, I, 1)
                Loop
                GoTo REEVAL
            ElseIf CH.Equals(",") Then
                '** Skip the blank spaces
                If Token.Length > 0 Then
                    A.Add(Token)
                End If
                Token = ""
            ElseIf CH.Equals("+") Then
                '** Skip the blank spaces
                Token += ""
            ElseIf CH.Equals("-") Then
                '** Skip the blank spaces
                Token += ""
            Else
                Token += CH
            End If
        Next
        If Token.Length > 0 Then
            A.Add(Token)
        End If
        S = ""
        For I = 0 To A.Count - 1
            If I = A.Count - 1 Then
                S = S + A(I).ToString
            Else
                S = S + A(I).ToString + ", "
            End If
            If dDeBug Then
                Debug.Print(S)
            End If
        Next

        Return S

    End Function
End Class

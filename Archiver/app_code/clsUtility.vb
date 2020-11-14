Imports System.Threading
Imports Microsoft.Win32
Imports System.IO
Imports System.Diagnostics.PerformanceCounter
Imports ECMEncryption
Imports System.Text.RegularExpressions

Public Class clsUtility

    Dim LOG As New clsLogging
    Dim ISO As New clsIsolatedStorage
    Dim ENC As New ECMEncrypt
    Dim dblocal As New clsDbLocal

    Function SplitCamelCase(str As String) As String

        Dim LineOut As String = ""
        Dim Dows As MatchCollection = Regex.Matches(str, "[A-Z][a-z]+")

        For Each s As Object In Dows
            LineOut += s.ToString + " "
        Next

        LineOut = LineOut.Trim()
        Return LineOut

    End Function

    Public Function isLongFileNamesAvail() As Boolean
        Dim OsVersion As String = Registry.GetValue("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion", "ProductName", Nothing).ToString
        If OsVersion.ToUpper.Contains("WINDOWS 10") Then
            Return True
        Else
            Return False
        End If
    End Function


    Public Function getOsVersion() As String

        Dim ver As Object = Environment.OSVersion
        Dim VerObj As Object = Environment.OSVersion.Version
        Dim MyVer As Object = My.Computer.Info.OSVersion
        Dim MyVerStr As Object = My.Computer.Info.OSVersion.ToString
        Dim OsVersion As String = Registry.GetValue("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion", "ProductName", Nothing).ToString

        Return OsVersion

    End Function



    Public Enum OnOff
        TurnON = 1
        TurnOFF = 0
    End Enum

    Shared ramCounter As New System.Diagnostics.PerformanceCounter("Memory", "Available MBytes")
    Private Declare Function GetTickCount Lib "kernel32.dll" () As Long

    Private Sub wait(ByVal seconds As Integer)
        For i As Integer = 0 To seconds * 100
            System.Threading.Thread.Sleep(10)
            Application.DoEvents()
        Next
    End Sub

    Public Function getListenerDirs() As List(Of String)

        Dim ListOfDirs As New List(Of String)
        Dim fqn As String = ""
        Dim S() As String = Nothing

        Dim sr As StreamReader = New StreamReader(SQLiteListenerDB)
        Dim strLine As String = String.Empty

        Dim RowDate As DateTime = Nothing
        Dim Rowid As Integer = 0
        Dim action As String = ""
        Dim dir As String = ""
        Dim FileFQN As String = ""
        Dim ext As String = ""
        Dim DirCnt As Integer = 0

        Try

            Do While sr.Peek() >= 0

                strLine = String.Empty
                strLine = sr.ReadLine

                S = strLine.Split("|")

                If ext.Equals("?") Then
                    dir = S(4)
                Else
                    dir = S(3)
                End If
                If Not ListOfDirs.Contains(dir) Then
                    ListOfDirs.Add(dir)
                End If
                DirCnt += 1
            Loop
            Return ListOfDirs
        Catch ex As Exception
            ListOfDirs.Clear()
            Return ListOfDirs
        End Try
    End Function

    Public Function getListenerFiles() As List(Of String)

        Dim ListOfFiles As New List(Of String)
        Dim fqn As String = ""
        Dim S() As String = Nothing

        Dim sr As StreamReader = New StreamReader(SQLiteListenerDB)
        Dim strLine As String = String.Empty

        Dim RowDate As DateTime = Nothing
        Dim Rowid As Integer = 0
        Dim action As String = ""
        Dim dir As String = ""
        Dim FileFQN As String = ""
        Dim ext As String = ""
        Dim DirCnt As Integer = 0
        Try
            Do While sr.Peek() >= 0
                strLine = String.Empty
                strLine = sr.ReadLine
                S = strLine.Split("|")
                RowDate = Convert.ToDateTime(S(0))
                Rowid = Convert.ToInt32(S(1))
                action = S(2)
                dir = S(3)
                FileFQN = S(4)
                ext = S(5)
                '10/11/2020 3:21:27 PM|21|U|C:\Users\wdale\Documents\Visual Studio 2017\Backup Files|C:\Users\wdale\Documents\Visual Studio 2017\Backup Files\Archiver|?
                If Not ext.Equals("?") Then
                    If Not ListOfFiles.Contains(FileFQN) Then
                        ListOfFiles.Add(FileFQN)
                    End If
                    DirCnt += 1
                End If
            Loop
            Return ListOfFiles
        Catch ex As Exception
            ListOfFiles.Clear()
            Return ListOfFiles
        End Try
    End Function

    Function ConvertUrlToFQN(DirPath As String, URL As String, FileExt As String) As String
        Dim S() As String
        Dim WebFQN As String = URL.ToUpper
        WebFQN = WebFQN.Replace(".COM", "")
        WebFQN = WebFQN.Replace("HTTPS", "")
        WebFQN = WebFQN.Replace("HTTP", "")
        WebFQN = WebFQN.Replace("//", "")
        WebFQN = WebFQN.Replace("/", " ")
        WebFQN = WebFQN.Replace(".", " ")
        WebFQN = WebFQN.Replace(":", "")
        WebFQN = WebFQN.Replace("?", " ")
        WebFQN = WebFQN.Replace("=", " ")
        WebFQN = WebFQN.Replace("\", "")
        WebFQN = WebFQN.Replace("*", "")
        WebFQN = WebFQN.Replace("<", "")
        WebFQN = WebFQN.Replace(">", "")
        WebFQN = WebFQN.Replace("|", "")
        WebFQN = WebFQN.Replace("-", " ")
        WebFQN = WebFQN.Replace(",", " ")
        WebFQN = WebFQN.Replace("#", " ")

        Dim sToken As String = ""
        S = WebFQN.Split(" ")
        If S.Count > 0 Then
            WebFQN = ""
            For Each stemp As String In S
                stemp = stemp.ToLower
                If stemp.Length > 0 Then
                    Mid(stemp, 1, 1) = Mid(stemp, 1, 1).ToUpper
                    WebFQN += stemp
                End If
            Next
        End If

        WebFQN = DirPath + WebFQN + FileExt

        Return WebFQN
    End Function

    Function countApplicationInstances(ByVal AppName As String) As Integer
        Dim AppCnt As Integer = 0
        Dim pName As String = ""
        For Each p As Process In Process.GetProcesses
            pName = p.ProcessName.ToUpper
            Console.WriteLine(pName)
            If pName.Equals(AppName) Then
                AppCnt += 1
            End If
        Next
        Return AppCnt
    End Function

    Function isImage(ByVal FQN As String) As Boolean

        Dim fExt As String = ""
        Dim MyFile As New FileInfo(FQN)
        If MyFile.Exists() Then
            Try
                fExt = MyFile.Extension
                fExt = getFileSuffix(FQN)
                If InStr(fExt, ".") = 0 Then
                    fExt = "." + fExt
                End If
            Catch ex As Exception
                Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("clsModi : isImageFile : 10 : " + ex.Message)
            End Try
        Else
            Return False
        End If

        fExt = fExt.ToUpper

        Dim B As Boolean = False

        If fExt.Equals(".JPG") Then
            B = True
        ElseIf fExt.Equals(".JPEG") Then
            B = True
        ElseIf fExt.Equals(".BMP") Then
            B = True
        ElseIf fExt.Equals(".PNG") Then
            B = True
        ElseIf fExt.Equals(".TRF") Then
            B = True
        ElseIf fExt.Equals(".TIFF") Then
            B = True
        ElseIf fExt.Equals(".TIF") Then
            B = True
        ElseIf fExt.Equals(".GIF") Then
            B = True
        ElseIf fExt.Equals(".TIF") Then
            B = True
        Else
            B = False
        End If

        Return B


    End Function

    Sub RemoveBlanks(ByRef tStr As String)
        Dim S As String = tStr
        Dim NewStr As String = ""
        Dim BlankCnt As Integer = 0
        Dim CH As String = ""
        For i As Integer = 1 To S.Length
            CH = Mid(S, i, 1)
            If CH.Equals(" ") Then
                BlankCnt += 1
            ElseIf CH.Equals(Chr(9)) Then
                BlankCnt += 1
            ElseIf CH.Equals(Chr(34)) Then
                BlankCnt += 1
            ElseIf CH.Equals(vbCrLf) Then
                BlankCnt += 1
            ElseIf CH.Equals(vbCr) Then
                BlankCnt += 1
            ElseIf CH.Equals(vbLf) Then
                BlankCnt += 1
            Else
                NewStr = NewStr + CH
            End If
        Next
        tStr = NewStr
    End Sub

    Function spaceCnt(ByVal FQN As String) As Integer

        Dim I As Integer = 0
        Dim iCnt As Integer = 0
        For I = 1 To FQN.Length
            Dim CH As String = Mid(FQN, I, 1)
            If CH.Equals(" ") Then
                iCnt += 1
            End If
        Next
        Return iCnt

    End Function

    Public Function getTempProcessingDir() As String

        Dim S As String = ""

        Try
            S = System.Configuration.ConfigurationManager.AppSettings("TempProcessingDir")
            If spaceCnt(S) > 0 Then
                LOG.WriteToArchiveLog("ERROR: getTempProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\TempUploads\")
                S = "C:\TempUploads\"
                If Not Directory.Exists(S) Then
                    Directory.CreateDirectory(S)
                End If
            End If
        Catch ex As Exception
            S = "C:\TempUploads\"
            If Not Directory.Exists(S) Then
                Directory.CreateDirectory(S)
            End If
        End Try

        If Not Mid(S, S.Length, 1).Equals("\") Then
            S = S + "\"
        End If

        Return S

    End Function

    Public Function GetParentImageProcessingFile() As String

        Dim S As String = ""

        Try
            S = System.Configuration.ConfigurationManager.AppSettings("PdfProcessingDir")
            If spaceCnt(S) > 0 Then
                LOG.WriteToArchiveLog("ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\TempUploads\")
                S = "C:\TempUploads\"
                If Not Directory.Exists(S) Then
                    Directory.CreateDirectory(S)
                End If
            End If
        Catch ex As Exception
            S = "C:\TempUploads\"
            If Not Directory.Exists(S) Then
                Directory.CreateDirectory(S)
            End If
        End Try

        Return S

    End Function

    Public Function getTempPdfWorkingErrorDir() As String
        Dim TempSysDir As String = GetParentImageProcessingFile() + "\ErrorFiles\"

        If Not Directory.Exists(TempSysDir) Then
            Directory.CreateDirectory(TempSysDir)
        End If
        Return TempSysDir

    End Function

    Private Sub ZeroizePdaDir()

        Dim TempSysDir As String = GetParentImageProcessingFile() + "ECM\OCR\Extract"
        If Not Directory.Exists(TempSysDir) Then
            Directory.CreateDirectory(TempSysDir)
        End If

        Dim s As String
        For Each s In System.IO.Directory.GetFiles(TempSysDir)
            Try
                System.IO.File.Delete(s)
            Catch ex As Exception
                Console.WriteLine("99.131 - " + ex.Message)
            End Try

        Next s
    End Sub

    Public Sub StripUnwantedChars(ByRef sText As String)
        Dim NewText As String = ""
        For i As Integer = 1 To sText.Length
            Dim CH As String = Mid(sText, i, 1)
            If CH.Equals("/") Then
                CH = "."
            ElseIf CH.Equals(" ") Then
                CH = "_"
            End If
            If InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_.@-01233456789", CH, CompareMethod.Text) > 0 Then
                NewText = NewText + CH
            End If
        Next
        sText = NewText
    End Sub

    Public Function getNbrDaysComputerRunning() As Integer
        Dim TotalDaysRunning As Integer = 0
        Try
            Dim dTicks As Double 'Store the number of days the systems has been running
            dTicks = GetTickCount / 1000 / 60 / 60 / 24
            Dim T As TimeSpan
            dTicks = dTicks * -1
            Dim DateStartedRunning As Date = Now.AddDays(dTicks)
            T = Now.Subtract(DateStartedRunning)
            TotalDaysRunning = T.TotalDays
        Catch ex As Exception
            TotalDaysRunning = 2
        End Try
        Return TotalDaysRunning
    End Function

    'Here is a call that uses the function above to determine if Excel is installed:
    'MessageBox.Show("Is MS Excel installed? - " & IsApplicationInstalled("Excel.Application").ToString)
    'RESULT:  Is MS Excell Installed? – True
    Function IsApplicationInstalled(ByVal pSubKey As String) As Boolean
        Dim isInstalled As Boolean = False

        ' Declare a variable of type RegistryKey named classesRootRegisteryKey.
        ' Assign the Registry's ClassRoot key to the classesRootRegisteryKey 
        ' variable.
        Dim classesRootRegistryKey As RegistryKey = Registry.ClassesRoot

        ' Declare a variable of type RegistryKey named subKeyRegistryKey.
        ' Call classesRootRegistryKey's OpenSubKey method passing in the 
        ' pSubKey parameter passed into this function. 
        ' Assign the result returned to suKeyRegistryKey.
        Dim subKeyRegistryKey As RegistryKey =
              classesRootRegistryKey.OpenSubKey(pSubKey)

        ' If subKeyRegistryKey was assigned a value...
        If Not subKeyRegistryKey Is Nothing Then
            ' Key exists; application is installed.
            isInstalled = True
        End If

        ' Close the subKeyRgisteryKey.
        subKeyRegistryKey.Close()

        Return isInstalled
    End Function
    Function isOfficeInstalled() As Boolean
        'Microsoft Office Enterprise 2007 | 12 | 0 | 1
        'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
        Dim LOS As New List(Of String)
        LOS = getInstalledSoftware()
        For Each S As String In LOS
            If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
                Dim A() = S.Split("|")
                If A.Length > 1 Then
                    Dim tVal As String = A(1)
                    tVal = tVal.Trim
                    If tVal.Equals("12") Or tVal.Equals("11") Then
                        Return True
                    End If
                End If
            End If
        Next
        Return False
    End Function
    Function isOffice2003Installed() As Boolean
        'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
        'Microsoft Office Enterprise 2007 | 12 | 0 | 1
        'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
        Dim LOS As New List(Of String)
        LOS = getInstalledSoftware()
        For Each S As String In LOS
            If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
                Dim A() = S.Split("|")
                If A.Length > 1 Then
                    Dim tVal As String = A(1)
                    tVal = tVal.Trim
                    If tVal.Equals("11") Then
                        Return True
                    End If
                End If
            End If
        Next
        Return False
    End Function
    Function isOffice2007Installed() As Boolean
        'Microsoft Office Enterprise 2007 | 12 | 0 | 1
        Dim LOS As New List(Of String)
        LOS = getInstalledSoftware()
        For Each S As String In LOS
            If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
                Dim A() = S.Split("|")
                If A.Length > 1 Then
                    Dim tVal As String = A(1)
                    tVal = tVal.Trim
                    If tVal.Equals("12") Then
                        Return True
                    End If
                End If
            End If
        Next
        Return False
    End Function
    Function isOutlookInstalled() As Boolean
        'Update for Microsoft Office Outlook 2007 Help (KB963677)

    End Function
    Function isOutlook2003Installed() As Boolean
        'Update for Microsoft Office Outlook 2007 Help (KB963677)

    End Function
    Function isOutlook2007Installed() As Boolean
        'Update for Microsoft Office Outlook 2007 Help (KB963677)

    End Function
    Function getInstalledSoftware() As List(Of String)

        If (gSoftware.Count > 0) Then
            Return gSoftware
        End If

        Dim strList As New List(Of String)
        Dim xdebug As Boolean = False
        Dim UninstallKey As String = ""
        UninstallKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
        Dim RK As RegistryKey = Registry.LocalMachine.OpenSubKey(UninstallKey)
        For Each skName As String In RK.GetSubKeyNames
            Using sk As RegistryKey = RK.OpenSubKey(skName)
                Dim PackageName As String = ""
                Try
                    PackageName = sk.GetValue("DisplayName")
                    If xdebug.Equals(True) Then
                        Console.WriteLine(PackageName)
                    End If
                    If PackageName Is Nothing Then
                        Console.WriteLine(PackageName)
                    ElseIf PackageName.Trim.Length > 0 Then

                        Try
                            Dim VersionMajor As String = sk.GetValue("VersionMajor")
                            Dim VersionMinor As String = sk.GetValue("VersionMinor")
                            Dim WindowsInstaller As String = sk.GetValue("WindowsInstaller")
                            If VersionMajor = Nothing Then
                                If xdebug.Equals(True) Then
                                    Debug.Print("No VersionMajor")
                                End If
                            ElseIf VersionMajor.Trim.Length > 0 Then
                                PackageName = PackageName + " | " + VersionMajor
                            End If
                            If VersionMinor = Nothing Then
                                If xdebug.Equals(True) Then
                                    Debug.Print("No VersionMinor")
                                End If
                            ElseIf VersionMinor.Trim.Length > 0 Then
                                PackageName = PackageName + " | " + VersionMinor
                            End If
                            If WindowsInstaller = Nothing Then
                                If xdebug.Equals(True) Then
                                    Debug.Print("No WindowsInstaller")
                                End If
                            ElseIf WindowsInstaller.Trim.Length > 0 Then
                                PackageName = PackageName + " | " + WindowsInstaller
                            End If
                        Catch ex As Exception
                            PackageName = PackageName + " | " + "NA"
                            If xdebug.Equals(True) Then
                                Debug.Print("NOTICE 01A: No entry found, skipping...")
                            End If
                        End Try

                        strList.Add(PackageName)

                    End If
                Catch ex As Exception
                    If xdebug.Equals(True) Then
                        Debug.Print("NOTICE 01b: No entry found, skipping...")
                    End If
                End Try
            End Using
        Next
        strList.Sort()
        gSoftware = strList
        Return strList
    End Function

    Public Function RemoveSingleQuotes(ByVal tVal As String) As String

        tVal = tVal.Replace("''", "'")
        tVal = tVal.Replace("'", "''")

        Return tVal
    End Function
    Public Function RemoveBadChars(ByVal tVal As String) As String
        Try
            Dim i As Integer = Len(tVal)
            Dim ch As String = ""
            Dim S As String = "0123456789 abcdefghijklmnopqrstuvwxyz."
            For i = 1 To Len(tVal)
                ch = Mid(tVal, i, 1)
                If InStr(S, ch, CompareMethod.Text) > 0 Then
                Else
                    Mid(tVal, i, 1) = " "
                End If
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsUtility:RemoveBadChars - " + ex.Message + vbCrLf + ex.StackTrace)
        End Try

        Return tVal.Trim
    End Function
    Public Function RemoveSingleQuotesV1(ByVal tVal As String) As String
        Dim I As Integer = 0
        Dim CH As String = ""
        For I = 1 To Len(tVal)
            CH = Mid(tVal, I, 1)
            If CH = "'" Then
                Mid(tVal, I, 1) = "`"
            End If
        Next
        Return tVal
    End Function

    '''
    ''' RemoveSingleQuotes - DO NOT SHOOT THE MESSENGER.
    ''' This is a huge MS isssue. Reverse tick cannot be 
    ''' be processed in WEIGHTED searhes as it is in 
    ''' a non weighted search - pos THAT IT IS - it is what we have 
    ''' to deal with. So be it. Check out this code and love it!
    ''' SHIT - am I good or what !!!
    '''
    Public Function RemoveSingleQuotes(ByVal tVal As String, ByVal isWeightedSearch As Boolean) As String
        Dim A As String()
        Dim NewStr As String = ""
        If isWeightedSearch = True Then
            If InStr(1, tVal, "`") > 0 Then
                tVal = Me.ReplaceSingleQuotes(tVal)
            End If
            If InStr(1, tVal, "''") > 0 Then
                NewStr = tVal
            ElseIf InStr(1, tVal, "'") > 0 Then
                A = tVal.Split("'")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
                NewStr = Mid(NewStr, 1, NewStr.Length - 2)
            ElseIf InStr(1, tVal, "`") > 0 Then
                A = tVal.Split("`")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
                NewStr = Mid(NewStr, 1, NewStr.Length - 2)
            Else
                NewStr = tVal
            End If
            NewStr = NewStr.Trim
        ElseIf isWeightedSearch = True Then
            If InStr(1, tVal, "`") > 0 Then
                A = tVal.Split("`")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
            Else
                NewStr = tVal
            End If
            NewStr = NewStr.Trim
        Else
            If InStr(1, tVal, "''") > 0 Then
                NewStr = tVal
            Else
                NewStr = RemoveSingleQuotes(tVal)
            End If
        End If
        Return NewStr
    End Function

    Public Function RemoveUnwantedCharacters(ByVal tVal As String) As String
        tVal = tVal.Trim
        Dim UCH As String = "()[]"
        Dim CH As String
        For i As Integer = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            If InStr(UCH, CH) > 0 Then
                Mid(tVal, i, 1) = " "
            End If
        Next
        Return tVal
    End Function

    Public Function RemoveCrLF(ByVal tVal As String) As String
        tVal = tVal.Trim
        Dim CH As String
        For i As Integer = 1 To tVal.Length
            CH = Mid(tVal, i, 1)
            If CH = vbCr Then
                Mid(tVal, i, 1) = " "
            End If
            If CH = vbLf Then
                Mid(tVal, i, 1) = " "
            End If
        Next
        Return tVal
    End Function

    Public Function fixSingleQuotes(ByVal tVal As String) As String
        Dim tempStr As String = ""
        Dim bLastCharIsQuote As Boolean = False

        tVal = tVal.Trim
        If tVal.Length = 0 Then
            Return tVal
        End If
        Dim CH As String = Mid(tVal, tVal.Length, 1)
        If CH.Equals("'") Then
            bLastCharIsQuote = True
        End If

        Dim A As String() = Split(tVal, "'")
        If InStr(tVal, "'") > 0 Then
            For i As Integer = 0 To UBound(A)
                tempStr += A(i) + "''"
            Next
        Else
            tempStr = tVal
            Return tempStr
        End If

        tempStr = Mid(tempStr, 1, tempStr.Length - 2)

        Return tempStr
    End Function

    Public Function setFilelenUnits(file_Length As Integer) As String

        Dim fl As Decimal = Convert.ToDecimal(file_Length)
        Dim nbr As String = ""
        Dim units As String = ""
        Dim bytes As Integer = 0
        Dim kb As Decimal = 1000
        Dim mb As Decimal = kb * 1000
        Dim gb As Decimal = mb * 1000
        Dim tb As Decimal = gb * 1000
        Dim pb As Decimal = gb * 1000

        If file_Length < kb Then
            units = " Bytes"
            nbr = file_Length.ToString + units
        ElseIf file_Length >= kb And file_Length < mb Then
            fl = fl / kb
            fl = Math.Round(fl, 2)
            units = "Kb"
            nbr = fl.ToString + units
        ElseIf file_Length >= mb And file_Length < gb Then
            fl = fl / mb
            fl = Math.Round(fl, 2)
            units = "Mb"
            nbr = fl.ToString + units
        ElseIf file_Length >= gb And file_Length < tb Then
            fl = fl / gb
            fl = Math.Round(fl, 2)
            units = "Gb"
            nbr = fl.ToString + units
        Else
            units = "-HUGE"
            nbr = fl.ToString + units
        End If

        Return nbr
    End Function


    Public Function ReplaceSingleQuotes(ByVal tStr As String) As String

        Dim TgtStr As String = "''"
        Dim S1 As String = ""
        Dim S2 As String = ""
        Dim L As Integer = Len(TgtStr)
        Dim I As Integer = 0

        Do While InStr(tStr, TgtStr, CompareMethod.Text) > 0
            I = InStr(tStr, TgtStr, CompareMethod.Text)
            S1 = Mid(tStr, 1, I - 1)
            S2 = Mid(tStr, I + L)
            tStr = S1 + "'" + S2
        Loop

        Return tStr
    End Function

    Public Function ReplaceSingleQuotesV1(ByVal tVal As String) As String
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


    Public Function RemoveCommas(ByVal tVal As String) As String
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

    Public Function RemoveOcrProblemChars(ByVal tVal As String) As String
        Dim i As Integer = Len(tVal)
        Dim ch As String = ""
        For i = 1 To Len(tVal)
            ch = Mid(tVal, i, 1)
            If ch = "," Then
                Mid(tVal, i, 1) = "z"
            ElseIf ch = " " Then
                Mid(tVal, i, 1) = "z"
            ElseIf ch = "#" Then
                Mid(tVal, i, 1) = "z"
            ElseIf ch = "@" Then
                Mid(tVal, i, 1) = "z"
            End If
        Next
        Return tVal
    End Function
    Sub RemoveDoubleSlashes(ByRef FQN As String)
        Dim i As Integer = 0
        Dim s1 As String = ""
        Dim S2 As String = ""
        Dim s As String = FQN
        Do While InStr(1, s, "//") > 0
            i = InStr(1, s, "//")
            s1 = Mid(s, 1, i + 1)
            S2 = Mid(s, 1, i + 2)
            s = s1 + S2
        Loop
        FQN = s
    End Sub

    Sub setConnectionStringTimeout(ByRef ConnStr As String)

        Dim I As Integer = 0
        Dim S As String = ""
        Dim NewConnStr As String = ""
        S = ConnStr
        I = InStr(1, S, "Connect Timeout =", CompareMethod.Text)
        If I > 0 Then
            Dim SqlTimeout As String = SystemSqlTimeout
            If SqlTimeout.Trim.Length = 0 Then
                Return
            Else
                I = I + "Connect Timeout =".Length
                NewConnStr = setNewTimeout(ConnStr, I)
            End If
        Else
            NewConnStr = S
            NewConnStr += "; Connect Timeout = 600;"
        End If

        GC.Collect()
        GC.WaitForFullGCApproach()
        ConnStr = NewConnStr
    End Sub
    Sub setConnectionStringTimeout(ByRef ConnStr As String, ByVal TimeOutSecs As String)

        Dim I As Integer = 0
        Dim S As String = ""
        Dim NewConnStr As String = ""
        S = ConnStr
        I = InStr(1, S, "Connect Timeout =", CompareMethod.Text)
        If I > 0 Then
            Dim SqlTimeout As String = SystemSqlTimeout
            If SqlTimeout.Trim.Length = 0 Then
                Return
            Else
                I = I + "Connect Timeout =".Length
                NewConnStr = setNewTimeout(ConnStr, I, TimeOutSecs)
            End If
        Else
            NewConnStr = S
            NewConnStr += "; Connect Timeout = " + TimeOutSecs + ";"
        End If

        GC.Collect()
        GC.WaitForFullGCApproach()
        ConnStr = NewConnStr
    End Sub
    Function setNewTimeout(ByVal tgtStr As String, ByVal StartingPoint As Integer, ByVal NewVal As String) As String
        Dim NextNumber As String = ""
        Dim NumberStartPos As Integer = 0
        Dim NumberEndPos As Integer = 0
        Dim NewStr As String = ""
        Dim S1 As String = ""
        Dim S2 As String = ""
        Try
            Dim I As Integer = 0
            Dim CH As String = Mid(tgtStr, StartingPoint, 1)
            Dim bFound As Boolean = False
            Do Until InStr("0123456789", CH) > 0 Or StartingPoint > tgtStr.Length
                StartingPoint += 1
                CH = Mid(tgtStr, StartingPoint, 1)
                bFound = True
            Loop
            If Not bFound Then
                Return tgtStr
            Else
                NumberStartPos = StartingPoint
                NumberEndPos = StartingPoint
                Do Until InStr("0123456789", CH) = 0 Or NumberEndPos >= tgtStr.Length
                    NumberEndPos += 1
                    CH = Mid(tgtStr, NumberEndPos, 1)
                Loop
            End If
            Dim CurrVal As String = Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1)
            S1 = Mid(tgtStr, 1, NumberStartPos - 1)
            S2 = Mid(tgtStr, NumberEndPos + 1)
            NewStr = S1 + " " + NewVal + " " + S2
        Catch ex As Exception
            LOG.WriteToArchiveLog("FindNextNumberInStr: " + ex.Message)
            NewStr = tgtStr
        End Try
        Return NewStr
    End Function
    Function setNewTimeout(ByVal tgtStr As String, ByVal StartingPoint As Integer) As String
        Dim NextNumber As String = ""
        Dim NumberStartPos As Integer = 0
        Dim NumberEndPos As Integer = 0
        Dim NewStr As String = ""
        Dim S1 As String = ""
        Dim S2 As String = ""
        Try
            Dim I As Integer = 0
            Dim CH As String = Mid(tgtStr, StartingPoint, 1)
            Dim bFound As Boolean = False
            Do Until InStr("0123456789", CH) > 0 Or StartingPoint > tgtStr.Length
                StartingPoint += 1
                CH = Mid(tgtStr, StartingPoint, 1)
                bFound = True
            Loop
            If Not bFound Then
                Return tgtStr
            Else
                NumberStartPos = StartingPoint
                NumberEndPos = StartingPoint
                Do Until InStr("0123456789", CH) = 0 Or NumberEndPos >= tgtStr.Length
                    NumberEndPos += 1
                    CH = Mid(tgtStr, NumberEndPos, 1)
                Loop
            End If
            Dim CurrVal As String = Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1)
            S1 = Mid(tgtStr, 1, NumberStartPos - 1)
            S2 = Mid(tgtStr, NumberEndPos + 1)
            NewStr = S1 + " " + SystemSqlTimeout + " " + S2
        Catch ex As Exception
            LOG.WriteToArchiveLog("FindNextNumberInStr: " + ex.Message)
            NewStr = tgtStr
        End Try
        Return NewStr
    End Function

    Public Function getFileSuffix(ByVal FQN As String) As String
        Dim i As Integer = 0
        Dim ch As String = ""
        Dim suffix As String = ""
        For i = FQN.Length To 1 Step -1
            ch = Mid(FQN, i, 1)
            If ch = "." Then
                suffix = Mid(FQN, i + 1)
                Exit For
            End If
        Next
        Return suffix
    End Function
    Public Function substConnectionStringServer(ByVal ConnStr As String, ByVal Server As String) As String
        'Data Source=XXX;Initial Catalog=ECM.Thesaurus;Integrated Security=True; Connect Timeout = 30

        Dim I As Integer = 0
        Dim Str1 As String = ""
        Dim Str2 As String = ""
        Dim NewStr As String = ""

        Try
            I = InStr(ConnStr, "=")
            Str1 = Mid(ConnStr, 1, I)
            I = InStr(I + 1, ConnStr, ";")
            Str2 = Mid(ConnStr, I)
            NewStr = Str1 + Server + Str2
        Catch ex As Exception
            Return ""
        End Try
        Return NewStr
    End Function
    Public Function getLicenseFromFile(ByVal CustomerID As String, ByVal ServerName As String, ByVal LicenseDirectory As String) As String
        Dim B As Boolean = True
        Dim bApplied As Boolean = False
        If CustomerID.Length = 0 Then
            MessageBox.Show("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return ""
        End If

        Try
            Dim SelectedServer As String = ServerName
            If SelectedServer.Length = 0 Then
                MessageBox.Show("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
                Return False
            End If
            Dim FQN As String = LicenseDirectory + "\" + "EcmLicense." + ServerName + ".txt"
            Dim S As String = LoadLicenseFile(FQN)
            If S.Length = 0 Then
                Return ""
            Else
                '** Put the license into the DBARCH
                Return S
            End If
        Catch ex As Exception
            Return ""
        End Try
    End Function
    Public Function LoadLicenseFile(ByVal FQN As String) As String
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            MessageBox.Show("Failed to load License file: " + vbCrLf + Ex.Message)
            'LogThis("clsDatabaseARCH : LoadLicenseFile : 5914 : " + Ex.Message)
            Return ""
        End Try
        Return strContents
    End Function

    ''' <summary>
    ''' Sets the archive bit.
    ''' </summary>
    ''' <param name="filespec">The filespec.</param>
    ''' <param name="Action">The action.</param>
    Public Sub SetArchiveBit(filespec As String, Action As OnOff)
        Dim fs, f

        fs = CreateObject("Scripting.FileSystemObject")
        f = fs.GetFile(fs.GetFileName(filespec))
        If f.attributes And 32 Then
            'r = Debug.Print "The Archive bit is set, do you want to clear it?", vbYesNo, "Set/Clear Archive Bit" 
            If Action = OnOff.TurnOFF Then
                f.attributes = f.attributes - 32
                Console.WriteLine("Archive bit is cleared.")
            Else
                Console.WriteLine("Archive bit remains set.")
            End If
        Else
            'r = Console.WriteLine("The Archive bit is not set. Do you want to set it?", vbYesNo, "Set/Clear Archive Bit")
            If Action = OnOff.TurnON Then
                f.attributes = f.attributes + 32
                Console.WriteLine("Archive bit is set.")
            Else
                Console.WriteLine("Archive bit remains clear.")
            End If
        End If
    End Sub

    Function ckArchiveBit(ByVal FQN As String) As Boolean

        Dim fs, f
        fs = CreateObject("Scripting.FileSystemObject")
        f = fs.GetFile(fs.GetFileName(FQN))
        If f.attributes And 32 Then
            Return True
        Else
            Return False
        End If

        'Dim FI As New FileInfo(FQN)
        'Dim fAttr As FileAttribute
        'fAttr = File.GetAttributes(FQN)

        'Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttribute.Archive) = FileAttribute.Archive)
        'Dim bArchive As Boolean = FileAttribute.Archive
        'Return isArchive

    End Function

    Sub setArchiveBitToNoArchNeeded(ByVal FQN As String)

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttribute
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttribute.Archive) = FileAttribute.Archive)
        Dim bArchive As Boolean = FileAttribute.Archive

        If isArchive = False Then
            File.SetAttributes(FQN, -32)
        End If


        'Try
        '    Dim fso, f
        '    fso = CreateObject("Scripting.FileSystemObject")
        '    f = fso.GetFile(FQN)

        '    If f.attributes And 32 Then
        '        f.attributes = f.attributes - 32
        '        'ToggleArchiveBit = "Archive bit is cleared."
        '    Else
        '        f.attributes = f.attributes + 32
        '        'ToggleArchiveBit = "Archive bit is set."
        '    End If
        'Catch ex As Exception
        '    messagebox.show("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
        'End Try

    End Sub
    Sub setArchiveBitFasle(ByVal FQN As String)

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttribute
        FI.Attributes = FileAttributes.Archive
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) & FileAttribute.Archive) = FileAttribute.Archive)
        If isArchive = False Then
            FI.Attributes = FI.Attributes - 32
        End If

    End Sub

    Sub ExtendTimeoutBySize(ByRef ConnectionString As String, ByVal currFileSize As Double)

        Dim NewTimeOut As Double = 30

        If currFileSize > 1000000 And currFileSize < 2000000 Then
            NewTimeOut = 90
        ElseIf currFileSize >= 2000000 And currFileSize < 5000000 Then
            NewTimeOut = 180
        ElseIf currFileSize >= 5000000 And currFileSize < 10000000 Then
            NewTimeOut = 360
        ElseIf currFileSize >= 10000000 Then
            NewTimeOut = 600
        Else
            Return
        End If


        Dim InsertConnStr As String = ConnectionString
        Dim S1 As String = ""
        Dim II As Integer = InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text)
        If II > 0 Then
            II = InStr(II + 5, InsertConnStr, "=")
            If II > 0 Then
                Dim K As Integer = InStr(II + 1, InsertConnStr, ";")
                If K > 0 Then
                    Dim S2 As String = ""
                    '** The connect time is delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S2 = Mid(InsertConnStr, K)
                    S1 = S1 + NewTimeOut.ToString + S2
                    InsertConnStr = S1
                Else
                    '** The connect time is NOT delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S1 = S1 + NewTimeOut.ToString
                    InsertConnStr = S1
                End If
            End If
        End If

    End Sub

    Sub ExtendTimeoutByCount(ByRef ConnectionString As String, ByVal RecordCount As Double)

        Dim NewTimeOut As Double = 30

        If RecordCount > 1000 And RecordCount < 2000 Then
            NewTimeOut = 90
        ElseIf RecordCount >= 2000 And RecordCount < 5000 Then
            NewTimeOut = 180
        ElseIf RecordCount >= 5000 And RecordCount < 10000 Then
            NewTimeOut = 360
        ElseIf RecordCount >= 10000 Then
            NewTimeOut = 600
        Else
            Return
        End If


        Dim InsertConnStr As String = ConnectionString
        Dim S1 As String = ""
        Dim II As Integer = InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text)
        If II > 0 Then
            II = InStr(II + 5, InsertConnStr, "=")
            If II > 0 Then
                Dim K As Integer = InStr(II + 1, InsertConnStr, ";")
                If K > 0 Then
                    Dim S2 As String = ""
                    '** The connect time is delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S2 = Mid(InsertConnStr, K)
                    S1 = S1 + NewTimeOut.ToString + S2
                    InsertConnStr = S1
                Else
                    '** The connect time is NOT delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S1 = S1 + NewTimeOut.ToString
                    InsertConnStr = S1
                End If
            End If
        End If

    End Sub

    Function HashCalc(ByVal S As String) As Double

        Dim AR As String()

        Dim I As Integer = 0
        Dim a As Double = 1
        For I = 1 To Len(S)
            a = Asc(Mid(S, I, 1)) * 1000 + Asc(Mid(S, I, 1)) + I
            a = System.Math.Sqrt(a * I * Asc(Mid(S, I, 1))) 'Numeric Hash
        Next I

        AR = S.Split(".")
        For I = 0 To UBound(AR)
            If IsNumeric(AR(I)) Then
                a = a + Val(AR(I))
            End If
        Next

        a = Math.Round(a, 4)
        Return a

    End Function

    Function HashName(ByVal sName As String) As Double
        Dim dHash As Double = 0
        dHash = HashCalc(sName)
        Return dHash
    End Function

    Function HashFqn(ByVal FQN As String) As String

        Dim dHash As Double = 0
        dHash = HashCalc(FQN)

        Dim I As Integer = FQN.Length
        Dim sHash As String = FQN.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashDirName(ByVal DirName As String) As String

        Dim dHash As Double = 0
        dHash = HashCalc(DirName)

        Dim I As Integer = DirName.Length
        Dim sHash As String = DirName.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashFileName(ByVal FileName As String) As String

        Dim dHash As Double = 0
        dHash = HashCalc(FileName)

        Dim I As Integer = FileName.Length
        Dim sHash As String = FileName.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashDirFileName(ByVal DirName As String, ByVal FileName As String) As String

        Dim sHash As String = HashDirName(DirName) + ":" + HashFileName(FileName)
        Return sHash

    End Function


    Sub SaveNewUserSettings()
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100")
        'Dim ECMDB  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        'log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB )
        Dim ECMDB As String = My.Settings("UserDefaultConnString")
        'log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB )

        My.Settings("UpgradeSettings") = False
        My.Settings("DB_EcmLibrary") = My.Settings("UserDefaultConnString")
        My.Settings("DB_Thesaurus") = My.Settings("UserThesaurusConnString")
        My.Settings.Save()

        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 400 " + My.Settings("DB_EcmLibrary"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 500 " + My.Settings("DB_Thesaurus"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 600 " + My.Settings("UserDefaultConnString"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 700 " + My.Settings("UserThesaurusConnString"))

    End Sub

    Function EnumerateDiskDrives(ByRef Drives As SortedList(Of String, String)) As Boolean

        ' Dim fso As New Scripting.FileSystemObject()
        Dim objDrive
        Dim objFSO As Object

        objFSO = CreateObject("Scripting.FileSystemObject")
        Dim colDrives = objFSO.Drives

        For Each objDrive In colDrives
            Dim DriveType As String = ""
            Dim DriveLetter As String = objDrive.DriveLetter
            Dim NumData As Integer = objDrive.drivetype
            Select Case NumData
                Case 1
                    DriveType = "Removable"
                Case 2
                    DriveType = "Fixed"
                Case 3
                    DriveType = "Network"
                Case 4
                    DriveType = "CD-ROM"
                Case 5
                    DriveType = "RAM Disk"
                Case Else
                    DriveType = "Unknown"
            End Select
            If Drives.IndexOfKey(DriveLetter) >= 0 Then
            Else
                Drives.Add(DriveLetter, DriveType)
            End If
        Next

    End Function

    Sub xSaveCurrentConnectionInfo()

        Dim ENC As New ECMEncrypt

        Dim TempDir As String = Environment.GetEnvironmentVariable("temp")
        Dim EcmConStr As String = "ECM" + Chr(254)
        Dim ThesaurusStr As String = "THE" + Chr(254)
        Dim FileName As String = "EcmLoginInfo.DAT"
        Dim FQN As String = TempDir + "\" + FileName


        Dim oFile As System.IO.File
        Dim oWrite As System.IO.StreamWriter

        Try
            EcmConStr += My.Settings("UserDefaultConnString")
            ThesaurusStr += My.Settings("UserThesaurusConnString")

            oWrite = oFile.CreateText(FQN)

            EcmConStr = ENC.AES256EncryptString(EcmConStr)
            ThesaurusStr = ENC.AES256EncryptString(ThesaurusStr)
            oWrite.WriteLine(EcmConStr)
            oWrite.WriteLine(ThesaurusStr)
            oWrite.Close()
        Catch ex As Exception
            LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message)
            LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace)
        Finally
            oWrite = Nothing
            oFile = Nothing
        End Try

    End Sub
    Sub xgetCurrentConnectionInfo()

        Try
            LOG.WriteToInstallLog("Track 1")
            Dim ENC As New ECMEncrypt

            Dim TempDir As String = Environment.GetEnvironmentVariable("temp")
            Dim EcmConStr As String = "ECM" + Chr(254)
            Dim ThesaurusStr As String = "THE" + Chr(254)
            Dim FileName As String = "EcmLoginInfo.DAT"
            Dim FQN As String = TempDir + "\" + FileName
            Dim LineIn As String = ""
            Dim oFile As System.IO.File
            Dim oRead As System.IO.StreamReader
            LOG.WriteToInstallLog("Track 2")
            Dim F As File
            If Not F.Exists(FQN) Then
                oRead.Close()
                oRead = Nothing
                oFile = Nothing
                Return
            End If
            LOG.WriteToInstallLog("Track 3")
            Try
                oRead = oFile.OpenText(FQN)
                Dim NeedsSaving As Boolean = False
                While oRead.Peek <> -1
                    LineIn = oRead.ReadLine()
                    LineIn = ENC.AES256DecryptString(LineIn)

                    Dim A As String() = LineIn.Split("?")
                    Dim tCode As String = A(0)
                    Dim cs As String = A(1)

                    If tCode.Equals("ECM") Then
                        My.Settings("DB_EcmLibrary") = cs
                        My.Settings("UserDefaultConnString") = cs
                        NeedsSaving = True
                    End If
                    If tCode.Equals("THE") Then
                        My.Settings("DB_Thesaurus") = cs
                        My.Settings("UserThesaurusConnString") = cs
                        NeedsSaving = True
                    End If

                End While
                If NeedsSaving = True Then
                    My.Settings.Save()
                End If
            Catch ex As Exception
                LOG.WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.Message)
                LOG.WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.StackTrace)
            Finally
                oRead.Close()
                oFile = Nothing
                ENC = Nothing
            End Try
        Catch ex As Exception
            LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message)
            LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace)
        End Try

    End Sub

    Public Sub CleanText(ByRef sText As String)
        For i As Integer = 1 To sText.Length
            Dim CH As String = Mid(sText, i, 1)
            If InStr("abcdefghijklmnopqrstuvwxyz .,'`-+%@01233456789~|", CH, CompareMethod.Text) = 0 Then
                Mid(sText, i, 1) = " "
            End If
        Next
    End Sub

    Function genEmailIdentifier(ByVal CreatedTime As DateTime, ByVal SenderEmailAddress As String, Subject As String) As String

        Try
            If Subject.Length = 0 Then
                Subject = " "
            End If

            Dim HashKey As String = ENC.getSha1HashKey(Subject)

            Dim EmailIdentifier As String = SenderEmailAddress + "|" + CreatedTime.ToString + "|" + HashKey
            EmailIdentifier = RemoveSingleQuotes(EmailIdentifier)
            RemoveBlanks(EmailIdentifier)
            CleanText(EmailIdentifier)

            Return EmailIdentifier
        Catch ex As Exception
            LOG.WriteToInstallLog("ERROR: 400.22 - genEmailIdentifier : " + ex.Message)
            Return ""
        End Try


    End Function

    Function genEmailIdentifierV2(msgBody As String, ByVal MessageSize As Integer, ByVal CreatedTime As String, ByVal SenderEmailAddress As String, ByVal Subject As String, NbrAttachments As Integer) As String

        Dim HashKey As String = ENC.getSha1HashKey(msgBody)

        Dim EmailIdentifier As String = MessageSize.ToString + "~" + CreatedTime + "~" + SenderEmailAddress + "~" + Mid(Subject, 1, 80) + "~" + NbrAttachments.ToString + "~" + HashKey
        EmailIdentifier = RemoveSingleQuotes(EmailIdentifier)
        RemoveBlanks(EmailIdentifier)
        CleanText(EmailIdentifier)

        Return EmailIdentifier

    End Function

    Sub ckSqlQryForDoubleKeyWords(ByRef MyQry As String)
        For i As Integer = 1 To MyQry.Length
            Dim CH As String = ""
            CH = Mid(MyQry, i, 1)
            If CH.Equals(vbCrLf) Then
                Mid(MyQry, i, 1) = " "
            End If
        Next
        Dim A As String() = Split(MyQry, " ")

        Dim Token As String = ""
        Dim PrevToken As String = ""

        For i As Integer = 0 To UBound(A)
            Token = A(i).Trim
            If InStr(Token, "SenderEmailAddress", CompareMethod.Text) > 0 Then
                Console.WriteLine("Here")
            End If
            If Token.Length > 0 Then
                If Token.ToUpper.Equals("AND") And PrevToken.ToUpper.Equals("AND") Then
                    A(i) = ""
                End If
                If Token.ToUpper.Equals("AND") And PrevToken.ToUpper.Equals("OR") Then
                    A(i) = ""
                End If
                If Token.ToUpper.Equals("OR") And PrevToken.ToUpper.Equals("OR") Then
                    A(i) = ""
                End If
                PrevToken = Token
            End If
        Next

        MyQry = ""
        For i As Integer = 0 To UBound(A)
            MyQry = MyQry + A(i) + " "
            Token = A(i)
            If Token.Length > 0 Then
                If Token.ToUpper.Equals("FROM") Then
                    MyQry = vbCrLf + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("WHERE") Then
                    MyQry = vbCrLf + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("AND") Then
                    MyQry = vbCrLf + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("OR") Then
                    MyQry = vbCrLf + vbTab + MyQry
                End If
                PrevToken = Token
            End If
        Next
        'Clipboard.Clear()
        'Clipboard.SetText(MyQry)
    End Sub

    Sub AddHiveSearch(ByRef tSql As String, ByVal HiveServers As List(Of String))

        If InStr(tSql, "HIVE_", CompareMethod.Text) > 0 Then
            Return
        End If

        Dim ModifiedList As New List(Of String)
        Dim NewList As New List(Of String)
        Dim tempSql As String = ""
        Dim tStr As String = ""
        Dim OrderByClause As String = ""
        Dim A() As String = tSql.Split(vbCrLf)
        For I As Integer = 0 To UBound(A) - 1
            tStr = A(I).Trim
            If InStr(tStr, "order by", CompareMethod.Text) > 0 Then
                A(I) = ""
                OrderByClause = tStr
            ElseIf tStr.Length = 0 Then
            Else
                NewList.Add(tStr)
            End If
        Next

        ModifiedList.Clear()
        For I As Integer = 0 To NewList.Count - 1
            If NewList(I).Trim.Length > 0 Then
                Console.WriteLine(NewList(I))
                ModifiedList.Add(NewList(I))
            End If
        Next

        ModifiedList.Add("UNION ALL" + vbCrLf)

        For I As Integer = 0 To ModifiedList.Count - 1
            Console.WriteLine(ModifiedList(I))
        Next

        For I As Integer = 0 To HiveServers.Count - 1
            Dim SvrAlias As String = HiveServers(I)
            For J As Integer = 0 To NewList.Count - 1
                tStr = NewList(J)
                Console.WriteLine(tStr)
                If InStr(tStr, " FROM ", CompareMethod.Text) > 0 Then
                    Dim X As Integer = InStr(tStr, " FROM ", CompareMethod.Text)
                    Console.WriteLine(NewList(J))
                    Dim S1 As String = Mid(tStr, 1, X - 1)
                    Dim S2 As String = Mid(tStr, X + " FROM ".Length)
                    tStr = S1 + " FROM " + SvrAlias + ".[ECM.Library].dbo." + S2
                    Console.WriteLine(tStr)
                    Debug.Print(tStr)
                Else
                    If tStr.Length > 5 Then
                        If Mid(tStr.ToUpper, 1, 5).Equals("FROM ") Then
                            Dim X As Integer = InStr(tStr, " FROM ", CompareMethod.Text)
                            Console.WriteLine(NewList(J))
                            Dim S1 As String = Mid(tStr, 1, 5)
                            Dim S2 As String = Mid(tStr, 6)
                            tStr = S1 + SvrAlias + ".[ECM.Library].dbo." + S2
                            Console.WriteLine(tStr)
                            Debug.Print(tStr)
                        End If
                    End If

                End If
                ModifiedList.Add(tStr)
            Next
            If I < HiveServers.Count - 1 Then
                ModifiedList.Add("UNION ALL")
                ModifiedList.Add("/**************************/")
            End If
        Next

        ModifiedList.Add(OrderByClause + vbCrLf)

        tempSql = ""

        For I As Integer = 0 To ModifiedList.Count - 1
            tempSql += ModifiedList(I) + vbCrLf
            Console.WriteLine(ModifiedList(I))
        Next

        Clipboard.Clear()
        Clipboard.SetText(tempSql)

        Console.WriteLine(tempSql)

        tSql = tempSql

    End Sub

    Sub StripSingleQuotes(ByRef S As String)

        If S Is Nothing Then
            S = " "
            Return
        End If

        Try
            If S.Contains("'") Then
                For i As Integer = 1 To S.Length
                    Dim CH As String = Mid(S, i, 1)
                    If CH.Equals("'") Then
                        Mid(S, i, 1) = " "
                    End If
                Next
            End If
            S = S.Trim
        Catch ex As Exception
            Console.WriteLine("Notice: 199.1z2 - " + ex.Message)
        End Try

    End Sub

    Sub StripSemiColon(ByRef S As String)

        If S Is Nothing Then
            S = " "
            Return
        End If

        Try
            If S.Contains(";") Then
                S.Replace(";", " , ")
                S = S.Trim
            End If
        Catch ex As Exception
            Console.WriteLine("Notice: 199.1z - " + ex.Message)
        End Try

    End Sub

    Public Function FileOnLocalComputer(ByVal MachineName As String, ByVal FQN As String) As Boolean

        Dim B As Boolean = False
        Dim CurrMachine As String = System.Environment.MachineName
        MachineName = MachineName.ToUpper
        CurrMachine = CurrMachine.ToUpper

        If CurrMachine.Equals(MachineName) Then
            Dim F As File
            If F.Exists(FQN) Then
                B = True
            Else
                B = False
            End If
        Else
            B = False
        End If

    End Function

    Public Function FileOnLocalComputer(ByVal FQN As String) As Boolean

        Dim B As Boolean = False
        Dim F As File
        If F.Exists(FQN) Then
            B = True
        Else
            B = False
        End If

    End Function

    Function isOutLookRunning() As Boolean
        Dim procs() As Process = Process.GetProcessesByName("Outlook")
        If procs.Count > 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Sub KillOutlookRunning()

        For Each RunningProcess In Process.GetProcessesByName("Outlook")
            RunningProcess.Kill()
        Next

    End Sub

    Public Function RemoveCommaNbr(ByVal sNbr As String) As String
        If InStr(sNbr, " ") = 0 And InStr(sNbr, ",") = 0 Then
            Return sNbr
        End If
        Dim NewNbr As String = ""
        Dim CH As String = ""
        Dim I As Integer = 0
        For I = 1 To Len(sNbr)
            CH = Mid(sNbr, I, 1)
            If CH.Equals(" ") Then
            ElseIf CH.Equals(",") Then
            Else
                NewNbr += CH
            End If
        Next
        Return NewNbr
    End Function

    Function ConvertDate(ByVal tDate As Date) As String

        Dim sMonth As String = ""
        Dim sDay As String = ""
        Dim sYear As String = ""
        Dim sHour As String = ""
        Dim sMin As String = ""
        Dim sSecond As String = ""
        Dim sDayOfYear As String = ""
        Dim sTimeOfDay As String = ""
        Dim xDate As String = ""
        Dim LL As Integer = 0

        Try
            sMonth = tDate.Month.ToString : LL = 1
            sDay = tDate.Day.ToString : LL = 2
            sYear = tDate.Year.ToString : LL = 3
            sHour = tDate.Hour.ToString : LL = 4
            sMin = tDate.Minute.ToString : LL = 5
            sSecond = tDate.Second.ToString : LL = 6
            sDayOfYear = tDate.DayOfYear.ToString : LL = 7
            sTimeOfDay = tDate.TimeOfDay.ToString : LL = 8
            If InStr(sTimeOfDay, ".") > 0 Then
                LL = 9
                sTimeOfDay = Mid(sTimeOfDay, 1, InStr(sTimeOfDay, ".") - 1) : LL = 10
            End If
            LL = 11
            xDate = sDay + "/" + sMonth + "/" + sYear + " " + sTimeOfDay : LL = 12
        Catch ex As Exception
            xDate = "01/01/1800 01:01:01"
            LOG.WriteToArchiveLog("ERRROR date: ConvertDate 100: LL= " + LL.ToString + ", error on converting date '" + tDate.ToString + "'." + vbCrLf + ex.Message)
        End Try

        Return xDate

    End Function



    Function VerifyDate(ByVal DTE As String) As String
        Dim tDate As Date = Nothing
        Try
            tDate = CDate(DTE)
            For I As Integer = 1 To DTE.Length
                Dim CH As String = Mid(DTE, I, 1)
                If CH.Equals("/") Then
                    Mid(DTE, I, 1) = "-"
                End If
            Next
        Catch ex As Exception
            Dim A() As String = Nothing
            If InStr(DTE, "-") > 0 Then
                A = DTE.Split("-")
                DTE = A(1) + "-" + A(0) + "-" + A(2)
            End If
            If InStr(DTE, "/") > 0 Then
                A = DTE.Split("/")
                DTE = A(1) + "-" + A(0) + "-" + A(2)
            End If
        End Try
        Return DTE

    End Function

    Function getFileToArchive(ByVal DirToInventory As String, ByVal FileExt As List(Of String), ByVal ckArchiveBit As Boolean, ByVal InclSubDirs As Boolean) As String

        'dir *.txt *.xls *.docx /a:a /s /b
        Dim cPath As String = LOG.getTempEnvironDir()
        Dim TempFolder As String = LOG.getEnvVarSpecialFolderApplicationData()
        Dim tFQN As String = ""
        Dim Ext As String = ""
        Dim DirStmt As String = ""
        DirStmt = "DIR "
        For I As Integer = 0 To FileExt.Count - 1
            Ext = FileExt(I)
            If InStr(Ext, ".") = 0 Then
                Ext = "." + Ext
            End If
            If InStr(Ext, "*") = 0 Then
                Ext = "*" + Ext
            End If
            DirStmt += Ext + " "
        Next
        If ckArchiveBit Then
            DirStmt += " /a:a "
        Else
            DirStmt += " "
        End If

        If InclSubDirs = True Then
            DirStmt += " /s"
        Else
            DirStmt += " "
        End If

        DirStmt += " /b "

        Dim OutputFile As String = ""
        tFQN = TempFolder + "\FilesToArchive.txt"
        DirStmt += " /a:a /s /b " + ">" + tFQN
        Dim BatchFileName As String = TempFolder + "\InventoryFiles.Bat"
        Dim F As File = Nothing
        If F.Exists(BatchFileName) Then
            F.Delete(BatchFileName)
        End If
        F = Nothing

        Using sw As StreamWriter = New StreamWriter(BatchFileName, False)
            sw.WriteLine("CD " + DirToInventory + vbCrLf)
            sw.WriteLine(DirStmt)
            sw.Close()
        End Using

        Dim P As Process
        P = New Process
        Try
            P.StartInfo.FileName = BatchFileName
            P.StartInfo.WindowStyle = ProcessWindowStyle.Normal
            P.Start()
            P.WaitForExit()
            P.Close()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: getFileToArchive 100 - " + ex.Message)
        Finally
            If Not P Is Nothing Then
                P.Dispose()
            End If

        End Try
        Return tFQN
    End Function

    Public Function GetFiles(ByVal Path As String, ByVal FilterList As List(Of String), Recurse As String) As List(Of FileInfo)
        Dim d As New DirectoryInfo(Path)
        Dim files As List(Of FileInfo) = New List(Of FileInfo)
        For Each Filter As String In FilterList
            'the files are appended to the file array
            Application.DoEvents()
            If Recurse.Equals("Y") Then
                files.AddRange(d.GetFiles(Filter, SearchOption.AllDirectories))
            Else
                files.AddRange(d.GetFiles(Filter, SearchOption.TopDirectoryOnly))
            End If

        Next
        Return (files)
    End Function

    Public Function GetFilesRecursive(ByVal initial As String, ByVal FilterList As List(Of String)) As List(Of FileInfo)
        ' This list stores the results.
        Dim result As New List(Of FileInfo)

        ' This stack stores the directories to process.
        Dim stack As New Stack(Of String)

        ' Add the initial directory
        stack.Push(initial)

        ' Continue processing for each stacked directory
        Do While (stack.Count > 0)
            ' Get top directory string
            Application.DoEvents()
            Dim dir As String = stack.Pop
            frmNotify.Label1.Text = dir
            frmNotify.lblFileSpec.Text = "File Cnt: " + stack.Count.ToString
            frmNotify.Refresh()
            Try
                ' Add all immediate file paths
                result.AddRange(GetFiles(dir, FilterList, "N"))

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

    Sub GetFilesToArchive(ByRef iInventoryCnt As Integer,
                            ByVal ckArchiveBit As Boolean,
                            ByVal IncludeSubDir As Boolean,
                            ByVal DirToInventory As String,
                            ByVal FilterList As List(Of String),
                            ByRef FilesToArchive As List(Of String),
                            IncludedTypes As ArrayList,
                            ExcludedTypes As ArrayList)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim WhereIN As String = gWhereInDict(DirToInventory)

        FilesToArchive.Clear()

        Dim TotalFilesInDir As Integer = 0
        Dim EXT As String = ""
        Dim NeedsUpdate As Boolean = False
        Dim FINFO As New Dictionary(Of String, String)
        Dim MSG As String = ""
        Dim ArchiveAttr As Boolean = False
        Dim fi As IO.FileInfo
        Dim FileLength As Int64 = 0
        Dim LastAccessDate As DateTime = Nothing

        Dim File_Name As String = ""
        Dim FQN As String = ""

        'Dim tempDebug As Boolean = False
        'If tempDebug.Equals(True) Then
        '    IncludeSubDir = True
        'End If
        frmNotify.Text = "CONTENT: Inventory"

        Dim Files As List(Of FileInfo) = Nothing
        If IncludeSubDir = True Then
            Files = GetFilesRecursive(DirToInventory, FilterList)
        Else
            Files = GetFiles(DirToInventory, FilterList, "N")
        End If

        Dim LL As Integer = 0

        Dim LastWriteTime As DateTime = Nothing
        Dim GoodFileCNT As Integer = 0
        Dim FOLDER_FQN As String = ""
        Dim iCnt As Integer = 0
        MoreFileToProcess = 0
        TotalFilesInDir = Files.Count
        frmNotify.Text = "CONTENT: Processing Files"
        For Each fi In Files
            Try
                iCnt += 1
                LL = 10
                FOLDER_FQN = fi.DirectoryName
                LL = 11
                File_Name = fi.Name
                LL = 12
                FQN = fi.FullName
                LL = 13
                FileLength = fi.Length
                LL = 20
                LastWriteTime = fi.LastWriteTime
                If gUseLastArchiveDate.Equals("1") Then
                    If LastWriteTime < gLastArchiveDate Then
                        frmNotify.lblFileSpec.Text = "#Files: " + iCnt.ToString
                        frmNotify.Refresh()
                        GoTo SkipIT
                    End If
                End If

                If FileLength >= MaxFileToLoadMB * 1000000 Then
                    LOG.WriteToArchiveLog("NOTICE GetFileToArchive 00: file : <" + FQN + "> EXCEEDS MAX ALLOWED FILE SIZE, SKIPPING: Size = " + FileLength.ToString + " max allowed: " + MaxFileToLoadMB.ToString + "MB.")
                    GoTo SkipIT
                End If
                LL = 30
                If FOLDER_FQN.Trim.Length > 248 Then
                    LOG.WriteToArchiveLog("ERROR GetFileToArchive: folder name too long: " + FOLDER_FQN)
                    FOLDER_FQN = getShortDirName(FOLDER_FQN)
                    LOG.WriteToArchiveLog("NOTICE GetFileToArchive: Shortened name: " + FOLDER_FQN)
                    If FOLDER_FQN.Trim.Length > 248 Then
                        LOG.WriteToArchiveLog("ERROR GetFileToArchive: SHORTENED folder name too long, skipping ENTIRE DIRECTORY")
                        Return
                    End If
                End If
                LL = 40
                If File_Name.Trim.Length > MaxFileNameLength Then
                    LOG.WriteToArchiveLog("ERROR GetFileToArchive: file name too long: " + File_Name + " - SKIPPING FILE.")
                    GoTo SkipIT
                End If
                LL = 50
                FQN = FOLDER_FQN + "\" + File_Name

                Try
                    LL = 60
                    If File.Exists(FQN) Then
                        LL = 70
                        GoodFileCNT += 1
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR GetFileToArchive: could not verify FQN : " + FQN + " - SKIPPING FILE.")
                    LOG.WriteToArchiveLog(ex.Message)
                    GoTo SkipIT
                End Try
                LL = 80
                If iInventoryCnt Mod 2 = 0 Then
                    frmNotify.Label1.Text = Path.GetDirectoryName(FOLDER_FQN)
                    frmNotify.lblFileSpec.Text = "#Files: " + iInventoryCnt.ToString + " of " + Files.Count.ToString
                    frmNotify.Refresh()
                End If
                LL = 90
                EXT = fi.Extension.Trim
                If EXT.Length < 2 Then
                    LOG.WriteToArchiveLog("WARNING: <" + fi.FullName + "> bad or no extension found, skipped.")
                    GoTo SkipIT
                End If
                LL = 100
                EXT = fi.Extension.ToUpper
                LL = 110
                EXT = EXT.Substring(1)
                LL = 120

                iInventoryCnt += 1
                Application.DoEvents()

                LL = 130
                NeedsUpdate = False
                FINFO = dblocal.getFileArchiveInfo(FQN)
                If FINFO.Count.Equals(0) Or FINFO.Count.Equals(1) Then
                    NeedsUpdate = True
                ElseIf fi.LastWriteTime > Convert.ToDateTime(FINFO("LastArchiveDate")) Then
                    NeedsUpdate = True
                ElseIf FileLength <> Convert.ToInt64(FINFO("FileSize")) Then
                    NeedsUpdate = True
                End If
                LL = 140
                If FINFO("AddNewRec").Equals("Y") Then
                    dblocal.AddFileArchiveInfo(FQN)
                End If
                LL = 150
                If IncludedTypes.Count > 0 Then
                    If Not IncludedTypes.Contains(EXT) Then
                        NeedsUpdate = False
                    End If
                End If
                LL = 160
                If ExcludedTypes.Count > 0 Then
                    If ExcludedTypes.Contains(EXT) Then
                        NeedsUpdate = False
                    End If
                End If
                LL = 170
                If NeedsUpdate Then
                    LL = 180
                    If WhereIN.Contains("'" + fi.Extension + "'") Then
                        FilesBackedUp += 1
                        MSG = ArchiveAttr & "|" & File_Name & "|" & fi.Extension & "|" & FOLDER_FQN & "|" & fi.Length & "|" & fi.CreationTime & "|" & fi.LastWriteTime & "|" & fi.LastAccessTime
                        LL = 190
                        FilesToArchive.Add(MSG)
                    End If
                    LL = 200
                Else
                    LL = 210
                    FilesSkipped += 1
                End If
                LL = 220
                If ContentBatchSize > 0 Then
                    LL = 230
                    If iCnt >= ContentBatchSize Then
                        LL = 240
                        LOG.WriteToArchiveLog("NOTICE: Maximumn file limit reached for this directory: " + fi.DirectoryName + ", more to be processed next run.")
                        MoreFileToProcess = 1
                        Exit For
                    End If
                End If
                LL = 240
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: GetFilesToArchive: LL=" + LL.ToString + vbCrLf + ex.Message + vbCrLf + "DIRECTORY:" + FOLDER_FQN + vbCrLf + "File: " + File_Name)
                LL = 250
            End Try
            LL = 260
SkipIT:
        Next
        LL = 270
        LOG.WriteToArchiveLog("GetFilesToArchive: Total Files In Dir: " + FOLDER_FQN + " = " + TotalFilesInDir.ToString)
        LOG.WriteToArchiveLog("GetFilesToArchive: Good Files In Dir: " + FOLDER_FQN + " = " + GoodFileCNT.ToString)
        LL = 280
        If TotalFilesInDir - GoodFileCNT <> 0 Then
            LOG.WriteToArchiveLog("GetFilesToArchive: REJECTED Files In Dir: " + FOLDER_FQN + " = " + (TotalFilesInDir - GoodFileCNT).ToString)
        End If
        LL = 290
        fi = Nothing
        GC.Collect()
        GC.WaitForFullGCApproach()

    End Sub
    Function ckPdfSearchable(ByVal FQN As String) As Boolean

        Dim EntireFile As String
        Dim oFile As System.IO.File
        Dim oRead As System.IO.StreamReader
        FQN = ReplaceSingleQuotes(FQN)
        oRead = oFile.OpenText(FQN)
        EntireFile = oRead.ReadToEnd()
        Dim B As Boolean = False

        If EntireFile.Contains("FontName") Then
            B = True
        End If

        EntireFile = ""
        oRead.Close()
        oRead.Dispose()
        oFile = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    Function isArchiveBitOn(ByVal filespec As String) As Boolean
        Dim B As Boolean = False
        Dim fso, f
        fso = CreateObject("Scripting.FileSystemObject")
        f = fso.GetFile(filespec)
        If f.attributes And 32 Then
            'f.attributes = f.attributes - 32
            'TurnOffArchiveBit = "Archive bit is cleared."
            B = True
        Else
            'f.attributes = f.attributes + 32
            'TurnOffArchiveBit = "Archive bit is set."
            B = False
        End If
        Return B
    End Function

    Public Function BlankOutSingleQuotes(ByVal sText As String) As String
        For i As Integer = 1 To sText.Length
            Dim CH As String = Mid(sText, i, 1)
            If CH.Equals("'") Then
                Mid(sText, i, 1) = " "
            End If
        Next
        Return sText
    End Function

    Sub deleteDirectoryFile(ByVal DirFQN As String)
        Dim FileName As String
        Try
            For Each FileName In System.IO.Directory.GetFiles(DirFQN)
                Try
                    System.IO.File.Delete(FileName)
                Catch ex As System.Exception
                    LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.")
                End Try
            Next FileName
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.")
        End Try

    End Sub

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
            ''MessageBox.Show(fileDetail.Name & " is Archived")
            Return False
        Else
            ''MessageBox.Show(fileDetail.Name & " is NOT Archived")
            Return True
        End If

    End Function

    Function TurnOffArchiveBit(ByVal filespec As String) As Boolean

        Dim B As Boolean = False
        filespec = Me.ReplaceSingleQuotes(filespec)

        Try
            Dim f As New FileInfo(filespec)
            f.Attributes = f.Attributes And Not FileAttributes.Archive
            f = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("Warning: TurnOffArchiveBit 100 - " + ex.Message)
            B = False
        End Try

        Return B
    End Function

    Function getUsedMemory() As Long
        Return ramCounter.NextValue()
    End Function

    Function getImpersonateFileName(ByRef FQN As String) As Boolean

        Dim B As Boolean = True
        Dim tPath As String = LOG.getTempEnvironDir()
        If Mid(tPath, tPath.Length, 1).Equals("\") Then
        Else
            tPath = tPath + "\"
        End If
        tPath = tPath + "EcmDefaultLogin"
        'Dim D As Directory = Nothing
        If Not Directory.Exists(tPath) Then
            Try
                Directory.CreateDirectory(tPath)
            Catch ex As Exception
                MessageBox.Show("Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + vbCrLf + ex.Message)
                Return "Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + vbCrLf + ex.Message
                B = False
            End Try
        End If

        If B Then
            FQN = tPath + "\DefaultLogin.dat"
        Else
            FQN = ""
        End If

        Return B
    End Function

    Function isImpersonationSet(ByRef Login As String) As Boolean
        Login = ""
        Dim ImpersonationSet As Boolean = False
        Dim FQN As String = ""
        Dim B As Boolean = getImpersonateFileName(FQN)
        If B Then
            If File.Exists(FQN) Then
                Dim strContents As String
                Dim objReader As StreamReader
                Try
                    objReader = New StreamReader(FQN)
                    strContents = objReader.ReadToEnd()
                    objReader.Close()
                    Login = strContents
                    ImpersonationSet = True
                Catch Ex As Exception
                    ImpersonationSet = False
                    Login = ""
                    MessageBox.Show("ERROR: Could not process Impersonation - 100x: " + vbCrLf + Ex.Message)
                End Try
            Else
                ImpersonationSet = False
            End If
        Else
            ImpersonationSet = False
        End If
        Return ImpersonationSet
    End Function
    Public Function GetFileContents(ByVal FullPath As String,
       Optional ByRef ErrInfo As String = "") As String

        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FullPath)
            strContents = objReader.ReadToEnd()
            objReader.Close()
        Catch Ex As Exception
            strContents = ""
            ErrInfo = Ex.Message
        End Try
        Return strContents
    End Function

    Public Function GetFileCountDir(ByVal strPath As String) As Integer
        Try
            Return System.IO.Directory.GetFiles(strPath).Length()
        Catch ex As Exception
            Throw New Exception("Error From GetFileCountDir Function" & ex.Message, ex)
        End Try
    End Function

    Public Function GetFileCountSubdir(ByVal strPath As String) As Integer
        Try
            Return System.IO.Directory.GetFiles(strPath, "*.*", IO.SearchOption.AllDirectories).Length
        Catch ex As Exception
            MessageBox.Show("Error From GetFileCountSubdir Function" + vbCrLf + ex.Message)
        End Try
    End Function

    Public Sub cleanTempWorkingDir()

        Dim tPath As String = LOG.getTempEnvironDir
        Dim TransferFileName As String = "*.NotReady"
        Dim I As Integer = 0

        If Directory.Exists(tPath) Then
            For Each _file As String In Directory.GetFiles(tPath, "*.NotReady")
                Try
                    File.Delete(_file)
                    I += 1
                Catch ex As Exception
                    LOG.WriteToErrorLog("NOTICE: failed to remove " + _file + " from temp storage.")
                End Try
            Next
        End If

        LOG.WriteToErrorLog("NOTICE 02: frmReconMain_FormClosing: removed " + I.ToString + " temporary files.")

        Dim FilterList As New List(Of String)
        Dim ZipProcessingDir As String = getTempProcessingDir()
        Dim Files As List(Of FileInfo) = Nothing
        Dim IncludeSubDir As Boolean = False
        Dim FI As FileInfo
        Dim StartTime As DateTime
        Dim ElapsedTime As TimeSpan

        Dim NbrOdDaysToKeep As Integer = 3

        FilterList.Add("*.*")
        Files = GetFilesRecursive(ZipProcessingDir, FilterList)

        For Each FI In Files
            Try
                Dim fqn As String = FI.FullName
                Dim CreateDate As Date = FI.CreationTime
                StartTime = Now
                ElapsedTime = Now().Subtract(CreateDate)
                Dim iDays As Integer = CInt(ElapsedTime.TotalDays)
                If iDays > NbrOdDaysToKeep Then
                    If File.Exists(fqn) Then
                        Try
                            File.Delete(fqn)
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("DELETE FAILURE 02|" + fqn)
                        End Try
                    End If
                End If
            Catch ex As Exception
                Console.WriteLine("Failed to delete AF1:" + FI.Name + ex.Message)
                LOG.WriteToArchiveLog("ERROR Failed to DELETE: " + FI.Name, ex)
            End Try
        Next

        FI = Nothing

        Dim S As String = ISO.readIsoFile(" FilesToDelete.dat")
        Dim sFilesToDelete() As String = S.Split("|")
        For Each S In sFilesToDelete
            Try
                S = S.Trim
                If S.Trim.Length > 0 Then
                    If File.Exists(S) Then
                        File.Delete(S)
                    End If
                End If
            Catch ex As Exception
                LOG.WriteToArchiveLog("NOTICE: Failed to delete temp file '" + S + "'.")
            End Try
        Next

        RemoveEmptyDirectories(ZipProcessingDir)
        ISO.saveIsoFileZeroize(" FilesToDelete.dat", " ")

        GC.Collect()
    End Sub

    '******************************************************************************
    '*Purpose   :                   Removes all empty subdirectories under a directory
    '*Inputs: strPath(string)   :   Path of the folder.
    '* W. Dale Miller
    '******************************************************************************
    Sub RemoveEmptyDirectories(ByVal RootDir As String)

        Dim Root As New DirectoryInfo(RootDir)
        Dim DirsToRemove As New List(Of String)

        Try
            Dim Files As FileInfo() = Root.GetFiles("*.*")
            Dim Dirs As DirectoryInfo() = Root.GetDirectories("*.*")

            Try
                Console.WriteLine("Root Directories")
                Dim DirectoryName As DirectoryInfo
                For Each DirectoryName In Dirs
                    Try
                        Console.Write(DirectoryName.FullName)
                        If DirectoryName.GetFiles.Count = 0 Then
                            DirsToRemove.Add(DirectoryName.FullName)
                        End If
                    Catch E As Exception
                        LOG.WriteToArchiveLog("ERROR: RemoveEmptyDirectories 01 - Failed to SAVE temp directory: " + DirectoryName.FullName + " into delete file.")
                    End Try
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: RemoveEmptyDirectories 02 - " + ex.Message)
            Finally
                For Each S As String In DirsToRemove
                    Try
                        Directory.Delete(S)
                    Catch ex As Exception
                        Console.WriteLine("ERROR: RemoveEmptyDirectories 01 - Failed to DELETE temp directory: " + S + ".")
                    End Try
                Next
            End Try
        Catch ex As Exception
            Console.WriteLine("ERROR: RemoveEmptyDirectories 05 - Failed to DELETE temp directory: " + ex.Message + ".")
        End Try

        DirsToRemove = Nothing
        GC.Collect()
    End Sub
    '******************************************************************************
    '*Purpose   :                   Get File Count in a specified directory
    '*Inputs: strPath(string)   :   Path of the folder.
    '* W. Dale Miller
    '*Returns   :   File Count
    '******************************************************************************
    Public Function GetFileCount(ByVal strPath As String) As Integer
        Try
            Return System.IO.Directory.GetFiles(strPath).Length()
        Catch ex As Exception
            Throw New Exception("Error From GetFileCount Function" & ex.Message, ex)
        End Try
    End Function

    '******************************************************************************
    '*Purpose   :   Convert a bitmap from color to black and white only
    '*Inputs    :   strPath(string)   :   Path of the folder.
    '*By        :   W. Dale Miller
    '*Copyright :   @DMA, Limited, June 2005, all rights reserved.
    '*Returns   :   Bitmap
    '******************************************************************************
    Public Function ConvertGraphicToBlackWhite(ByVal image As System.Drawing.Bitmap, Optional ByVal Mode As BWMode = BWMode.By_Lightness, Optional ByVal tolerance As Single = 0) As System.Drawing.Bitmap
        Dim x As Integer
        Dim y As Integer
        If tolerance > 1 Or tolerance < -1 Then
            Throw New ArgumentOutOfRangeException
            Exit Function
        End If
        For x = 0 To image.Width - 1 Step 1
            For y = 0 To image.Height - 1 Step 1
                Dim clr As Color = image.GetPixel(x, y)
                If Mode = BWMode.By_RGB_Value Then
                    If (CInt(clr.R) + CInt(clr.G) + CInt(clr.B)) > 383 - (tolerance * 383) Then
                        image.SetPixel(x, y, Color.White)
                    Else
                        image.SetPixel(x, y, Color.Black)
                    End If
                Else
                    If clr.GetBrightness > 0.5 - (tolerance / 2) Then
                        image.SetPixel(x, y, Color.White)
                    Else
                        image.SetPixel(x, y, Color.Black)
                    End If
                End If
            Next
        Next
        Return image
    End Function
    Enum BWMode
        By_Lightness
        By_RGB_Value
    End Enum
End Class

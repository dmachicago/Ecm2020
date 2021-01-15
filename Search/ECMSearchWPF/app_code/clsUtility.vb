'Imports Microsoft.VisualBasic
Imports System.Threading
'Imports Microsoft.Win32
Imports System.IO
Imports System.Configuration


Public Class clsUtility

    
    'Dim proxy As New SVCSearch.Service1Client

    Dim LOG As New clsLogMain
    'Dim EP As New clsEndPoint

    Dim SystemSqlTimeout As String = "90"

    Private Declare Function GetTickCount Lib "kernel32.dll" () As Long

    Dim gSecureID As String
    Sub New()
        gSecureID = _SecureID
    End Sub

    Sub RemoveBlanks(ByRef tStr As String)
        Dim S As String = tStr
        Dim NewStr$ = ""
        Dim BlankCnt As Integer = 0
        Dim CH$ = ""
        For i As Integer = 1 To S.Length
            CH = Mid(S, i, 1)
            If CH.Equals(" ") Then
                BlankCnt += 1
            ElseIf CH.Equals(ChrW(9)) Then
                BlankCnt += 1
            ElseIf CH.Equals(ChrW(34)) Then
                BlankCnt += 1
            ElseIf CH.Equals(Environment.NewLine) Then
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

    Public Function ParseLic(ByVal tKey As String) As String
        Dim S As String = ""
        If gLicenseItems.ContainsKey(tKey) Then
            S = gLicenseItems.Item(tKey)
        End If
        Return S
    End Function

    Function spaceCnt(ByVal FQN As String) As Integer

        Dim I As Integer = 0
        Dim iCnt As Integer = 0
        For I = 1 To FQN$.Length
            Dim CH As String = Mid(FQN$, I, 1)
            If CH.Equals(" ") Then
                iCnt += 1
            End If
        Next
        Return iCnt

    End Function
    Public Function GetParentImageProcessingFile() As String

        Dim S As String = ""
        Try
            S = "c:\temp\"
            If spaceCnt(S) > 0 Then
                LOG.WriteToSqlLog("ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\Temp\")
                S = "C:\Temp\"
            End If
        Catch ex As Exception
            S = "C:\Temp\"
        End Try

        Return S

    End Function

    Public Sub getMachineName()
        Dim S As String = ""


        'AddHandler ProxySearch.GetMachineIPCompleted, AddressOf client_GetMachineIPAddr
        'EP.setSearchSvcEndPoint(proxy)
        gMachineID = ProxySearch.GetMachineIP(gSecureID)

    End Sub
    'Sub client_GetMachineIPAddr(ByVal sender As Object, ByVal e As SVCSearch.GetMachineIPCompletedEventArgs)
    '    If RC Then
    '        gMachineID = e.Result
    '    Else
    '        gErrorCount += 1
    '        LOG.WriteToSqlLog("ERROR client_GetMachineIPAddr: Failed to the Machine Name.")
    '    End If
    '    'RemoveHandler ProxySearch.GetMachineIPCompleted, AddressOf client_GetMachineIPAddr
    'End Sub

    Public Function getTempPdfWorkingDir(ByVal RetainFiles As Boolean) As String

        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\OCR\Extract"
        If Not System.IO.Directory.Exists(TempSysDir) Then
            System.IO.Directory.CreateDirectory(TempSysDir)
        End If
        If RetainFiles = False Then
            ZeroizePdaDir()
        End If
        Return TempSysDir$

    End Function

    Public Function getTempPdfWorkingErrorDir() As String
        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\ErrorFile"
        If Not System.IO.Directory.Exists(TempSysDir) Then
            System.IO.Directory.CreateDirectory(TempSysDir)
        End If
        Return TempSysDir$
    End Function

    Private Sub ZeroizePdaDir()

        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\OCR\Extract"
        If Not System.IO.Directory.Exists(TempSysDir) Then
            System.IO.Directory.CreateDirectory(TempSysDir)
        End If

        Dim s As String
        For Each s In System.IO.Directory.EnumerateFiles(TempSysDir)
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

    ''Here is a call that uses the function above to determine if Excel is installed:
    ''MessageBox.Show("Is MS Excel installed? - " & IsApplicationInstalled("Excel.Application").ToString)
    ''RESULT:  Is MS Excell Installed? – True
    'Function IsApplicationInstalled(ByVal pSubKey As String) As Boolean
    '    Dim isInstalled As Boolean = False

    '    ' Declare a variable of type RegistryKey named classesRootRegisteryKey.
    '    ' Assign the Registry's ClassRoot key to the classesRootRegisteryKey 
    '    ' variable.
    '    Dim classesRootRegistryKey As RegistryKey = Registry.ClassesRoot

    '    ' Declare a variable of type RegistryKey named subKeyRegistryKey.
    '    ' Call classesRootRegistryKey's OpenSubKey method passing in the 
    '    ' pSubKey parameter passed into this function. 
    '    ' Assign the result returned to suKeyRegistryKey.
    '    Dim subKeyRegistryKey As RegistryKey = _
    '          classesRootRegistryKey.OpenSubKey(pSubKey)

    '    ' If subKeyRegistryKey was assigned a value...
    '    If Not subKeyRegistryKey Is Nothing Then
    '        ' Key exists; application is installed.
    '        isInstalled = True
    '    End If

    '    ' Close the subKeyRgisteryKey.
    '    subKeyRegistryKey.Close()

    '    Return isInstalled
    'End Function

    'Function isOfficeInstalled() As Boolean
    '    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
    '    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
    '    Dim LOS As New List(Of String)
    '    LOS = getInstalledSoftware()
    '    For Each S As String In LOS
    '        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
    '            Dim A() = S.Split("|")
    '            If A.Length > 1 Then
    '                Dim tVal$ = A(1)
    '                tVal = tVal.Trim
    '                If tVal.Equals("12") Or tVal.Equals("11") Then
    '                    Return True
    '                End If
    '            End If
    '        End If
    '    Next
    '    Return False
    'End Function

    'Function isOffice2003Installed() As Boolean
    '    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
    '    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
    '    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
    '    Dim LOS As New List(Of String)
    '    LOS = getInstalledSoftware()
    '    For Each S As String In LOS
    '        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
    '            Dim A() = S.Split("|")
    '            If A.Length > 1 Then
    '                Dim tVal$ = A(1)
    '                tVal = tVal.Trim
    '                If tVal.Equals("11") Then
    '                    Return True
    '                End If
    '            End If
    '        End If
    '    Next
    '    Return False
    'End Function

    'Function isOffice2007Installed() As Boolean
    '    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
    '    Dim LOS As New List(Of String)
    '    LOS = getInstalledSoftware()
    '    For Each S As String In LOS
    '        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
    '            Dim A() = S.Split("|")
    '            If A.Length > 1 Then
    '                Dim tVal$ = A(1)
    '                tVal = tVal.Trim
    '                If tVal.Equals("12") Then
    '                    Return True
    '                End If
    '            End If
    '        End If
    '        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
    '            Dim A() = S.Split("|")
    '            If A.Length > 1 Then
    '                Dim tVal$ = A(1)
    '                tVal = tVal.Trim
    '                If tVal.Equals("14") Then
    '                    Return True
    '                End If
    '            End If
    '        End If
    '    Next
    '    Return False
    'End Function

    'Function isOutlookInstalled() As Boolean
    '    'Update for Microsoft Office Outlook 2007 Help (KB963677)
    '    Return False
    'End Function
    'Function isOutlook2003Installed() As Boolean
    '    'Update for Microsoft Office Outlook 2007 Help (KB963677)
    '    Return False
    'End Function
    'Function isOutlook2007Installed() As Boolean
    '    'Update for Microsoft Office Outlook 2007 Help (KB963677)
    '    Return False
    'End Function

    'Function getInstalledSoftware() As List(Of String)
    '    Dim strList As New List(Of String)

    '    Dim UninstallKey As String = ""
    '    UninstallKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    '    Dim RK As RegistryKey = Registry.LocalMachine.OpenSubKey(UninstallKey)
    '    For Each skName As String In RK.GetSubKeyNames
    '        Using sk As RegistryKey = RK.OpenSubKey(skName)
    '            'Console.WriteLine(sk.Name)
    '            'Console.WriteLine(sk.GetSubKeyNames)
    '            'Console.WriteLine(sk.GetSubKeyNames)
    '            Dim PackageName$ = ""
    '            Try
    '                PackageName$ = sk.GetValue("DisplayName")
    '                If PackageName$.Trim.Length > 0 Then
    '                    Try
    '                        Dim VersionMajor$ = sk.GetValue("VersionMajor")
    '                        Dim VersionMinor$ = sk.GetValue("VersionMinor")
    '                        Dim WindowsInstaller$ = sk.GetValue("WindowsInstaller")
    '                        If VersionMajor$.Trim.Length > 0 Then
    '                            PackageName$ = PackageName$ + " | " + VersionMajor$
    '                        End If
    '                        If VersionMinor$.Trim.Length > 0 Then
    '                            PackageName$ = PackageName$ + " | " + VersionMinor$
    '                        End If
    '                        If WindowsInstaller$.Trim.Length > 0 Then
    '                            PackageName$ = PackageName$ + " | " + WindowsInstaller$
    '                        End If
    '                    Catch ex As Exception

    '                    End Try
    '                    strList.Add(PackageName as string)
    '                End If
    '            Catch ex As Exception

    '            End Try
    '        End Using
    '    Next
    '    strList.Sort()
    '    Return strList
    'End Function

    Public Function RemoveSingleQuotes(ByVal tVal As String) As String

        Dim S As String = tVal

        S = S.Replace("'", "''")
        tVal = S

        Return tVal
    End Function
    Public Function RemoveMultiSingleQuotes(ByVal tVal As String) As String

        Dim S As String = tVal

        S = S.Replace("''", "'")
        tVal = S

        Return tVal
    End Function


    Public Function RemoveBadChars(ByVal tVal As String) As String

        Dim SS As String = tVal

        Try
            Dim i As Integer = Len(tVal)
            Dim ch As String = ""
            Dim S As String = "0123456789 abcdefghijklmnopqrstuvwxyz."
            For i = 1 To Len(tVal)
                ch = tVal.Substring(i, 1)
                If Not SS.Contains(ch) Then
                    SS.Replace(ch, " ")
                End If
            Next
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: clsUtility:RemoveBadChars - " + ex.Message + Environment.NewLine + ex.StackTrace)
        End Try

        Return tVal.Trim
    End Function
    Public Function RemoveSingleQuotesV1(ByVal tVal as string) As String
        Dim S As String = tVal


        If InStr(tVal$, "''") > 0 Then
            Return (tVal)
        End If
        If InStr(tVal$, "'") = 0 Then
            Return (tVal)
        End If

        S.Replace("'", "`")
        tVal = S

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
        Dim A() As String
        Dim NewStr$ = ""
        If isWeightedSearch = True Then
            If InStr(1, tVal, "`") > 0 Then
                tVal = Me.ReplaceSingleQuotes(tVal)
            End If
            If InStr(1, tVal, "''") > 0 Then
                NewStr = tVal$
            ElseIf InStr(1, tVal, "'") > 0 Then
                A$ = tVal.Split("'")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
                NewStr = Mid(NewStr, 1, NewStr.Length - 2)
            ElseIf InStr(1, tVal, "`") > 0 Then
                A$ = tVal.Split("`")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
                NewStr = Mid(NewStr, 1, NewStr.Length - 2)
            Else
                NewStr = tVal$
            End If
            NewStr = NewStr.Trim
        ElseIf isWeightedSearch = True Then
            If InStr(1, tVal, "`") > 0 Then
                A$ = tVal.Split("`")
                For i As Integer = 0 To UBound(A)
                    NewStr = NewStr + A(i).Trim + "''"
                Next
            Else
                NewStr = tVal$
            End If
            NewStr = NewStr.Trim
        Else
            If InStr(1, tVal, "''") > 0 Then
                NewStr = tVal$
            Else
                NewStr = RemoveSingleQuotes(tVal)
            End If
        End If
        Return NewStr
    End Function

    Public Function RemoveUnwantedCharacters(ByVal tVal As String) As String
        tVal = tVal.Trim
        Dim SS As String = tVal
        Try
            SS = SS.Replace("(", " ")
            SS = SS.Replace(")", " ")
            SS = SS.Replace("[", " ")
            SS = SS.Replace("]", " ")
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: clsUtility:RemoveUnwantedCharacters - " + ex.Message + Environment.NewLine + ex.StackTrace)
        End Try

        Return SS
    End Function

    Public Function RemoveCrLF(ByVal tVal As String) As String
        Dim SS As String = tVal
        Try
            SS = SS.Replace(Environment.NewLine, " ")
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: clsUtility:RemoveCrLF - " + ex.Message + Environment.NewLine + ex.StackTrace)
        End Try
        Return SS
    End Function

    Public Function fixSingleQuotes(ByVal tVal as string) As String
        Dim tempStr$ = ""
        Dim bLastCharIsQuote As Boolean = False

        tVal = tVal.Trim
        If tVal.Length = 0 Then
            Return tVal
        End If
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

    Public Function ReplaceSingleQuotes(ByVal tStr as string) As String

        Dim TgtStr$ = "''"
        Dim S1$ = ""
        Dim S2$ = ""
        Dim L As Integer = Len(TgtStr)
        Dim I As Integer = 0

        Do While InStr(tStr, TgtStr, CompareMethod.Text) > 0
            I = InStr(tStr, TgtStr, CompareMethod.Text)
            S1 = Mid(tStr, 1, I - 1)
            S2 = Mid(tStr, I + L)
            tStr = S1 + "'" + S2
        Loop

        Return tStr$
    End Function

    Public Function ReplaceSingleQuotesV1(ByVal tVal As String) As String
        Dim S As String = tVal
        S.Replace("'", "`")
        Return S
    End Function

    Public Function RemoveCommas(ByVal tVal As String) As String
        Dim S As String = tVal
        S.Replace(",", "^")
        Return S
    End Function

    Public Function RemoveOcrProblemChars(ByVal tVal As String) As String
        Dim S As String = tVal
        S.Replace(",", "z")
        S.Replace("$", "z")
        S.Replace("#", "z")
        S.Replace("@", "z")
        Return S
    End Function
    Sub RemoveDoubleSlashes(ByRef FQN As String)
        Dim S As String = FQN
        S.Replace("//", "")
        FQN = S
    End Sub

    Sub setConnectionStringTimeout(ByRef ConnStr as string, byval TimeOutSecs As String)

        Dim I As Integer = 0
        Dim S as string = ""
        Dim NewConnStr$ = ""
        S = ConnStr
        I = InStr(1, S, "Connect Timeout =", CompareMethod.Text)
        If I > 0 Then
            Dim SqlTimeout$ = TimeOutSecs
            If SqlTimeout$.Trim.Length = 0 Then
                Return
            Else
                I = I + "Connect Timeout =".Length
                NewConnStr$ = setNewTimeout(ConnStr$, I, TimeOutSecs)
            End If
        Else
            NewConnStr = S
            NewConnStr$ += "; Connect Timeout = " + TimeOutSecs + ";"
        End If

        GC.Collect()
        ConnStr = NewConnStr$
    End Sub
    Function setNewTimeout(ByVal tgtStr as string, byval StartingPoint As Integer, ByVal NewVal As String) As String
        Dim NextNumber$ = ""
        Dim NumberStartPos As Integer = 0
        Dim NumberEndPos As Integer = 0
        Dim NewStr$ = ""
        Dim S1$ = ""
        Dim S2$ = ""
        Try
            Dim I As Integer = 0
            Dim CH$ = Mid(tgtStr, StartingPoint, 1)
            Dim bFound As Boolean = False
            Do Until InStr("0123456789", CH) > 0 Or StartingPoint > tgtStr$.Length
                StartingPoint += 1
                CH$ = Mid(tgtStr, StartingPoint, 1)
                bFound = True
            Loop
            If Not bFound Then
                Return tgtStr$
            Else
                NumberStartPos = StartingPoint
                NumberEndPos = StartingPoint
                Do Until InStr("0123456789", CH) = 0 Or NumberEndPos >= tgtStr$.Length
                    NumberEndPos += 1
                    CH$ = Mid(tgtStr, NumberEndPos, 1)
                Loop
            End If
            Dim CurrVal$ = Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1)
            S1$ = Mid(tgtStr, 1, NumberStartPos - 1)
            S2$ = Mid(tgtStr, NumberEndPos + 1)
            NewStr$ = S1 + " " + NewVal + " " + S2
        Catch ex As Exception
            log.WriteToSqlLog("FindNextNumberInStr: " + ex.Message)
            NewStr$ = tgtStr$
        End Try
        Return NewStr$
    End Function
    Function setNewTimeout(ByVal tgtStr as string, byval StartingPoint As Integer) As String
        Dim NextNumber$ = ""
        Dim NumberStartPos As Integer = 0
        Dim NumberEndPos As Integer = 0
        Dim NewStr$ = ""
        Dim S1$ = ""
        Dim S2$ = ""
        Try
            Dim I As Integer = 0
            Dim CH$ = Mid(tgtStr, StartingPoint, 1)
            Dim bFound As Boolean = False
            Do Until InStr("0123456789", CH) > 0 Or StartingPoint > tgtStr$.Length
                StartingPoint += 1
                CH$ = Mid(tgtStr, StartingPoint, 1)
                bFound = True
            Loop
            If Not bFound Then
                Return tgtStr$
            Else
                NumberStartPos = StartingPoint
                NumberEndPos = StartingPoint
                Do Until InStr("0123456789", CH) = 0 Or NumberEndPos >= tgtStr$.Length
                    NumberEndPos += 1
                    CH$ = Mid(tgtStr, NumberEndPos, 1)
                Loop
            End If
            Dim CurrVal$ = Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1)
            S1$ = Mid(tgtStr, 1, NumberStartPos - 1)
            S2$ = Mid(tgtStr, NumberEndPos + 1)
            NewStr$ = S1 + " " + SystemSqlTimeout$ + " " + S2
        Catch ex As Exception
            log.WriteToSqlLog("FindNextNumberInStr: " + ex.Message)
            NewStr$ = tgtStr$
        End Try
        Return NewStr$
    End Function

    Public Function getFileSuffix(ByVal FQN as string) As String
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
    Public Function substConnectionStringServer(ByVal ConnStr as string, byval Server as string) As String
        'Data Source=XXX;Initial Catalog=ECM.Thesaurus;Integrated Security=True; Connect Timeout = 30

        Dim I As Integer = 0
        Dim Str1$ = ""
        Dim Str2$ = ""
        Dim NewStr$ = ""

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
    Public Function getLicenseFromFile(ByVal CustomerID as string, byval ServerName as string, byval LicenseDirectory as string) As String
        Dim B As Boolean = True
        Dim bApplied As Boolean = False
        If CustomerID$.Length = 0 Then
            MessageBox.Show("Customer ID required: " + Environment.NewLine + "If you do not know your Customer ID, " + Environment.NewLine + "please contact ECM Support or your ECM administrator.")
            Return ""
        End If

        Try
            Dim SelectedServer$ = ServerName$
            If SelectedServer$.Length = 0 Then
                MessageBox.Show("Please select the Server to which this license applies." + Environment.NewLine + "The server name and must match that contained within the license.")
                Return False
            End If
            Dim FQN$ = LicenseDirectory$ + "\" + "EcmLicense." + ServerName + ".txt"
            Dim S As String = LoadLicenseFile(FQN)
            If S.Length = 0 Then
                Return ""
            Else
                '** Put the license into the DB
                Return S
            End If
        Catch ex As Exception
            Return ""
        End Try
    End Function
    Public Function LoadLicenseFile(ByVal FQN as string) As String
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            MessageBox.Show("Failed to load License file: " + Environment.NewLine + Ex.Message)
            'LogThis("clsDatabase : LoadLicenseFile : 5914 : " + Ex.Message)
            Return ""
        End Try
        Return strContents
    End Function
    Function ArchiveBitSet(ByVal FQN as string) As Boolean

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttributes
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttributes.Archive) = FileAttributes.Archive)
        Dim bArchive As Boolean = FileAttributes.Archive
        Return isArchive

    End Function
    Sub setArchiveBitToNoArchNeeded(ByVal FQN as string)

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttributes
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttributes.Archive) = FileAttributes.Archive)
        Dim bArchive As Boolean = FileAttributes.Archive

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
        '    MessageBox.Show("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
        'End Try

    End Sub
    Sub setArchiveBitFasle(ByVal FQN as string)

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttributes
        FI.Attributes = FileAttributes.Archive
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) & FileAttributes.Archive) = FileAttributes.Archive)
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
        Dim S1$ = ""
        Dim II As Integer = InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text)
        If II > 0 Then
            II = InStr(II + 5, InsertConnStr, "=")
            If II > 0 Then
                Dim K As Integer = InStr(II + 1, InsertConnStr, ";")
                If K > 0 Then
                    Dim S2$ = ""
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
        Dim S1$ = ""
        Dim II As Integer = InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text)
        If II > 0 Then
            II = InStr(II + 5, InsertConnStr, "=")
            If II > 0 Then
                Dim K As Integer = InStr(II + 1, InsertConnStr, ";")
                If K > 0 Then
                    Dim S2$ = ""
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

    Function HashCalc(ByVal S as string) As Double

        Dim AR$()

        Dim I As Integer = 0
        Dim a As Double = 1
        For I = 1 To Len(S)
            a = AscW(Mid(S, I, 1)) * 1000 + AscW(Mid(S, I, 1)) + I
            a = System.Math.Sqrt(a * I * AscW(Mid(S, I, 1))) 'Numeric Hash
        Next I

        AR = S.Split(".")
        For I = 0 To UBound(AR)
            If isNumericDma(AR(I)) Then
                a = a + Val(AR(I))
            End If
        Next

        a = Math.Round(a, 4)
        Return a

    End Function

    Function HashName(ByVal sName as string) As Double
        Dim dHash As Double = 0
        dHash = HashCalc(sName)
        Return dHash
    End Function

    Function HashFqn(ByVal FQN as string) As String

        Dim dHash As Double = 0
        dHash = HashCalc(FQN)

        Dim I As Integer = FQN$.Length
        Dim sHash As String = FQN$.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashDirName(ByVal DirName as string) As String

        Dim dHash As Double = 0
        dHash = HashCalc(DirName)

        Dim I As Integer = DirName.Length
        Dim sHash As String = DirName.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashFileName(ByVal FileName as string) As String

        Dim dHash As Double = 0
        dHash = HashCalc(FileName)

        Dim I As Integer = FileName$.Length
        Dim sHash As String = FileName$.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashDirFileName(ByVal DirName As String, ByVal FileName As String) As String

        Dim sHash As String = HashDirName(DirName) + ":" + HashFileName(FileName)
        Return sHash

    End Function


    'Sub SaveNewUserSettings()
    '    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100")
    '    'Dim ECMDB$ = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
    '    'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB  )
    '    Dim ECMDB$ = My.Settings("UserDefaultConnString")
    '    'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB  )

    '    My.Settings("UpgradeSettings") = False
    '    My.Settings("DB_EcmLibrary") = My.Settings("UserDefaultConnString")
    '    My.Settings("DB_Thesaurus") = My.Settings("UserThesaurusConnString")
    '    'My.Settings("UserDefaultConnString") = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
    '    ' My.Settings("UserThesaurusConnString") = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString")
    '    My.Settings.Save()

    '    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 400 " + My.Settings("DB_EcmLibrary"))
    '    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 500 " + My.Settings("DB_Thesaurus"))
    '    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 600 " + My.Settings("UserDefaultConnString"))
    '    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 700 " + My.Settings("UserThesaurusConnString"))

    'End Sub

    'Function EnumerateDiskDrives(ByRef Drives As SortedList(Of String, String)) As Boolean

    '    ' Dim fso As New Scripting.FileSystemObject()
    '    Dim objDrive
    '    Dim objFSO As Object

    '    objFSO = CreateObject("Scripting.FileSystemObject")
    '    Dim colDrives = objFSO.Drives

    '    For Each objDrive In colDrives
    '        Dim DriveType$ = ""
    '        Dim DriveLetter$ = objDrive.DriveLetter
    '        Dim NumData As Integer = objDrive.drivetype
    '        Select Case NumData
    '            Case 1
    '                DriveType$ = "Removable"
    '            Case 2
    '                DriveType$ = "Fixed"
    '            Case 3
    '                DriveType$ = "Network"
    '            Case 4
    '                DriveType$ = "CD-ROM"
    '            Case 5
    '                DriveType$ = "RAM Disk"
    '            Case Else
    '                DriveType$ = "Unknown"
    '        End Select
    '        If Drives.IndexOfKey(DriveLetter) >= 0 Then
    '        Else
    '            Drives.Add(DriveLetter, DriveType)
    '        End If
    '    Next

    'End Function

    'Sub xSaveCurrentConnectionInfo()

    '    Dim ENC As New clsEncrypt

    '    Dim TempDir$ = Environment.GetEnvironmentVariable("temp")
    '    Dim EcmConStr$ = "ECM" + Chr(254)
    '    Dim ThesaurusStr$ = "THE" + Chr(254)
    '    Dim FileName$ = "EcmLoginInfo.DAT"
    '    Dim FQN$ = TempDir + "\" + FileName


    '    Dim oFile As System.IO.File
    '    Dim oWrite As System.IO.StreamWriter

    '    Try
    '        EcmConStr$ += My.Settings("UserDefaultConnString")
    '        ThesaurusStr$ += My.Settings("UserThesaurusConnString")

    '        oWrite = oFile.CreateText(FQN  )

    '        EcmConStr = ENC.AES256EncryptString(EcmConStr)
    '        ThesaurusStr$ = ENC.AES256EncryptString(ThesaurusStr  )
    '        oWrite.WriteLine(EcmConStr)
    '        oWrite.WriteLine(ThesaurusStr)
    '    Catch ex As Exception
    '        WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message)
    '        WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace)
    '    Finally
    '        oWrite.Close()
    '        oWrite = Nothing
    '        oFile = Nothing
    '    End Try

    'End Sub
    'Sub xgetCurrentConnectionInfo()

    '    Try
    '        WriteToInstallLog("Track 1")
    '        Dim ENC As New clsEncrypt

    '        Dim TempDir$ = Environment.GetEnvironmentVariable("temp")
    '        Dim EcmConStr$ = "ECM" + Chr(254)
    '        Dim ThesaurusStr$ = "THE" + Chr(254)
    '        Dim FileName$ = "EcmLoginInfo.DAT"
    '        Dim FQN$ = TempDir + "\" + FileName
    '        Dim LineIn$ = ""
    '        Dim oFile As System.IO.File
    '        Dim oRead As System.IO.StreamReader
    '        WriteToInstallLog("Track 2")
    '        Dim F As File
    '        If Not F.Exists(FQN  ) Then
    '            oRead.Close()
    '            oRead = Nothing
    '            oFile = Nothing
    '            Return
    '        End If
    '        WriteToInstallLog("Track 3")
    '        Try
    '            oRead = oFile.OpenText(FQN)
    '            Dim NeedsSaving As Boolean = False
    '            While oRead.Peek <> -1
    '                LineIn = oRead.ReadLine()
    '                LineIn = ENC.AES256DecryptString(LineIn)

    '                Dim A$() = LineIn.Split("?")
    '                Dim tCode$ = A(0)
    '                Dim cs$ = A(1)

    '                If tCode.Equals("ECM") Then
    '                    My.Settings("DB_EcmLibrary") = cs$
    '                    My.Settings("UserDefaultConnString") = cs$
    '                    NeedsSaving = True
    '                End If
    '                If tCode.Equals("THE") Then
    '                    My.Settings("DB_Thesaurus") = cs$
    '                    My.Settings("UserThesaurusConnString") = cs$
    '                    NeedsSaving = True
    '                End If

    '            End While
    '            If NeedsSaving = True Then
    '                My.Settings.Save()
    '            End If
    '        Catch ex As Exception
    '            WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.Message)
    '            WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.StackTrace)
    '        Finally
    '            oRead.Close()
    '            oFile = Nothing
    '            ENC = Nothing
    '        End Try
    '    Catch ex As Exception
    '        WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message)
    '        WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace)
    '    End Try

    'End Sub

    Function genEmailIdentifier(ByVal MessageSize As String, ByVal ReceivedTime As String, ByVal SenderEmailAddress As String, ByVal Subject As String, ByVal CurrentUserID As String) As String
        Dim EmailIdentifier As String = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Mid(Subject, 1, 80) + "~" + CurrentUserID

        EmailIdentifier = RemoveSingleQuotes(EmailIdentifier)
        Return EmailIdentifier
    End Function

    Sub ckSqlQryForDoubleKeyWords(ByRef MyQry As String)

        MyQry = RemoveCrLF(MyQry)

        Dim A$() = Split(MyQry, " ")

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
                    MyQry = Environment.NewLine + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("WHERE") Then
                    MyQry = Environment.NewLine + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("AND") Then
                    MyQry = Environment.NewLine + vbTab + MyQry
                End If
                If Token.ToUpper.Equals("OR") Then
                    MyQry = Environment.NewLine + vbTab + MyQry
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
        Dim A() As String = tSql.Split(Environment.NewLine)
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

        ModifiedList.Add("UNION ALL" + Environment.NewLine)

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
                Else
                    If tStr.Length > 5 Then
                        If Mid(tStr.ToUpper, 1, 5).Equals("FROM ") Then
                            Dim X As Integer = InStr(tStr, " FROM ", CompareMethod.Text)
                            Console.WriteLine(NewList(J))
                            Dim S1 As String = Mid(tStr, 1, 5)
                            Dim S2 As String = Mid(tStr, 6)
                            tStr = S1 + SvrAlias + ".[ECM.Library].dbo." + S2
                            Console.WriteLine(tStr)
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

        ModifiedList.Add(OrderByClause + Environment.NewLine)

        tempSql = ""

        For I As Integer = 0 To ModifiedList.Count - 1
            tempSql += ModifiedList(I) + Environment.NewLine
            Console.WriteLine(ModifiedList(I))
        Next

        tSql = tempSql

    End Sub

    Sub StripSingleQuotes(ByRef S As String)

        If S Is Nothing Then
            S = " "
            Return
        End If

        S = S.Replace("'", " ")

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

    Public Function FileOnLocalComputer(ByVal FQN As String) As Boolean

        Dim B As Boolean = False
        If File.Exists(FQN) Then
            B = True
        Else
            B = False
        End If
        Return B
    End Function

    'Function isOutLookRunning() As Boolean
    '    Dim procs() As Process = Process.GetProcessesByName("Outlook")
    '    If procs.Count > 0 Then
    '        Return True
    '    Else
    '        Return False
    '    End If
    'End Function

    'Sub KillOutlookRunning()

    '    For Each RunningProcess In Process.GetProcessesByName("Outlook")
    '        RunningProcess.Kill()
    '    Next

    'End Sub

    Public Function RemoveCommaNbr(ByVal sNbr As String) As String
        If InStr(sNbr, "$") = 0 And InStr(sNbr, ",") = 0 Then
            Return sNbr
        End If
        Dim NewNbr As String = ""
        Dim CH As String = ""
        Dim I As Integer = 0
        For I = 1 To Len(sNbr)
            CH = Mid(sNbr, I, 1)
            If CH.Equals("$") Then
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
            log.WriteToSqlLog("ERRROR date: ConvertDate 100: LL= " + LL.ToString + ", error on converting date '" + tDate.ToString + "'." + Environment.NewLine + ex.Message)
        End Try

        Return xDate

    End Function

    Function ckPdfSearchable(ByVal FQN As String) As Boolean

        Dim EntireFile As String
        Dim oRead As System.IO.StreamReader
        FQN = ReplaceSingleQuotes(FQN)
        oRead = File.OpenText(FQN)
        EntireFile = oRead.ReadToEnd()
        Dim B As Boolean = False

        If EntireFile.Contains("FontName") Then
            B = True
        End If

        EntireFile = ""
        oRead.Close()
        oRead.Dispose()

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    Sub RemoveFreetextStopWords(ByRef SearchPhrase As String)

        SearchPhrase = SearchPhrase.Trim
        If SearchPhrase.Trim.Length = 0 Then
            Return
        End If

        Dim AL As New List(Of String)
        '** The below needs to be added back as a SERVICE call to ClsDatabase if this function is used 3/22/2011 WDM
        'GetSkipWords(AL)

        For i As Integer = 1 To SearchPhrase.Length
            Dim CH$ = Mid(SearchPhrase, i, 1)
            If CH$ = ChrW(34) Then
                'Mid(SearchPhrase, i, 1) = " "
                MidX(SearchPhrase, i, " ")
            End If
        Next
        Dim NewPhrase As String = ""
        Dim A() As String = SearchPhrase.Split(" ")
        For i As Integer = 0 To UBound(A)
            Dim tWord$ = A(i).Trim
            Dim TempWord$ = tWord
            tWord = tWord.ToUpper
            If tWord.Length > 0 Then
                If AL.Contains(tWord) Then
                    A(i) = ""
                Else
                    A(i) = TempWord
                End If
            End If
        Next

        For i As Integer = 0 To UBound(A)
            If A(i).Trim.Length > 0 Then
                NewPhrase = NewPhrase + " " + A(i)
            End If
        Next
        SearchPhrase = NewPhrase$
    End Sub

    Public Sub SetVersionAndServer()
        Try
            Dim ASSM As Reflection.Assembly = Reflection.Assembly.GetExecutingAssembly()
            Dim FullName As String = ASSM.FullName
            'Dim fullversion As String = ASSM.version
            'Dim S as string = " APP:" & Application.Info.Version.Major & "." & Application.Info.Version.Minor & "." & Application.Info.Version.Build & "." & Application.Info.Version.Revision & " "
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            log.WriteToSqlLog("Notice 001.z1 : SetVersionAndServer - " + ex.Message)
        End Try

    End Sub

  

End Class

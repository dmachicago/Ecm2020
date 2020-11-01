Imports Microsoft.VisualBasic
Imports System.Threading
Imports Microsoft.Win32
Imports System.IO
Imports System.Configuration
Imports System.Web
Imports System.Web.HttpRequest
Imports ECMEncryption

Public Class clsUtilitySVR

    Dim ENC As New ECMEncrypt
    Dim SystemSqlTimeout As String = "90"
    'Dim ENC As New ECMEncrypt
    Dim TempDir As String = System.Configuration.ConfigurationManager.AppSettings("WorkingDir")
    Dim xx As Int16 = 0

    Private Declare Function GetTickCount Lib "kernel32.dll" () As Long

    Sub RemoveBlanks(ByRef tStr as string)
        Dim S$ = tStr
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
            S = System.Configuration.ConfigurationManager.AppSettings("PdfProcessingDir")
            If spaceCnt(S) > 0 Then
                Dim LOG As New clsLogging
                LOG.WriteToSqlLog("ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\Temp\")
                LOG = Nothing
                GC.Collect()
                GC.WaitForPendingFinalizers()
                S = "C:\Temp\"
            End If
        Catch ex As Exception
            S = "C:\Temp\"
        End Try

        Return S

    End Function

    Public Function getTempPdfWorkingDir(ByVal RetainFiles As Boolean) As String

        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\OCR\Extract"

        If Not Directory.Exists(TempSysDir) Then
            Directory.CreateDirectory(TempSysDir)
        End If

        If RetainFiles = False Then
            ZeroizePdaDir()
        End If

        Return TempSysDir$

    End Function

    Public Function getTempPdfWorkingErrorDir() As String
        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\ErrorFile"

        If Not Directory.Exists(TempSysDir) Then
            Directory.CreateDirectory(TempSysDir)
        End If

        Return TempSysDir$
    End Function

    Private Sub ZeroizePdaDir()

        Dim TempSysDir$ = GetParentImageProcessingFile() + "ECM\OCR\Extract"
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
        ' Call classesRootRegistryKey's OpenSubKey AS string passing in the 
        ' pSubKey parameter passed into this function. 
        ' Assign the result returned to suKeyRegistryKey.
        Dim subKeyRegistryKey As RegistryKey = _
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
                    Dim tVal$ = A(1)
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
                    Dim tVal$ = A(1)
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
                    Dim tVal$ = A(1)
                    tVal = tVal.Trim
                    If tVal.Equals("12") Then
                        Return True
                    End If
                End If
            End If
            If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
                Dim A() = S.Split("|")
                If A.Length > 1 Then
                    Dim tVal$ = A(1)
                    tVal = tVal.Trim
                    If tVal.Equals("14") Then
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
        Dim strList As New List(Of String)

        Dim UninstallKey As String = ""
        UninstallKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
        Dim RK As RegistryKey = Registry.LocalMachine.OpenSubKey(UninstallKey)
        For Each skName As String In RK.GetSubKeyNames
            Using sk As RegistryKey = RK.OpenSubKey(skName)
                'Console.WriteLine(sk.Name)
                'Console.WriteLine(sk.GetSubKeyNames)
                'Console.WriteLine(sk.GetSubKeyNames)
                Dim PackageName As String = ""
                Try
                    PackageName$ = sk.GetValue("DisplayName")
                    If PackageName$.Trim.Length > 0 Then
                        Try
                            Dim VersionMajor$ = sk.GetValue("VersionMajor")
                            Dim VersionMinor$ = sk.GetValue("VersionMinor")
                            Dim WindowsInstaller$ = sk.GetValue("WindowsInstaller")
                            If VersionMajor$.Trim.Length > 0 Then
                                PackageName$ = PackageName$ + " | " + VersionMajor$
                            End If
                            If VersionMinor$.Trim.Length > 0 Then
                                PackageName$ = PackageName$ + " | " + VersionMinor$
                            End If
                            If WindowsInstaller$.Trim.Length > 0 Then
                                PackageName$ = PackageName$ + " | " + WindowsInstaller$
                            End If
                        Catch ex As Exception

                        End Try
                        strList.Add(PackageName)
                    End If
                Catch ex As Exception

                End Try
            End Using
        Next
        strList.Sort()
        Return strList
    End Function

    Public Function RemoveSingleQuotes(ByVal tVal As String) As String

        Dim S As String = tVal
        If InStr(tVal, "''") > 0 Then
            Return (tVal)
        End If
        If InStr(tVal, "'") = 0 Then
            Return (tVal)
        End If

        S = S.Replace("'", "''")

        Return S
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
            Dim LOG As New clsLogging
            LOG.WriteToSqlLog("ERROR: clsUtility:RemoveBadChars - " + ex.Message + vbCrLf + ex.StackTrace)
            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return tVal.Trim
    End Function
    Public Function RemoveSingleQuotesV1(ByVal tVal As String) As String
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
        Dim A$()
        Dim NewStr As String = ""
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
        Dim UCH$ = "()[]"
        Dim CH$
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
        Dim CH$
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

    Public Function ReplaceSingleQuotes(ByVal tStr As String) As String

        Dim TgtStr$ = "''"
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

        Return tStr$
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
            ElseIf ch = "$" Then
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
        Dim s$ = FQN
        Do While InStr(1, s, "//") > 0
            i = InStr(1, s, "//")
            s1 = Mid(s, 1, i + 1)
            S2 = Mid(s, 1, i + 2)
            s = s1 + S2
        Loop
        FQN = s
    End Sub

    Sub setConnectionStringTimeout(ByRef ConnStr As String, ByVal TimeOutSecs As String)

        Dim I As Integer = 0
        Dim S As String = ""
        Dim NewConnStr As String = ""
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
        GC.WaitForFullGCApproach()
        ConnStr = NewConnStr$
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
            Dim LOG As New clsLogging
            LOG.WriteToSqlLog("FindNextNumberInStr: " + ex.Message)
            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
            NewStr$ = tgtStr$
        End Try
        Return NewStr$
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
            Dim LOG As New clsLogging
            LOG.WriteToSqlLog("FindNextNumberInStr: " + ex.Message)
            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
            NewStr$ = tgtStr$
        End Try
        Return NewStr$
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
            MsgBox("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return ""
        End If

        Try
            Dim SelectedServer$ = ServerName$
            If SelectedServer$.Length = 0 Then
                MsgBox("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
                Return False
            End If
            Dim FQN$ = LicenseDirectory$ + "\" + "EcmLicense." + ServerName + ".txt"
            Dim S$ = LoadLicenseFile(FQN)
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
    Public Function LoadLicenseFile(ByVal FQN As String) As String
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            MsgBox("Failed to load License file: " + vbCrLf + Ex.Message)
            'LogThis("clsDatabase : LoadLicenseFile : 5914 : " + Ex.Message)
            Return ""
        End Try
        Return strContents
    End Function
    Function ArchiveBitSet(ByVal FQN As String) As Boolean

        Dim FI As New FileInfo(FQN)
        Dim fAttr As FileAttribute
        fAttr = File.GetAttributes(FQN)
        Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttribute.Archive) = FileAttribute.Archive)
        Dim bArchive As Boolean = FileAttribute.Archive
        Return isArchive

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
        '    MsgBox("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
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
        ElseIf currFileSize >= 1000000000 Then
            NewTimeOut = 3600
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

        Dim AR$()

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

        Dim I As Integer = FQN$.Length
        Dim sHash As String = FQN$.Length.ToString + ":" + dHash.ToString
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

        Dim I As Integer = FileName$.Length
        Dim sHash As String = FileName$.Length.ToString + ":" + dHash.ToString
        Return sHash

    End Function

    Function HashDirFileName(ByVal DirName As String, ByVal FileName As String) As String

        Dim sHash As String = HashDirName(DirName) + ":" + HashFileName(FileName)
        Return sHash

    End Function


    Sub SaveNewUserSettings()

        Dim LOG As New clsLogging

        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100")
        'Dim ECMDB$ = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB )
        Dim ECMDB$ = My.Settings("UserDefaultConnString")
        'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB )

        My.Settings("UpgradeSettings") = False
        My.Settings("DB_EcmLibrary") = My.Settings("UserDefaultConnString")
        My.Settings("DB_Thesaurus") = My.Settings("UserThesaurusConnString")
        'My.Settings("UserDefaultConnString") = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        ' My.Settings("UserThesaurusConnString") = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString")
        My.Settings.Save()

        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 400 " + My.Settings("DB_EcmLibrary"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 500 " + My.Settings("DB_Thesaurus"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 600 " + My.Settings("UserDefaultConnString"))
        LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 700 " + My.Settings("UserThesaurusConnString"))

        LOG = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Function EnumerateDiskDrives(ByRef Drives As SortedList(Of String, String)) As Boolean

        ' Dim fso As New Scripting.FileSystemObject()
        Dim objDrive
        Dim objFSO As Object

        objFSO = CreateObject("Scripting.FileSystemObject")
        Dim colDrives = objFSO.Drives

        For Each objDrive In colDrives
            Dim DriveType As String = ""
            Dim DriveLetter$ = objDrive.DriveLetter
            Dim NumData As Integer = objDrive.drivetype
            Select Case NumData
                Case 1
                    DriveType$ = "Removable"
                Case 2
                    DriveType$ = "Fixed"
                Case 3
                    DriveType$ = "Network"
                Case 4
                    DriveType$ = "CD-ROM"
                Case 5
                    DriveType$ = "RAM Disk"
                Case Else
                    DriveType$ = "Unknown"
            End Select
            If Drives.IndexOfKey(DriveLetter) >= 0 Then
            Else
                Drives.Add(DriveLetter, DriveType)
            End If
        Next

    End Function

    Sub xSaveCurrentConnectionInfo()


        Dim Dir As String = Environment.GetEnvironmentVariable("temp")
        Dim EcmConStr As String = "ECM" + Chr(254)
        Dim ThesaurusStr As String = "THE" + Chr(254)
        Dim FileName As String = "EcmLoginInfo.DAT"
        Dim FQN As String = TempDir + "\" + FileName


        Dim oFile As File
        Dim oWrite As StreamWriter = Nothing

        Try
            EcmConStr$ += My.Settings("UserDefaultConnString")
            ThesaurusStr$ += My.Settings("UserThesaurusConnString")

#Disable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance
            oWrite = oFile.CreateText(FQN)
#Enable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance

            EcmConStr = ENC.AES256EncryptString(EcmConStr)
            ThesaurusStr$ = ENC.AES256EncryptString(ThesaurusStr)
            oWrite.WriteLine(EcmConStr)
            oWrite.WriteLine(ThesaurusStr)
        Catch ex As Exception
            Dim LOG As New clsLogging
            LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message)
            LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace)
            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        Finally
            oWrite.Close()
            oWrite = Nothing
            oFile = Nothing
        End Try

    End Sub
    Sub xgetCurrentConnectionInfo()

        Dim LOG As New clsLogging
        Try
            LOG.WriteToInstallLog("Track 1")


            Dim EcmConStr As String = "ECM" + Chr(254)
            Dim ThesaurusStr As String = "THE" + Chr(254)
            Dim FileName As String = "EcmLoginInfo.DAT"
            Dim FQN As String = TempDir + "\" + FileName
            Dim LineIn As String = ""
            Dim oFile As System.IO.File = Nothing
            Dim oRead As System.IO.StreamReader = Nothing
            LOG.WriteToInstallLog("Track 2")
            If Not File.Exists(FQN) Then
                'oRead.Close()
                oRead = Nothing
                oFile = Nothing
                Return
            End If
            LOG.WriteToInstallLog("Track 3")
            Try
#Disable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance
                oRead = oFile.OpenText(FQN)
#Enable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance
                Dim NeedsSaving As Boolean = False
                While oRead.Peek <> -1
                    LineIn = oRead.ReadLine()
                    LineIn = ENC.AES256DecryptString(LineIn)

                    Dim A$() = LineIn.Split("?")
                    Dim tCode$ = A(0)
                    Dim cs$ = A(1)

                    If tCode.Equals("ECM") Then
                        My.Settings("DB_EcmLibrary") = cs$
                        My.Settings("UserDefaultConnString") = cs$
                        NeedsSaving = True
                    End If
                    If tCode.Equals("THE") Then
                        My.Settings("DB_Thesaurus") = cs$
                        My.Settings("UserThesaurusConnString") = cs$
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
                'ENC = Nothing
            End Try
        Catch ex As Exception
            LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message)
            LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace)
        Finally

            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Sub

    Function genEmailIdentifier(ByVal MessageSize As String, ByVal ReceivedTime As String, ByVal SenderEmailAddress As String, ByVal Subject As String, ByVal CurrentUserID As String) As String
        Dim EmailIdentifier As String = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Mid(Subject, 1, 80) + "~" + CurrentUserID

        EmailIdentifier = RemoveSingleQuotes(EmailIdentifier)
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
            If File.Exists(FQN) Then
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
        If File.Exists(FQN) Then
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
            Dim LOG As New clsLogging
            LOG.WriteToSqlLog("ERRROR date: ConvertDate 100: LL= " + LL.ToString + ", error on converting date '" + tDate.ToString + "'." + vbCrLf + ex.Message)
            LOG = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return xDate

    End Function

    Function ckPdfSearchable(ByVal FQN As String) As Boolean

        Dim EntireFile As String
        Dim oFile As System.IO.File
        Dim oRead As System.IO.StreamReader
        FQN = ReplaceSingleQuotes(FQN)
#Disable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance
        oRead = oFile.OpenText(FQN)
#Enable Warning BC42025 ' Access of shared member, constant member, enum member or nested type through an instance
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

    Function GetLoggedinUserName() As String

        Dim UserName As String = ""
        Try
            UserName = System.Web.HttpContext.Current.User.Identity.Name
        Catch ex As Exception
            UserName = "UNKNOWN"
            MsgBox(ex.Message)
        End Try
        Return UserName

    End Function

    Sub GetMachineIP(ByVal LoggedInIP As String)

        Dim pstrClientRemoteAddress As String = System.Web.HttpContext.Current.Request.ServerVariables("remote_addr").ToString

        Dim pstrClientAddress As String = System.Web.HttpContext.Current.Request.UserHostAddress.ToString
        Dim pstrClientHostName As String = System.Web.HttpContext.Current.Request.UserHostName.ToString
        'Try
        '    'string CustomerIP = System.Web.HttpContext.Current.Request.UserHostAddress
        '    Console.WriteLine(HttpContext.Current.Request.UserHostAddress)
        '    pstrClientAddress = HttpContext.Current.Request.UserHostAddress.ToString
        '    If HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR") IsNot Nothing Then
        '        pstrClientAddress = HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR").ToString()
        '    ElseIf HttpContext.Current.Request.ServerVariables("REMOTE_ADDR") IsNot Nothing Then
        '        pstrClientAddress = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString
        '    End If
        'Catch ex As Exception
        '    pstrClientAddress = "ERROR in IP"
        'End Try
    End Sub
    Function GetMachineIP() As String

        'Dim pstrClientAddress As String = ""
        'Try
        '    'string CustomerIP = System.Web.HttpContext.Current.Request.UserHostAddress
        '    Console.WriteLine(HttpContext.Current.Request.UserHostAddress)
        '    pstrClientAddress = HttpContext.Current.Request.UserHostAddress.ToString
        '    If HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR") IsNot Nothing Then
        '        pstrClientAddress = HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR").ToString()
        '    ElseIf HttpContext.Current.Request.ServerVariables("REMOTE_ADDR") IsNot Nothing Then
        '        pstrClientAddress = HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString
        '    End If
        'Catch ex As Exception
        '    pstrClientAddress = "ERROR in IP"
        'End Try

        Try
            Dim O As Object = System.Web.HttpContext.Current.Request.ServerVariables
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        Try
            Dim pstrClientAddress As String = System.Web.HttpContext.Current.Request.ServerVariables("remote_addr").ToString
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        Try
            Dim pstrClientAddress As String = System.Web.HttpContext.Current.Request.UserHostAddress.ToString
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        Try
            Dim pstrClientHostName As String = System.Web.HttpContext.Current.Request.UserHostName.ToString
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        Dim S As String = ""
        Try
            Dim STRHOSTNAME As String = ""
            Dim STRIPADDRESS As String = ""
            Dim HOST As System.Net.IPHostEntry = Nothing

            STRHOSTNAME = System.Net.Dns.GetHostName()
            STRIPADDRESS = System.Net.Dns.GetHostEntry(STRHOSTNAME).HostName.ToString()

            HOST = System.Net.Dns.GetHostEntry(STRHOSTNAME)
            Dim IP As System.Net.IPAddress

            For Each IP In HOST.AddressList
                Dim a() As String = IP.ToString.Split(".")
                Dim ckGood As Boolean = True
                For I As Integer = 0 To UBound(a)
                    Dim tgt As String = a(I)
                    If IsNumeric(a(I)) Then
                    Else
                        ckGood = False
                        Exit For
                    End If
                Next
                If ckGood Then
                    Return IP.ToString()
                End If
            Next
            S = STRHOSTNAME
        Catch ex As Exception
            S = ex.Message
        End Try
        Return S
    End Function

    Function GetHostMachineName() As String

        Dim STRHOSTNAME As String = ""
        Dim STRIPADDRESS As String = ""
        Dim S As String = ""

        Try
            Dim HOST As System.Net.IPHostEntry = Nothing

            STRHOSTNAME = System.Net.Dns.GetHostName()
            STRIPADDRESS = System.Net.Dns.GetHostEntry(STRHOSTNAME).HostName.ToString()

            HOST = System.Net.Dns.GetHostEntry(STRHOSTNAME)
            Dim IP As System.Net.IPAddress
            Dim I As Integer = 0
            For Each IP In HOST.AddressList
                Return IP.ToString()
                I += 1
            Next
            S = STRHOSTNAME
        Catch ex As Exception
            S = ex.Message
        End Try
        Return STRHOSTNAME
    End Function

    ''' <summary>
    ''' Looksup and returns a mime type for a passed in file extension. If none is found, then octet-stream is returned.
    ''' </summary>
    ''' <param name="fExt">The target file extension</param>
    ''' <returns>The found mime type.</returns>
    ''' <remarks></remarks>
    Function getMimeType(ByVal fExt As String) As String
        fExt = fExt.ToLower
        If InStr(fExt, ".") = 0 Then
            fExt = "." + fExt
        End If
        Dim MimeType As String = ""
        If fExt.Equals(".3dm") Then
            MimeType = "x-world/x-3dmf"
        ElseIf fExt.Equals(".docm") Then
            MimeType = "application/vnd.ms-word.document.macroEnabled.12"
        ElseIf fExt.Equals(".docx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ElseIf fExt.Equals(".dotm") Then
            MimeType = "application/vnd.ms-word.template.macroEnabled.12"

        ElseIf fExt.Equals(".dotx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.template"

        ElseIf fExt.Equals(".potm") Then
            MimeType = "application/vnd.ms-powerpoint.template.macroEnabled.12"

        ElseIf fExt.Equals(".potx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.presentationml.template"

        ElseIf fExt.Equals(".ppam") Then
            MimeType = "application/vnd.ms-powerpoint.addin.macroEnabled.12"

        ElseIf fExt.Equals(".ppsm") Then
            MimeType = "application/vnd.ms-powerpoint.slideshow.macroEnabled.12"

        ElseIf fExt.Equals(".ppsx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.presentationml.slideshow"

        ElseIf fExt.Equals(".pptm") Then
            MimeType = "application/vnd.ms-powerpoint.presentation.macroEnabled.12"

        ElseIf fExt.Equals(".pptx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.presentationml.presentation"

        ElseIf fExt.Equals(".xlam") Then
            MimeType = "application/vnd.ms-excel.addin.macroEnabled.12"

        ElseIf fExt.Equals(".xlsb") Then
            MimeType = "application/vnd.ms-excel.sheet.binary.macroEnabled.12"

        ElseIf fExt.Equals(".xlsm") Then
            MimeType = "application/vnd.ms-excel.sheet.macroEnabled.12"

        ElseIf fExt.Equals(".xlsx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

        ElseIf fExt.Equals(".xltm") Then
            MimeType = "application/vnd.ms-excel.template.macroEnabled.12"

        ElseIf fExt.Equals(".xltx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
        ElseIf fExt.Equals(".3dmf") Then
            MimeType = "x-world/x-3dmf"
        ElseIf fExt.Equals(".a") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".aab") Then
            MimeType = "application/x-authorware-bin"
        ElseIf fExt.Equals(".aam") Then
            MimeType = "application/x-authorware-map"
        ElseIf fExt.Equals(".aas") Then
            MimeType = "application/x-authorware-seg"
        ElseIf fExt.Equals(".abc") Then
            MimeType = "text/vnd.abc"
        ElseIf fExt.Equals(".acgi") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".afl") Then
            MimeType = "video/animaflex"
        ElseIf fExt.Equals(".ai") Then
            MimeType = "application/postscript"
        ElseIf fExt.Equals(".aif") Then
            MimeType = "audio/aiff"
        ElseIf fExt.Equals(".aif") Then
            MimeType = "audio/x-aiff"
        ElseIf fExt.Equals(".aifc") Then
            MimeType = "audio/aiff"
        ElseIf fExt.Equals(".aifc") Then
            MimeType = "audio/x-aiff"
        ElseIf fExt.Equals(".aiff") Then
            MimeType = "audio/aiff"
        ElseIf fExt.Equals(".aiff") Then
            MimeType = "audio/x-aiff"
        ElseIf fExt.Equals(".aim") Then
            MimeType = "application/x-aim"
        ElseIf fExt.Equals(".aip") Then
            MimeType = "text/x-audiosoft-intra"
        ElseIf fExt.Equals(".ani") Then
            MimeType = "application/x-navi-animation"
        ElseIf fExt.Equals(".aos") Then
            MimeType = "application/x-nokia-9000-communicator-add-on-software"
        ElseIf fExt.Equals(".aps") Then
            MimeType = "application/mime"
        ElseIf fExt.Equals(".arc") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".arj") Then
            MimeType = "application/arj"
        ElseIf fExt.Equals(".arj") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".art") Then
            MimeType = "image/x-jg"
        ElseIf fExt.Equals(".asf") Then
            MimeType = "video/x-ms-asf"
        ElseIf fExt.Equals(".asm") Then
            MimeType = "text/x-asm"
        ElseIf fExt.Equals(".asp") Then
            MimeType = "text/asp"
        ElseIf fExt.Equals(".asx") Then
            MimeType = "application/x-mplayer2"
        ElseIf fExt.Equals(".asx") Then
            MimeType = "video/x-ms-asf"
        ElseIf fExt.Equals(".asx") Then
            MimeType = "video/x-ms-asf-plugin"
        ElseIf fExt.Equals(".au") Then
            MimeType = "audio/basic"
        ElseIf fExt.Equals(".au") Then
            MimeType = "audio/x-au"
        ElseIf fExt.Equals(".avi") Then
            MimeType = "application/x-troff-msvideo"
        ElseIf fExt.Equals(".avi") Then
            MimeType = "video/avi"
        ElseIf fExt.Equals(".avi") Then
            MimeType = "video/msvideo"
        ElseIf fExt.Equals(".avi") Then
            MimeType = "video/x-msvideo"
        ElseIf fExt.Equals(".avs") Then
            MimeType = "video/avs-video"
        ElseIf fExt.Equals(".bcpio") Then
            MimeType = "application/x-bcpio"
        ElseIf fExt.Equals(".bin") Then
            MimeType = "application/mac-binary"
        ElseIf fExt.Equals(".bin") Then
            MimeType = "application/macbinary"
        ElseIf fExt.Equals(".bin") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".bin") Then
            MimeType = "application/x-binary"
        ElseIf fExt.Equals(".bin") Then
            MimeType = "application/x-macbinary"
        ElseIf fExt.Equals(".bm") Then
            MimeType = "image/bmp"
        ElseIf fExt.Equals(".bmp") Then
            MimeType = "image/bmp"
        ElseIf fExt.Equals(".bmp") Then
            MimeType = "image/x-windows-bmp"
        ElseIf fExt.Equals(".boo") Then
            MimeType = "application/book"
        ElseIf fExt.Equals(".book") Then
            MimeType = "application/book"
        ElseIf fExt.Equals(".boz") Then
            MimeType = "application/x-bzip2"
        ElseIf fExt.Equals(".bsh") Then
            MimeType = "application/x-bsh"
        ElseIf fExt.Equals(".bz") Then
            MimeType = "application/x-bzip"
        ElseIf fExt.Equals(".bz2") Then
            MimeType = "application/x-bzip2"
        ElseIf fExt.Equals(".c") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".c") Then
            MimeType = "text/x-c"
        ElseIf fExt.Equals(".c++") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".cat") Then
            MimeType = "application/vnd.ms-pki.seccat"
        ElseIf fExt.Equals(".cc") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".cc") Then
            MimeType = "text/x-c"
        ElseIf fExt.Equals(".ccad") Then
            MimeType = "application/clariscad"
        ElseIf fExt.Equals(".cco") Then
            MimeType = "application/x-cocoa"
        ElseIf fExt.Equals(".cdf") Then
            MimeType = "application/cdf"
        ElseIf fExt.Equals(".cdf") Then
            MimeType = "application/x-cdf"
        ElseIf fExt.Equals(".cdf") Then
            MimeType = "application/x-netcdf"
        ElseIf fExt.Equals(".cer") Then
            MimeType = "application/pkix-cert"
        ElseIf fExt.Equals(".cer") Then
            MimeType = "application/x-x509-ca-cert"
        ElseIf fExt.Equals(".cha") Then
            MimeType = "application/x-chat"
        ElseIf fExt.Equals(".chat") Then
            MimeType = "application/x-chat"
        ElseIf fExt.Equals(".class") Then
            MimeType = "application/java"
        ElseIf fExt.Equals(".class") Then
            MimeType = "application/java-byte-code"
        ElseIf fExt.Equals(".class") Then
            MimeType = "application/x-java-class"
        ElseIf fExt.Equals(".com") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".com") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".conf") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".cpio") Then
            MimeType = "application/x-cpio"
        ElseIf fExt.Equals(".cpp") Then
            MimeType = "text/x-c"
        ElseIf fExt.Equals(".cpt") Then
            MimeType = "application/mac-compactpro"
        ElseIf fExt.Equals(".cpt") Then
            MimeType = "application/x-compactpro"
        ElseIf fExt.Equals(".cpt") Then
            MimeType = "application/x-cpt"
        ElseIf fExt.Equals(".crl") Then
            MimeType = "application/pkcs-crl"
        ElseIf fExt.Equals(".crl") Then
            MimeType = "application/pkix-crl"
        ElseIf fExt.Equals(".crt") Then
            MimeType = "application/pkix-cert"
        ElseIf fExt.Equals(".crt") Then
            MimeType = "application/x-x509-ca-cert"
        ElseIf fExt.Equals(".crt") Then
            MimeType = "application/x-x509-user-cert"
        ElseIf fExt.Equals(".csh") Then
            MimeType = "application/x-csh"
        ElseIf fExt.Equals(".csh") Then
            MimeType = "text/x-script.csh"
        ElseIf fExt.Equals(".css") Then
            MimeType = "application/x-pointplus"
        ElseIf fExt.Equals(".css") Then
            MimeType = "text/css"
        ElseIf fExt.Equals(".cxx") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".dcr") Then
            MimeType = "application/x-director"
        ElseIf fExt.Equals(".deepv") Then
            MimeType = "application/x-deepv"
        ElseIf fExt.Equals(".def") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".der") Then
            MimeType = "application/x-x509-ca-cert"
        ElseIf fExt.Equals(".dif") Then
            MimeType = "video/x-dv"
        ElseIf fExt.Equals(".dir") Then
            MimeType = "application/x-director"
        ElseIf fExt.Equals(".dl") Then
            MimeType = "video/dl"
        ElseIf fExt.Equals(".dl") Then
            MimeType = "video/x-dl"
        ElseIf fExt.Equals(".doc") Then
            MimeType = "application/msword"
        ElseIf fExt.Equals(".docx") Then
            MimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ElseIf fExt.Equals(".dot") Then
            MimeType = "application/msword"
        ElseIf fExt.Equals(".dp") Then
            MimeType = "application/commonground"
        ElseIf fExt.Equals(".drw") Then
            MimeType = "application/drafting"
        ElseIf fExt.Equals(".dump") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".dv") Then
            MimeType = "video/x-dv"
        ElseIf fExt.Equals(".dvi") Then
            MimeType = "application/x-dvi"
        ElseIf fExt.Equals(".dwf") Then
            MimeType = "drawing/x-dwf	(old)"
        ElseIf fExt.Equals(".dwf") Then
            MimeType = "model/vnd.dwf"
        ElseIf fExt.Equals(".dwg") Then
            MimeType = "application/acad"
        ElseIf fExt.Equals(".dwg") Then
            MimeType = "image/vnd.dwg"
        ElseIf fExt.Equals(".dwg") Then
            MimeType = "image/x-dwg"
        ElseIf fExt.Equals(".dxf") Then
            MimeType = "application/dxf"
        ElseIf fExt.Equals(".dxf") Then
            MimeType = "image/vnd.dwg"
        ElseIf fExt.Equals(".dxf") Then
            MimeType = "image/x-dwg"
        ElseIf fExt.Equals(".dxr") Then
            MimeType = "application/x-director"
        ElseIf fExt.Equals(".el") Then
            MimeType = "text/x-script.elisp"
        ElseIf fExt.Equals(".elc") Then
            MimeType = "application/x-bytecode.elisp	(compiled elisp)"
        ElseIf fExt.Equals(".elc") Then
            MimeType = "application/x-elc"
        ElseIf fExt.Equals(".env") Then
            MimeType = "application/x-envoy"
        ElseIf fExt.Equals(".eps") Then
            MimeType = "application/postscript"
        ElseIf fExt.Equals(".es") Then
            MimeType = "application/x-esrehber"
        ElseIf fExt.Equals(".etx") Then
            MimeType = "text/x-setext"
        ElseIf fExt.Equals(".evy") Then
            MimeType = "application/envoy"
        ElseIf fExt.Equals(".evy") Then
            MimeType = "application/x-envoy"
        ElseIf fExt.Equals(".exe") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".f") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".f") Then
            MimeType = "text/x-fortran"
        ElseIf fExt.Equals(".f77") Then
            MimeType = "text/x-fortran"
        ElseIf fExt.Equals(".f90") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".f90") Then
            MimeType = "text/x-fortran"
        ElseIf fExt.Equals(".fdf") Then
            MimeType = "application/vnd.fdf"
        ElseIf fExt.Equals(".fif") Then
            MimeType = "application/fractals"
        ElseIf fExt.Equals(".fif") Then
            MimeType = "image/fif"
        ElseIf fExt.Equals(".fli") Then
            MimeType = "video/fli"
        ElseIf fExt.Equals(".fli") Then
            MimeType = "video/x-fli"
        ElseIf fExt.Equals(".flo") Then
            MimeType = "image/florian"
        ElseIf fExt.Equals(".flx") Then
            MimeType = "text/vnd.fmi.flexstor"
        ElseIf fExt.Equals(".fmf") Then
            MimeType = "video/x-atomic3d-feature"
        ElseIf fExt.Equals(".for") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".for") Then
            MimeType = "text/x-fortran"
        ElseIf fExt.Equals(".fpx") Then
            MimeType = "image/vnd.fpx"
        ElseIf fExt.Equals(".fpx") Then
            MimeType = "image/vnd.net-fpx"
        ElseIf fExt.Equals(".frl") Then
            MimeType = "application/freeloader"
        ElseIf fExt.Equals(".funk") Then
            MimeType = "audio/make"
        ElseIf fExt.Equals(".g") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".g3") Then
            MimeType = "image/g3fax"
        ElseIf fExt.Equals(".gif") Then
            MimeType = "image/gif"
        ElseIf fExt.Equals(".gl") Then
            MimeType = "video/gl"
        ElseIf fExt.Equals(".gl") Then
            MimeType = "video/x-gl"
        ElseIf fExt.Equals(".gsd") Then
            MimeType = "audio/x-gsm"
        ElseIf fExt.Equals(".gsm") Then
            MimeType = "audio/x-gsm"
        ElseIf fExt.Equals(".gsp") Then
            MimeType = "application/x-gsp"
        ElseIf fExt.Equals(".gss") Then
            MimeType = "application/x-gss"
        ElseIf fExt.Equals(".gtar") Then
            MimeType = "application/x-gtar"
        ElseIf fExt.Equals(".gz") Then
            MimeType = "application/x-compressed"
        ElseIf fExt.Equals(".gz") Then
            MimeType = "application/x-gzip"
        ElseIf fExt.Equals(".gzip") Then
            MimeType = "application/x-gzip"
        ElseIf fExt.Equals(".gzip") Then
            MimeType = "multipart/x-gzip"
        ElseIf fExt.Equals(".h") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".h") Then
            MimeType = "text/x-h"
        ElseIf fExt.Equals(".hdf") Then
            MimeType = "application/x-hdf"
        ElseIf fExt.Equals(".help") Then
            MimeType = "application/x-helpfile"
        ElseIf fExt.Equals(".hgl") Then
            MimeType = "application/vnd.hp-hpgl"
        ElseIf fExt.Equals(".hh") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".hh") Then
            MimeType = "text/x-h"
        ElseIf fExt.Equals(".hlb") Then
            MimeType = "text/x-script"
        ElseIf fExt.Equals(".hlp") Then
            MimeType = "application/hlp"
        ElseIf fExt.Equals(".hlp") Then
            MimeType = "application/x-helpfile"
        ElseIf fExt.Equals(".hlp") Then
            MimeType = "application/x-winhelp"
        ElseIf fExt.Equals(".hpg") Then
            MimeType = "application/vnd.hp-hpgl"
        ElseIf fExt.Equals(".hpgl") Then
            MimeType = "application/vnd.hp-hpgl"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/binhex"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/binhex4"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/mac-binhex"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/mac-binhex40"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/x-binhex40"
        ElseIf fExt.Equals(".hqx") Then
            MimeType = "application/x-mac-binhex40"
        ElseIf fExt.Equals(".hta") Then
            MimeType = "application/hta"
        ElseIf fExt.Equals(".htc") Then
            MimeType = "text/x-component"
        ElseIf fExt.Equals(".htm") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".html") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".htmls") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".htt") Then
            MimeType = "text/webviewhtml"
        ElseIf fExt.Equals(".htx ") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".ice ") Then
            MimeType = "x-conference/x-cooltalk"
        ElseIf fExt.Equals(".ico") Then
            MimeType = "image/x-icon"
        ElseIf fExt.Equals(".idc") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".ief") Then
            MimeType = "image/ief"
        ElseIf fExt.Equals(".iefs") Then
            MimeType = "image/ief"
        ElseIf fExt.Equals(".iges") Then
            MimeType = "application/iges"
        ElseIf fExt.Equals(".iges ") Then
            MimeType = "model/iges"
        ElseIf fExt.Equals(".igs") Then
            MimeType = "application/iges"
        ElseIf fExt.Equals(".igs") Then
            MimeType = "model/iges"
        ElseIf fExt.Equals(".ima") Then
            MimeType = "application/x-ima"
        ElseIf fExt.Equals(".imap") Then
            MimeType = "application/x-httpd-imap"
        ElseIf fExt.Equals(".inf ") Then
            MimeType = "application/inf"
        ElseIf fExt.Equals(".ins") Then
            MimeType = "application/x-internett-signup"
        ElseIf fExt.Equals(".ip ") Then
            MimeType = "application/x-ip2"
        ElseIf fExt.Equals(".isu") Then
            MimeType = "video/x-isvideo"
        ElseIf fExt.Equals(".it") Then
            MimeType = "audio/it"
        ElseIf fExt.Equals(".iv") Then
            MimeType = "application/x-inventor"
        ElseIf fExt.Equals(".ivr") Then
            MimeType = "i-world/i-vrml"
        ElseIf fExt.Equals(".ivy") Then
            MimeType = "application/x-livescreen"
        ElseIf fExt.Equals(".jam ") Then
            MimeType = "audio/x-jam"
        ElseIf fExt.Equals(".jav") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".jav") Then
            MimeType = "text/x-java-source"
        ElseIf fExt.Equals(".java") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".java ") Then
            MimeType = "text/x-java-source"
        ElseIf fExt.Equals(".jcm ") Then
            MimeType = "application/x-java-commerce"
        ElseIf fExt.Equals(".jfif") Then
            MimeType = "image/jpeg"
        ElseIf fExt.Equals(".jfif") Then
            MimeType = "image/pjpeg"
        ElseIf fExt.Equals(".jfif-tbnl") Then
            MimeType = "image/jpeg"
        ElseIf fExt.Equals(".jpe") Then
            MimeType = "image/jpeg"
        ElseIf fExt.Equals(".jpe") Then
            MimeType = "image/pjpeg"
        ElseIf fExt.Equals(".jpeg") Then
            MimeType = "image/jpeg"
        ElseIf fExt.Equals(".jpeg") Then
            MimeType = "image/pjpeg"
        ElseIf fExt.Equals(".jpg ") Then
            MimeType = "image/jpeg"
        ElseIf fExt.Equals(".jpg ") Then
            MimeType = "image/pjpeg"
        ElseIf fExt.Equals(".jps") Then
            MimeType = "image/x-jps"
        ElseIf fExt.Equals(".js ") Then
            MimeType = "application/x-javascript"
        ElseIf fExt.Equals(".jut") Then
            MimeType = "image/jutvision"
        ElseIf fExt.Equals(".kar") Then
            MimeType = "audio/midi"
        ElseIf fExt.Equals(".kar") Then
            MimeType = "music/x-karaoke"
        ElseIf fExt.Equals(".ksh") Then
            MimeType = "application/x-ksh"
        ElseIf fExt.Equals(".ksh") Then
            MimeType = "text/x-script.ksh"
        ElseIf fExt.Equals(".la ") Then
            MimeType = "audio/nspaudio"
        ElseIf fExt.Equals(".la ") Then
            MimeType = "audio/x-nspaudio"
        ElseIf fExt.Equals(".lam") Then
            MimeType = "audio/x-liveaudio"
        ElseIf fExt.Equals(".latex ") Then
            MimeType = "application/x-latex"
        ElseIf fExt.Equals(".lha") Then
            MimeType = "application/lha"
        ElseIf fExt.Equals(".lha") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".lha") Then
            MimeType = "application/x-lha"
        ElseIf fExt.Equals(".lhx") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".list") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".lma") Then
            MimeType = "audio/nspaudio"
        ElseIf fExt.Equals(".lma") Then
            MimeType = "audio/x-nspaudio"
        ElseIf fExt.Equals(".log ") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".lsp ") Then
            MimeType = "application/x-lisp"
        ElseIf fExt.Equals(".lsp ") Then
            MimeType = "text/x-script.lisp"
        ElseIf fExt.Equals(".lst ") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".lsx") Then
            MimeType = "text/x-la-asf"
        ElseIf fExt.Equals(".ltx") Then
            MimeType = "application/x-latex"
        ElseIf fExt.Equals(".lzh") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".lzh") Then
            MimeType = "application/x-lzh"
        ElseIf fExt.Equals(".lzx") Then
            MimeType = "application/lzx"
        ElseIf fExt.Equals(".lzx") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".lzx") Then
            MimeType = "application/x-lzx"
        ElseIf fExt.Equals(".m") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".m") Then
            MimeType = "text/x-m"
        ElseIf fExt.Equals(".m1v") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".m2a") Then
            MimeType = "audio/mpeg"
        ElseIf fExt.Equals(".m2v") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".m3u ") Then
            MimeType = "audio/x-mpequrl"
        ElseIf fExt.Equals(".man") Then
            MimeType = "application/x-troff-man"
        ElseIf fExt.Equals(".map") Then
            MimeType = "application/x-navimap"
        ElseIf fExt.Equals(".mar") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".mbd") Then
            MimeType = "application/mbedlet"
        ElseIf fExt.Equals(".mc$") Then
            MimeType = "application/x-magic-cap-package-1.0"
        ElseIf fExt.Equals(".mcd") Then
            MimeType = "application/mcad"
        ElseIf fExt.Equals(".mcd") Then
            MimeType = "application/x-mathcad"
        ElseIf fExt.Equals(".mcf") Then
            MimeType = "image/vasa"
        ElseIf fExt.Equals(".mcf") Then
            MimeType = "text/mcf"
        ElseIf fExt.Equals(".mcp") Then
            MimeType = "application/netmc"
        ElseIf fExt.Equals(".me ") Then
            MimeType = "application/x-troff-me"
        ElseIf fExt.Equals(".mht") Then
            MimeType = "message/rfc822"
        ElseIf fExt.Equals(".mhtml") Then
            MimeType = "message/rfc822"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "application/x-midi"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "audio/midi"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "audio/x-mid"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "audio/x-midi"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "music/crescendo"
        ElseIf fExt.Equals(".mid") Then
            MimeType = "x-music/x-midi"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "application/x-midi"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "audio/midi"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "audio/x-mid"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "audio/x-midi"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "music/crescendo"
        ElseIf fExt.Equals(".midi") Then
            MimeType = "x-music/x-midi"
        ElseIf fExt.Equals(".mif") Then
            MimeType = "application/x-frame"
        ElseIf fExt.Equals(".mif") Then
            MimeType = "application/x-mif"
        ElseIf fExt.Equals(".mime ") Then
            MimeType = "message/rfc822"
        ElseIf fExt.Equals(".mime ") Then
            MimeType = "www/mime"
        ElseIf fExt.Equals(".mjf") Then
            MimeType = "audio/x-vnd.audioexplosion.mjuicemediafile"
        ElseIf fExt.Equals(".mjpg ") Then
            MimeType = "video/x-motion-jpeg"
        ElseIf fExt.Equals(".mm") Then
            MimeType = "application/base64"
        ElseIf fExt.Equals(".mm") Then
            MimeType = "application/x-meme"
        ElseIf fExt.Equals(".mme") Then
            MimeType = "application/base64"
        ElseIf fExt.Equals(".mod") Then
            MimeType = "audio/mod"
        ElseIf fExt.Equals(".mod") Then
            MimeType = "audio/x-mod"
        ElseIf fExt.Equals(".moov") Then
            MimeType = "video/quicktime"
        ElseIf fExt.Equals(".mov") Then
            MimeType = "video/quicktime"
        ElseIf fExt.Equals(".movie") Then
            MimeType = "video/x-sgi-movie"
        ElseIf fExt.Equals(".mp2") Then
            MimeType = "audio/mpeg"
        ElseIf fExt.Equals(".mp2") Then
            MimeType = "audio/x-mpeg"
        ElseIf fExt.Equals(".mp2") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mp2") Then
            MimeType = "video/x-mpeg"
        ElseIf fExt.Equals(".mp2") Then
            MimeType = "video/x-mpeq2a"
        ElseIf fExt.Equals(".mp3") Then
            MimeType = "audio/mpeg3"
        ElseIf fExt.Equals(".mp3") Then
            MimeType = "audio/x-mpeg-3"
        ElseIf fExt.Equals(".mp3") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mp3") Then
            MimeType = "video/x-mpeg"
        ElseIf fExt.Equals(".mpa") Then
            MimeType = "audio/mpeg"
        ElseIf fExt.Equals(".mpa") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mpc") Then
            MimeType = "application/x-project"
        ElseIf fExt.Equals(".mpe") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mpeg") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mpg") Then
            MimeType = "audio/mpeg"
        ElseIf fExt.Equals(".mpg") Then
            MimeType = "video/mpeg"
        ElseIf fExt.Equals(".mpga") Then
            MimeType = "audio/mpeg"
        ElseIf fExt.Equals(".mpp") Then
            MimeType = "application/vnd.ms-project"
        ElseIf fExt.Equals(".mpt") Then
            MimeType = "application/x-project"
        ElseIf fExt.Equals(".mpv") Then
            MimeType = "application/x-project"
        ElseIf fExt.Equals(".mpx") Then
            MimeType = "application/x-project"
        ElseIf fExt.Equals(".mrc") Then
            MimeType = "application/marc"
        ElseIf fExt.Equals(".ms") Then
            MimeType = "application/x-troff-ms"
        ElseIf fExt.Equals(".mv") Then
            MimeType = "video/x-sgi-movie"
        ElseIf fExt.Equals(".my") Then
            MimeType = "audio/make"
        ElseIf fExt.Equals(".mzz") Then
            MimeType = "application/x-vnd.audioexplosion.mzz"
        ElseIf fExt.Equals(".nap") Then
            MimeType = "image/naplps"
        ElseIf fExt.Equals(".naplps") Then
            MimeType = "image/naplps"
        ElseIf fExt.Equals(".nc") Then
            MimeType = "application/x-netcdf"
        ElseIf fExt.Equals(".ncm") Then
            MimeType = "application/vnd.nokia.configuration-message"
        ElseIf fExt.Equals(".nif") Then
            MimeType = "image/x-niff"
        ElseIf fExt.Equals(".niff") Then
            MimeType = "image/x-niff"
        ElseIf fExt.Equals(".nix") Then
            MimeType = "application/x-mix-transfer"
        ElseIf fExt.Equals(".nsc") Then
            MimeType = "application/x-conference"
        ElseIf fExt.Equals(".nvd") Then
            MimeType = "application/x-navidoc"
        ElseIf fExt.Equals(".o") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".oda") Then
            MimeType = "application/oda"
        ElseIf fExt.Equals(".omc") Then
            MimeType = "application/x-omc"
        ElseIf fExt.Equals(".omcd") Then
            MimeType = "application/x-omcdatamaker"
        ElseIf fExt.Equals(".omcr") Then
            MimeType = "application/x-omcregerator"
        ElseIf fExt.Equals(".p") Then
            MimeType = "text/x-pascal"
        ElseIf fExt.Equals(".p10") Then
            MimeType = "application/pkcs10"
        ElseIf fExt.Equals(".p10") Then
            MimeType = "application/x-pkcs10"
        ElseIf fExt.Equals(".p12") Then
            MimeType = "application/pkcs-12"
        ElseIf fExt.Equals(".p12") Then
            MimeType = "application/x-pkcs12"
        ElseIf fExt.Equals(".p7a") Then
            MimeType = "application/x-pkcs7-signature"
        ElseIf fExt.Equals(".p7c") Then
            MimeType = "application/pkcs7-mime"
        ElseIf fExt.Equals(".p7c") Then
            MimeType = "application/x-pkcs7-mime"
        ElseIf fExt.Equals(".p7m") Then
            MimeType = "application/pkcs7-mime"
        ElseIf fExt.Equals(".p7m") Then
            MimeType = "application/x-pkcs7-mime"
        ElseIf fExt.Equals(".p7r") Then
            MimeType = "application/x-pkcs7-certreqresp"
        ElseIf fExt.Equals(".p7s") Then
            MimeType = "application/pkcs7-signature"
        ElseIf fExt.Equals(".part ") Then
            MimeType = "application/pro_eng"
        ElseIf fExt.Equals(".pas") Then
            MimeType = "text/pascal"
        ElseIf fExt.Equals(".pbm ") Then
            MimeType = "image/x-portable-bitmap"
        ElseIf fExt.Equals(".pcl") Then
            MimeType = "application/vnd.hp-pcl"
        ElseIf fExt.Equals(".pcl") Then
            MimeType = "application/x-pcl"
        ElseIf fExt.Equals(".pct") Then
            MimeType = "image/x-pict"
        ElseIf fExt.Equals(".pcx") Then
            MimeType = "image/x-pcx"
        ElseIf fExt.Equals(".pdb") Then
            MimeType = "chemical/x-pdb"
        ElseIf fExt.Equals(".pdf") Then
            MimeType = "application/pdf"
        ElseIf fExt.Equals(".pfunk") Then
            MimeType = "audio/make"
        ElseIf fExt.Equals(".pfunk") Then
            MimeType = "audio/make.my.funk"
        ElseIf fExt.Equals(".pgm") Then
            MimeType = "image/x-portable-graymap"
        ElseIf fExt.Equals(".pgm") Then
            MimeType = "image/x-portable-greymap"
        ElseIf fExt.Equals(".pic") Then
            MimeType = "image/pict"
        ElseIf fExt.Equals(".pict") Then
            MimeType = "image/pict"
        ElseIf fExt.Equals(".pkg") Then
            MimeType = "application/x-newton-compatible-pkg"
        ElseIf fExt.Equals(".pko") Then
            MimeType = "application/vnd.ms-pki.pko"
        ElseIf fExt.Equals(".pl") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".pl") Then
            MimeType = "text/x-script.perl"
        ElseIf fExt.Equals(".plx") Then
            MimeType = "application/x-pixclscript"
        ElseIf fExt.Equals(".pm") Then
            MimeType = "image/x-xpixmap"
        ElseIf fExt.Equals(".pm") Then
            MimeType = "text/x-script.perl-module"
        ElseIf fExt.Equals(".pm4 ") Then
            MimeType = "application/x-pagemaker"
        ElseIf fExt.Equals(".pm5") Then
            MimeType = "application/x-pagemaker"
        ElseIf fExt.Equals(".png") Then
            MimeType = "image/png"
        ElseIf fExt.Equals(".pnm") Then
            MimeType = "application/x-portable-anymap"
        ElseIf fExt.Equals(".pnm") Then
            MimeType = "image/x-portable-anymap"
        ElseIf fExt.Equals(".pot") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".pot") Then
            MimeType = "application/vnd.ms-powerpoint"
        ElseIf fExt.Equals(".pov") Then
            MimeType = "model/x-pov"
        ElseIf fExt.Equals(".ppa") Then
            MimeType = "application/vnd.ms-powerpoint"
        ElseIf fExt.Equals(".ppm") Then
            MimeType = "image/x-portable-pixmap"
        ElseIf fExt.Equals(".pps") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".pps") Then
            MimeType = "application/vnd.ms-powerpoint"
        ElseIf fExt.Equals(".ppt") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".ppt") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".pptx") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".ppt") Then
            MimeType = "application/vnd.ms-powerpoint"
        ElseIf fExt.Equals(".ppt") Then
            MimeType = "application/x-mspowerpoint"
        ElseIf fExt.Equals(".ppz") Then
            MimeType = "application/mspowerpoint"
        ElseIf fExt.Equals(".pre") Then
            MimeType = "application/x-freelance"
        ElseIf fExt.Equals(".prt") Then
            MimeType = "application/pro_eng"
        ElseIf fExt.Equals(".ps") Then
            MimeType = "application/postscript"
        ElseIf fExt.Equals(".psd") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".pvu") Then
            MimeType = "paleovu/x-pv"
        ElseIf fExt.Equals(".pwz ") Then
            MimeType = "application/vnd.ms-powerpoint"
        ElseIf fExt.Equals(".py ") Then
            MimeType = "text/x-script.phyton"
        ElseIf fExt.Equals(".pyc ") Then
            MimeType = "applicaiton/x-bytecode.python"
        ElseIf fExt.Equals(".qcp ") Then
            MimeType = "audio/vnd.qcelp"
        ElseIf fExt.Equals(".qd3 ") Then
            MimeType = "x-world/x-3dmf"
        ElseIf fExt.Equals(".qd3d ") Then
            MimeType = "x-world/x-3dmf"
        ElseIf fExt.Equals(".qif") Then
            MimeType = "image/x-quicktime"
        ElseIf fExt.Equals(".qt") Then
            MimeType = "video/quicktime"
        ElseIf fExt.Equals(".qtc") Then
            MimeType = "video/x-qtc"
        ElseIf fExt.Equals(".qti") Then
            MimeType = "image/x-quicktime"
        ElseIf fExt.Equals(".qtif") Then
            MimeType = "image/x-quicktime"
        ElseIf fExt.Equals(".ra") Then
            MimeType = "audio/x-pn-realaudio"
        ElseIf fExt.Equals(".ra") Then
            MimeType = "audio/x-pn-realaudio-plugin"
        ElseIf fExt.Equals(".ra") Then
            MimeType = "audio/x-realaudio"
        ElseIf fExt.Equals(".ram") Then
            MimeType = "audio/x-pn-realaudio"
        ElseIf fExt.Equals(".ras") Then
            MimeType = "application/x-cmu-raster"
        ElseIf fExt.Equals(".ras") Then
            MimeType = "image/cmu-raster"
        ElseIf fExt.Equals(".ras") Then
            MimeType = "image/x-cmu-raster"
        ElseIf fExt.Equals(".rast") Then
            MimeType = "image/cmu-raster"
        ElseIf fExt.Equals(".rexx ") Then
            MimeType = "text/x-script.rexx"
        ElseIf fExt.Equals(".rf") Then
            MimeType = "image/vnd.rn-realflash"
        ElseIf fExt.Equals(".rgb ") Then
            MimeType = "image/x-rgb"
        ElseIf fExt.Equals(".rm") Then
            MimeType = "application/vnd.rn-realmedia"
        ElseIf fExt.Equals(".rm") Then
            MimeType = "audio/x-pn-realaudio"
        ElseIf fExt.Equals(".rmi") Then
            MimeType = "audio/mid"
        ElseIf fExt.Equals(".rmm ") Then
            MimeType = "audio/x-pn-realaudio"
        ElseIf fExt.Equals(".rmp") Then
            MimeType = "audio/x-pn-realaudio"
        ElseIf fExt.Equals(".rmp") Then
            MimeType = "audio/x-pn-realaudio-plugin"
        ElseIf fExt.Equals(".rng") Then
            MimeType = "application/ringing-tones"
        ElseIf fExt.Equals(".rng") Then
            MimeType = "application/vnd.nokia.ringing-tone"
        ElseIf fExt.Equals(".rnx ") Then
            MimeType = "application/vnd.rn-realplayer"
        ElseIf fExt.Equals(".roff") Then
            MimeType = "application/x-troff"
        ElseIf fExt.Equals(".rp ") Then
            MimeType = "image/vnd.rn-realpix"
        ElseIf fExt.Equals(".rpm") Then
            MimeType = "audio/x-pn-realaudio-plugin"
        ElseIf fExt.Equals(".rt") Then
            MimeType = "text/richtext"
        ElseIf fExt.Equals(".rt") Then
            MimeType = "text/vnd.rn-realtext"
        ElseIf fExt.Equals(".rtf") Then
            MimeType = "application/rtf"
        ElseIf fExt.Equals(".rtf") Then
            MimeType = "application/x-rtf"
        ElseIf fExt.Equals(".rtf") Then
            MimeType = "text/richtext"
        ElseIf fExt.Equals(".rtx") Then
            MimeType = "application/rtf"
        ElseIf fExt.Equals(".rtx") Then
            MimeType = "text/richtext"
        ElseIf fExt.Equals(".rv") Then
            MimeType = "video/vnd.rn-realvideo"
        ElseIf fExt.Equals(".s") Then
            MimeType = "text/x-asm"
        ElseIf fExt.Equals(".s3m ") Then
            MimeType = "audio/s3m"
        ElseIf fExt.Equals(".saveme") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".sbk ") Then
            MimeType = "application/x-tbook"
        ElseIf fExt.Equals(".scm") Then
            MimeType = "application/x-lotusscreencam"
        ElseIf fExt.Equals(".scm") Then
            MimeType = "text/x-script.guile"
        ElseIf fExt.Equals(".scm") Then
            MimeType = "text/x-script.scheme"
        ElseIf fExt.Equals(".scm") Then
            MimeType = "video/x-scm"
        ElseIf fExt.Equals(".sdml") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".sdp ") Then
            MimeType = "application/sdp"
        ElseIf fExt.Equals(".sdp ") Then
            MimeType = "application/x-sdp"
        ElseIf fExt.Equals(".sdr") Then
            MimeType = "application/sounder"
        ElseIf fExt.Equals(".sea") Then
            MimeType = "application/sea"
        ElseIf fExt.Equals(".sea") Then
            MimeType = "application/x-sea"
        ElseIf fExt.Equals(".set") Then
            MimeType = "application/set"
        ElseIf fExt.Equals(".sgm ") Then
            MimeType = "text/sgml"
        ElseIf fExt.Equals(".sgm ") Then
            MimeType = "text/x-sgml"
        ElseIf fExt.Equals(".sgml") Then
            MimeType = "text/sgml"
        ElseIf fExt.Equals(".sgml") Then
            MimeType = "text/x-sgml"
        ElseIf fExt.Equals(".sh") Then
            MimeType = "application/x-bsh"
        ElseIf fExt.Equals(".sh") Then
            MimeType = "application/x-sh"
        ElseIf fExt.Equals(".sh") Then
            MimeType = "application/x-shar"
        ElseIf fExt.Equals(".sh") Then
            MimeType = "text/x-script.sh"
        ElseIf fExt.Equals(".shar") Then
            MimeType = "application/x-bsh"
        ElseIf fExt.Equals(".shar") Then
            MimeType = "application/x-shar"
        ElseIf fExt.Equals(".shtml ") Then
            MimeType = "text/html"
        ElseIf fExt.Equals(".shtml") Then
            MimeType = "text/x-server-parsed-html"
        ElseIf fExt.Equals(".sid") Then
            MimeType = "audio/x-psid"
        ElseIf fExt.Equals(".sit") Then
            MimeType = "application/x-sit"
        ElseIf fExt.Equals(".sit") Then
            MimeType = "application/x-stuffit"
        ElseIf fExt.Equals(".skd") Then
            MimeType = "application/x-koan"
        ElseIf fExt.Equals(".skm ") Then
            MimeType = "application/x-koan"
        ElseIf fExt.Equals(".skp ") Then
            MimeType = "application/x-koan"
        ElseIf fExt.Equals(".skt ") Then
            MimeType = "application/x-koan"
        ElseIf fExt.Equals(".sl ") Then
            MimeType = "application/x-seelogo"
        ElseIf fExt.Equals(".smi ") Then
            MimeType = "application/smil"
        ElseIf fExt.Equals(".smil ") Then
            MimeType = "application/smil"
        ElseIf fExt.Equals(".snd") Then
            MimeType = "audio/basic"
        ElseIf fExt.Equals(".snd") Then
            MimeType = "audio/x-adpcm"
        ElseIf fExt.Equals(".sol") Then
            MimeType = "application/solids"
        ElseIf fExt.Equals(".spc ") Then
            MimeType = "application/x-pkcs7-certificates"
        ElseIf fExt.Equals(".spc ") Then
            MimeType = "text/x-speech"
        ElseIf fExt.Equals(".spl") Then
            MimeType = "application/futuresplash"
        ElseIf fExt.Equals(".spr") Then
            MimeType = "application/x-sprite"
        ElseIf fExt.Equals(".sprite ") Then
            MimeType = "application/x-sprite"
        ElseIf fExt.Equals(".src") Then
            MimeType = "application/x-wais-source"
        ElseIf fExt.Equals(".ssi") Then
            MimeType = "text/x-server-parsed-html"
        ElseIf fExt.Equals(".ssm ") Then
            MimeType = "application/streamingmedia"
        ElseIf fExt.Equals(".sst") Then
            MimeType = "application/vnd.ms-pki.certstore"
        ElseIf fExt.Equals(".step") Then
            MimeType = "application/step"
        ElseIf fExt.Equals(".stl") Then
            MimeType = "application/sla"
        ElseIf fExt.Equals(".stl") Then
            MimeType = "application/vnd.ms-pki.stl"
        ElseIf fExt.Equals(".stl") Then
            MimeType = "application/x-navistyle"
        ElseIf fExt.Equals(".stp") Then
            MimeType = "application/step"
        ElseIf fExt.Equals(".sv4cpio") Then
            MimeType = "application/x-sv4cpio"
        ElseIf fExt.Equals(".sv4crc") Then
            MimeType = "application/x-sv4crc"
        ElseIf fExt.Equals(".svf") Then
            MimeType = "image/vnd.dwg"
        ElseIf fExt.Equals(".svf") Then
            MimeType = "image/x-dwg"
        ElseIf fExt.Equals(".svr") Then
            MimeType = "application/x-world"
        ElseIf fExt.Equals(".svr") Then
            MimeType = "x-world/x-svr"
        ElseIf fExt.Equals(".swf") Then
            MimeType = "application/x-shockwave-flash"
        ElseIf fExt.Equals(".t") Then
            MimeType = "application/x-troff"
        ElseIf fExt.Equals(".talk") Then
            MimeType = "text/x-speech"
        ElseIf fExt.Equals(".tar") Then
            MimeType = "application/x-tar"
        ElseIf fExt.Equals(".tbk") Then
            MimeType = "application/toolbook"
        ElseIf fExt.Equals(".tbk") Then
            MimeType = "application/x-tbook"
        ElseIf fExt.Equals(".tcl") Then
            MimeType = "application/x-tcl"
        ElseIf fExt.Equals(".tcl") Then
            MimeType = "text/x-script.tcl"
        ElseIf fExt.Equals(".tcsh") Then
            MimeType = "text/x-script.tcsh"
        ElseIf fExt.Equals(".tex") Then
            MimeType = "application/x-tex"
        ElseIf fExt.Equals(".texi") Then
            MimeType = "application/x-texinfo"
        ElseIf fExt.Equals(".texinfo") Then
            MimeType = "application/x-texinfo"
        ElseIf fExt.Equals(".text") Then
            MimeType = "application/plain"
        ElseIf fExt.Equals(".text") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".tgz") Then
            MimeType = "application/gnutar"
        ElseIf fExt.Equals(".tgz") Then
            MimeType = "application/x-compressed"
        ElseIf fExt.Equals(".tif") Then
            MimeType = "image/tiff"
        ElseIf fExt.Equals(".tif") Then
            MimeType = "image/x-tiff"
        ElseIf fExt.Equals(".tiff") Then
            MimeType = "image/tiff"
        ElseIf fExt.Equals(".tiff") Then
            MimeType = "image/x-tiff"
        ElseIf fExt.Equals(".tr") Then
            MimeType = "application/x-troff"
        ElseIf fExt.Equals(".tsi") Then
            MimeType = "audio/tsp-audio"
        ElseIf fExt.Equals(".tsp") Then
            MimeType = "application/dsptype"
        ElseIf fExt.Equals(".tsp") Then
            MimeType = "audio/tsplayer"
        ElseIf fExt.Equals(".tsv") Then
            MimeType = "text/tab-separated-values"
        ElseIf fExt.Equals(".turbot") Then
            MimeType = "image/florian"
        ElseIf fExt.Equals(".txt") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".sql") Then
            MimeType = "text/plain"
        ElseIf fExt.Equals(".uil") Then
            MimeType = "text/x-uil"
        ElseIf fExt.Equals(".uni") Then
            MimeType = "text/uri-list"
        ElseIf fExt.Equals(".unis") Then
            MimeType = "text/uri-list"
        ElseIf fExt.Equals(".unv") Then
            MimeType = "application/i-deas"
        ElseIf fExt.Equals(".uri") Then
            MimeType = "text/uri-list"
        ElseIf fExt.Equals(".uris") Then
            MimeType = "text/uri-list"
        ElseIf fExt.Equals(".ustar") Then
            MimeType = "application/x-ustar"
        ElseIf fExt.Equals(".ustar") Then
            MimeType = "multipart/x-ustar"
        ElseIf fExt.Equals(".uu") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".uu") Then
            MimeType = "text/x-uuencode"
        ElseIf fExt.Equals(".uue") Then
            MimeType = "text/x-uuencode"
        ElseIf fExt.Equals(".vcd") Then
            MimeType = "application/x-cdlink"
        ElseIf fExt.Equals(".vcs") Then
            MimeType = "text/x-vcalendar"
        ElseIf fExt.Equals(".vda") Then
            MimeType = "application/vda"
        ElseIf fExt.Equals(".vdo") Then
            MimeType = "video/vdo"
        ElseIf fExt.Equals(".vew ") Then
            MimeType = "application/groupwise"
        ElseIf fExt.Equals(".viv") Then
            MimeType = "video/vivo"
        ElseIf fExt.Equals(".viv") Then
            MimeType = "video/vnd.vivo"
        ElseIf fExt.Equals(".vivo") Then
            MimeType = "video/vivo"
        ElseIf fExt.Equals(".vivo") Then
            MimeType = "video/vnd.vivo"
        ElseIf fExt.Equals(".vmd ") Then
            MimeType = "application/vocaltec-media-desc"
        ElseIf fExt.Equals(".vmf") Then
            MimeType = "application/vocaltec-media-file"
        ElseIf fExt.Equals(".voc") Then
            MimeType = "audio/voc"
        ElseIf fExt.Equals(".voc") Then
            MimeType = "audio/x-voc"
        ElseIf fExt.Equals(".vos") Then
            MimeType = "video/vosaic"
        ElseIf fExt.Equals(".vox") Then
            MimeType = "audio/voxware"
        ElseIf fExt.Equals(".vqe") Then
            MimeType = "audio/x-twinvq-plugin"
        ElseIf fExt.Equals(".vqf") Then
            MimeType = "audio/x-twinvq"
        ElseIf fExt.Equals(".vql") Then
            MimeType = "audio/x-twinvq-plugin"
        ElseIf fExt.Equals(".vrml") Then
            MimeType = "application/x-vrml"
        ElseIf fExt.Equals(".vrml") Then
            MimeType = "model/vrml"
        ElseIf fExt.Equals(".vrml") Then
            MimeType = "x-world/x-vrml"
        ElseIf fExt.Equals(".vrt") Then
            MimeType = "x-world/x-vrt"
        ElseIf fExt.Equals(".vsd") Then
            MimeType = "application/x-visio"
        ElseIf fExt.Equals(".vst") Then
            MimeType = "application/x-visio"
        ElseIf fExt.Equals(".vsw ") Then
            MimeType = "application/x-visio"
        ElseIf fExt.Equals(".w60") Then
            MimeType = "application/wordperfect6.0"
        ElseIf fExt.Equals(".w61") Then
            MimeType = "application/wordperfect6.1"
        ElseIf fExt.Equals(".w6w") Then
            MimeType = "application/msword"
        ElseIf fExt.Equals(".wav") Then
            MimeType = "audio/wav"
        ElseIf fExt.Equals(".wav") Then
            MimeType = "audio/x-wav"
        ElseIf fExt.Equals(".wb1") Then
            MimeType = "application/x-qpro"
        ElseIf fExt.Equals(".wbmp") Then
            MimeType = "image/vnd.wap.wbmp"
        ElseIf fExt.Equals(".web") Then
            MimeType = "application/vnd.xara"
        ElseIf fExt.Equals(".wiz") Then
            MimeType = "application/msword"
        ElseIf fExt.Equals(".wk1") Then
            MimeType = "application/x-123"
        ElseIf fExt.Equals(".wmf") Then
            MimeType = "windows/metafile"
        ElseIf fExt.Equals(".wml") Then
            MimeType = "text/vnd.wap.wml"
        ElseIf fExt.Equals(".wmlc ") Then
            MimeType = "application/vnd.wap.wmlc"
        ElseIf fExt.Equals(".wmls") Then
            MimeType = "text/vnd.wap.wmlscript"
        ElseIf fExt.Equals(".wmlsc ") Then
            MimeType = "application/vnd.wap.wmlscriptc"
        ElseIf fExt.Equals(".word ") Then
            MimeType = "application/msword"
        ElseIf fExt.Equals(".wp") Then
            MimeType = "application/wordperfect"
        ElseIf fExt.Equals(".wp5") Then
            MimeType = "application/wordperfect"
        ElseIf fExt.Equals(".wp5") Then
            MimeType = "application/wordperfect6.0"
        ElseIf fExt.Equals(".wp6 ") Then
            MimeType = "application/wordperfect"
        ElseIf fExt.Equals(".wpd") Then
            MimeType = "application/wordperfect"
        ElseIf fExt.Equals(".wpd") Then
            MimeType = "application/x-wpwin"
        ElseIf fExt.Equals(".wq1") Then
            MimeType = "application/x-lotus"
        ElseIf fExt.Equals(".wri") Then
            MimeType = "application/mswrite"
        ElseIf fExt.Equals(".wri") Then
            MimeType = "application/x-wri"
        ElseIf fExt.Equals(".wrl") Then
            MimeType = "application/x-world"
        ElseIf fExt.Equals(".wrl") Then
            MimeType = "model/vrml"
        ElseIf fExt.Equals(".wrl") Then
            MimeType = "x-world/x-vrml"
        ElseIf fExt.Equals(".wrz") Then
            MimeType = "model/vrml"
        ElseIf fExt.Equals(".wrz") Then
            MimeType = "x-world/x-vrml"
        ElseIf fExt.Equals(".wsc") Then
            MimeType = "text/scriplet"
        ElseIf fExt.Equals(".wsrc") Then
            MimeType = "application/x-wais-source"
        ElseIf fExt.Equals(".wtk ") Then
            MimeType = "application/x-wintalk"
        ElseIf fExt.Equals(".xbm") Then
            MimeType = "image/x-xbitmap"
        ElseIf fExt.Equals(".xbm") Then
            MimeType = "image/x-xbm"
        ElseIf fExt.Equals(".xbm") Then
            MimeType = "image/xbm"
        ElseIf fExt.Equals(".xdr") Then
            MimeType = "video/x-amt-demorun"
        ElseIf fExt.Equals(".xgz") Then
            MimeType = "xgl/drawing"
        ElseIf fExt.Equals(".xif") Then
            MimeType = "image/vnd.xiff"
        ElseIf fExt.Equals(".xl") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xla") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xla") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xla") Then
            MimeType = "application/x-msexcel"
        ElseIf fExt.Equals(".xlb") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlb") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xlb") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlc") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlc") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xlc") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xld ") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xld ") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlk") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlk") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xll") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xll") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xll") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlm") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlsx") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlm") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xlm") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xls") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".csv") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xls") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xls") Then
            MimeType = "application/x-msexcel"
        ElseIf fExt.Equals(".xlt") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlt") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlv") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlv") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlw") Then
            MimeType = "application/excel"
        ElseIf fExt.Equals(".xlw") Then
            MimeType = "application/vnd.ms-excel"
        ElseIf fExt.Equals(".xlw") Then
            MimeType = "application/x-excel"
        ElseIf fExt.Equals(".xlw") Then
            MimeType = "application/x-msexcel"
        ElseIf fExt.Equals(".xm") Then
            MimeType = "audio/xm"
        ElseIf fExt.Equals(".xml") Then
            MimeType = "application/xml"
        ElseIf fExt.Equals(".xml") Then
            MimeType = "text/xml"
        ElseIf fExt.Equals(".xmz") Then
            MimeType = "xgl/movie"
        ElseIf fExt.Equals(".xpix") Then
            MimeType = "application/x-vnd.ls-xpix"
        ElseIf fExt.Equals(".xpm") Then
            MimeType = "image/x-xpixmap"
        ElseIf fExt.Equals(".xpm") Then
            MimeType = "image/xpm"
        ElseIf fExt.Equals(".x-png") Then
            MimeType = "image/png"
        ElseIf fExt.Equals(".xsr") Then
            MimeType = "video/x-amt-showrun"
        ElseIf fExt.Equals(".xwd") Then
            MimeType = "image/x-xwd"
        ElseIf fExt.Equals(".xwd") Then
            MimeType = "image/x-xwindowdump"
        ElseIf fExt.Equals(".xyz") Then
            MimeType = "chemical/x-pdb"
        ElseIf fExt.Equals(".z") Then
            MimeType = "application/x-compress"
        ElseIf fExt.Equals(".z") Then
            MimeType = "application/x-compressed"
        ElseIf fExt.Equals(".zip") Then
            MimeType = "application/x-compressed"
        ElseIf fExt.Equals(".zip") Then
            MimeType = "application/x-zip-compressed"
        ElseIf fExt.Equals(".zip") Then
            MimeType = "application/zip"
        ElseIf fExt.Equals(".zip") Then
            MimeType = "multipart/x-zip"
        ElseIf fExt.Equals(".zoo") Then
            MimeType = "application/octet-stream"
        ElseIf fExt.Equals(".zsh") Then
            MimeType = "text/x-script.zsh"
        Else
            MimeType = "application/octet-stream"
        End If
        Return MimeType
    End Function

    Sub getSearchParmList(ByVal sKey As String, ByRef tgtValue As String, ByVal SearchParmList As SortedList(Of String, String))
        Dim rVal As String = ""
        If SearchParmList.ContainsKey(sKey) Then
            tgtValue = SearchParmList.Item(sKey)
        End If
    End Sub
    Sub getSearchParmList(ByVal sKey As String, ByRef tgtValue As Integer, ByVal SearchParmList As SortedList(Of String, String))
        Dim rVal As String = ""
        If SearchParmList.ContainsKey(sKey) Then
            rVal = SearchParmList.Item(sKey)
        End If
        If rVal IsNot Nothing Then
            If rVal.Length = 0 Then
                tgtValue = Nothing
            Else
                tgtValue = CInt(rVal)
            End If
        Else
            tgtValue = Nothing
        End If
    End Sub
    Sub getSearchParmList(ByVal sKey As String, ByRef tgtValue As Boolean, ByVal SearchParmList As SortedList(Of String, String))
        Dim rVal As String = ""
        If SearchParmList.ContainsKey(sKey) Then
            rVal = SearchParmList.Item(sKey)
        End If
        If rVal Is Nothing Then
            Return
        End If
        If rVal.ToUpper.Equals("TRUE") Then
            tgtValue = True
        ElseIf rVal.ToUpper.Equals("FALSE") Then
            tgtValue = False
        Else
            tgtValue = Nothing
        End If
    End Sub
    Sub getSearchParmList(ByVal sKey As String, ByRef tgtValue As Date, ByVal SearchParmList As SortedList(Of String, String))
        Dim rVal As String = ""
        If SearchParmList.ContainsKey(sKey) Then
            rVal = SearchParmList.Item(sKey)
        End If
        If rVal Is Nothing Then
            Return
        End If
        If rVal IsNot Nothing Then
            Try
                tgtValue = CDate(rVal)
            Catch ex As Exception
                rVal = Nothing
            End Try
        Else
            tgtValue = Nothing
        End If
    End Sub

End Class

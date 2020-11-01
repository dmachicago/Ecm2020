#Const RemoteOcr = 0


'To use MODI automation, set a reference in your project to the Microsoft Office Document Imaging 11.0 Type Library.
'In our case, Microsoft Office Document Imaging 12.0 Type Library.
Imports System.IO
Imports System.IO.Path
Imports System.Drawing.Imaging

Public Class clsModi
    Inherits clsDatabase

    Dim Proxy As New SVCCLCArchive.Service1Client

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility
    Dim COMP As New clsCompression

    Dim TotalOcrFailed As Integer = 0
    Dim TotalOcr As Integer = 0

    'Dim DB As New clsDatabase
    Dim FTD As New clsFILESTODELETE


    Public Sub OcrThisFile(ByVal bIsEmail As Boolean, ByVal FQN As String, ByVal SourceGuid As String, ByRef RC As Boolean)
        Dim DTE As Date = Now
        LOG.WriteToTimerLog("clsModi", "OcrThisFile", "START")
        Dim RetMsg As String = ""
Dim fExt AS String  = "" 
        Dim MyFile As New FileInfo(FQN)
        If MyFile.Exists() Then
            Try
                fExt = MyFile.Extension
                fExt = UTIL.getFileSuffix(FQN)
                If InStr(fExt, ".") = 0 Then
                    fExt = "." + fExt
                End If
            Catch ex As Exception
                Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("clsModi : OcrThisFile : 23 : " + ex.Message)
            End Try
        Else
            LOG.WriteToTimerLog("clsModi", "OcrThisFile", "END", DTE)
            Return
        End If


        Dim B As Boolean = isImageFile(fExt)


        If Not B Then
            LOG.WriteToTimerLog("clsModi", "OcrThisFile", "END", DTE)
            Return
        End If

        Dim DTE2 As Date = Now
        LOG.WriteToTimerLog("clsModi", "OcrThisFile-2", "START")
        '***************************************************
        'Dim OcrText  = OcrDocument(FQN , SourceGuid )
        '*******************************************************
#If RemoteOcr Then
        ' Open a file that is to be loaded into a byte array
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)
        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim SourceBinary() As Byte
        If (lBytes > 0) Then
            ReDim SourceBinary(lBytes - 1)
            oFileStream.Read(SourceBinary, 0, lBytes)
            oFileStream.Close()
        End If
        '*******************************************************
        Dim OriginalSize As Integer = SourceBinary.Length
        Dim CompressedBinary() As Byte = COMP.CompressBuffer(SourceBinary)
        Dim CompressedSize As Integer = CompressedBinary.Length
        '*******************************************************

        Dim FI As New FileInfo(FQN)
        Dim FileDir As String = FI.DirectoryName
        Dim FName As String = FI.Name
        FI = Nothing
        GC.Collect()

        RC = False
        Dim RetMsg As String = ""

        Proxy.OcrDocument("CONTENT", CompressedBinary, FileDir, FName, SourceGuid, gCurrUserGuidID, gMachineID, RC, RetMsg)
#Else
        Dim stringOcr As String = OcrLocal(FQN, SourceGuid, RC, RetMsg)
#End If

        '***************************************************
        If Not RC Then
            LOG.WriteToArchiveLog("ERROR OCR: clsModi/OcrThisFile-2: " + FQN + " Failed to OCR: " + RetMsg)
        Else
            If bIsEmail Then
                AppendOcrTextEmail(SourceGuid , stringOcr)
            Else
                AppendOcrText(SourceGuid , stringOcr)
            End If

        End If

        LOG.WriteToTimerLog("clsModi", "OcrThisFile-2: " + FQN, "END", DTE2)

        GC.Collect()
        GC.WaitForPendingFinalizers()
        GC.WaitForFullGCComplete()

        LOG.WriteToTimerLog("clsModi", "OcrThisFile", "END", DTE)


    End Sub

    Public Function RemoveTempImageFile(ByVal FQN AS String ) As Boolean

        Dim B As Boolean = False
        Try
            Kill(FQN)
            B = True
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("NOTICE: clsModi : RemoveTempImageFile : 43 : " + ex.Message)
        End Try

        Return B

    End Function

    Function OcrDocument(ByVal TypeSource As String, ByVal FQN As String, ByVal SourceGuid As String, ByVal UserID As String, ByVal MachineName As String, ByVal RC As Boolean, ByVal RetMsg As String, ByRef OcrText As String) As Boolean
        Dim B As Boolean = False
        Dim FileDir As String = ""
        Dim FileNameOnly As String = ""

        Dim FI As New FileInfo(FQN)
        FileDir = FI.DirectoryName
        FileNameOnly = FI.Name
        FI = Nothing
        GC.Collect()
        Dim bDeleteTempFile As Boolean = False

        Dim LL As Integer = 0

        Dim sProcessJpgAsTIF As String = "0"
        Dim NewName As String = ""

        If sProcessJpgAsTIF.Equals("1") And isJpg(FQN) Then
            NewName = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 500
            FQN = NewName
            If FQN.Trim.Length = 0 Then
                SetOcrAttributesToFail(SourceGuid) : LL = 510
                Return False
            End If
            'MarkImageCopyForDeletion(FQN ) : LL = 520
            'bDeleteTempFile = True : LL = 530
        ElseIf isTRF(FQN) = True Then : LL = 25
            Dim strRecText As String = ""
            Console.WriteLine("TRF FOund 01")
            NewName = CopyToProcessingDir(FQN) : LL = 26
            Dim BB As Boolean = OcrTRF(NewName, strRecText) : LL = 27
            If BB Then : LL = 28
                Return strRecText : LL = 29
            Else : LL = 30
                Return strRecText : LL = 31
            End If : LL = 32
        ElseIf isJpg(FQN) = True Then : LL = 33
            FQN  = ConvertToTiffTemp(FQN, ImageFormat.Png, SourceGuid ) : LL = 47
            NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
            If FQN.Trim.Length = 0 Then : LL = 48
                SetOcrAttributesToFail(SourceGuid) : LL = 49
                Return "" : LL = 50
            End If : LL = 51
            'MarkImageCopyForDeletion(FQN ) : LL = 52
            'bDeleteTempFile = True : LL = 53
        ElseIf isGif(FQN) Then
            FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 47
            NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
            If FQN.Trim.Length = 0 Then : LL = 48
                SetOcrAttributesToFail(SourceGuid) : LL = 49
                Return "" : LL = 50
            End If : LL = 51
            'MarkImageCopyForDeletion(FQN ) : LL = 52
            'bDeleteTempFile = True : LL = 53
        ElseIf isBmp(FQN) Then
            FQN  = ConvertToTiffTemp(FQN, ImageFormat.Png, SourceGuid ) : LL = 47
            NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
            If FQN.Trim.Length = 0 Then : LL = 48
                SetOcrAttributesToFail(SourceGuid) : LL = 49
                Return "" : LL = 50
            End If : LL = 51
            'MarkImageCopyForDeletion(FQN ) : LL = 52
            'bDeleteTempFile = True : LL = 53
        ElseIf isPng(FQN) = True Then : LL = 33
            NewName = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 500
            FQN = NewName
            If FQN.Trim.Length = 0 Then
                SetOcrAttributesToFail(SourceGuid) : LL = 510
                Return False
            End If
            'MarkImageCopyForDeletion(FQN ) : LL = 520
            'bDeleteTempFile = True : LL = 530
        ElseIf isTif(FQN) = True Then : LL = 46
            'FQN  = ConvertToTiffTemp(FQN, ImageFormat.Png, SourceGuid ) : LL = 47
            'NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
            If FQN.Trim.Length = 0 Then : LL = 48
                SetOcrAttributesToFail(SourceGuid) : LL = 49
                Return "" : LL = 50
            End If : LL = 51
            'MarkImageCopyForDeletion(FQN ) : LL = 52
            'bDeleteTempFile = True : LL = 53
        End If : LL = 57

#If RemoteOcr Then
        '*******************************************************
        ' Open a file that is to be loaded into a byte array
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)
        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim SourceBinary() As Byte
        If (lBytes > 0) Then
            ReDim SourceBinary(lBytes - 1)
            oFileStream.Read(SourceBinary, 0, lBytes)
            oFileStream.Close()
        End If
        '*******************************************************
        Dim OriginalSize As Integer = SourceBinary.Length
        Dim CompressedBinary() As Byte = COMP.CompressBuffer(SourceBinary)
        Dim CompressedSize As Integer = CompressedBinary.Length
        '*******************************************************


        B = Proxy.OcrDocument(TypeSource, CompressedBinary, FileDir, FileNameOnly, SourceGuid, UserID, MachineName, RC, RetMsg)
#Else
        Dim stringOcr As String = OcrLocal(FQN, SourceGuid, RC, RetMsg)
        'If SourceType.ToUpper.Equals("EMAILATTACHMENT") Then
        If stringOcr.Trim.Length > 0 Then
            OcrText = stringOcr
            B = True
            If TypeSource.ToUpper.Equals("EMAIL") Then
                AppendOcrTextEmail(SourceGuid, stringOcr)
            Else
                AppendOcrText(SourceGuid, stringOcr)
            End If
        End If
#End If

        Return B
    End Function

    Function xOcrGraphic(ByVal TypeSource As String, ByVal FQN As String, ByVal SourceGuid As String) As String

        Dim FI As New FileInfo(FQN)
        Dim FName As String = FI.Name
        FI = Nothing
        GC.Collect()

#If RemoteOcr Then
        '*******************************************************
        ' Open a file that is to be loaded into a byte array
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)
        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim SourceBinary() As Byte
        If (lBytes > 0) Then
            ReDim SourceBinary(lBytes - 1)
            oFileStream.Read(SourceBinary, 0, lBytes)
            oFileStream.Close()
        End If
        '*******************************************************
        Dim OriginalSize As Integer = SourceBinary.Length
        SourceBinary = COMP.CompressBuffer(SourceBinary)
        Dim CompressedSize As Integer = SourceBinary.Length
        '*******************************************************
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Return Proxy.OcrGraphic(SourceBinary, FName, gCurrUserGuidID, gMachineID, RC, RetMsg)
#Else
        Dim RC As Boolean = False
        Dim RetMsg As String = ""
        Dim stringOcr As String = OcrLocal(FQN, SourceGuid, RC, RetMsg)
        'If SourceType.ToUpper.Equals("EMAILATTACHMENT") Then
        If TypeSource.ToUpper.Equals("EMAIL") Then
            AppendOcrTextEmail(SourceGuid, stringOcr)
        Else
            AppendOcrText(SourceGuid, stringOcr)
        End If
#End If



    End Function

    Function OcrDocument(ByVal FQN As String, ByVal SourceGuid As String, ByVal SourceType As String) As Boolean

        If Not File.Exists(FQN) Then
            LOG.WriteToArchiveLog("NOTICE cannot OCR: " + FQN + ",it as not found.")
            Return False
        End If

        '*******************************************************
        ' Open a file that is to be loaded into a byte array
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)
        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim SourceBinary() As Byte
        If (lBytes > 0) Then
            ReDim SourceBinary(lBytes - 1)
            oFileStream.Read(SourceBinary, 0, lBytes)
            oFileStream.Close()
        End If
        '*******************************************************
        Dim OriginalSize As Integer = SourceBinary.Length
        Dim CompressedBinary() As Byte = COMP.CompressBuffer(SourceBinary)
        Dim CompressedSize As Integer = CompressedBinary.Length
        '*******************************************************

        Dim RC As Boolean = False
        Dim RetMsg As String = ""
        Dim FI As New FileInfo(FQN)
        Dim FileNameOnly As String = FI.Name
        Dim FileDir As String = FI.DirectoryName
        FI = Nothing
        GC.Collect()

#If RemoteOcr Then
        Dim B As Boolean = Proxy.OcrDocument(SourceType, CompressedBinary, FileDir, FileNameOnly, SourceGuid, gCurrUserGuidID, gMachineID, RC, RetMsg)
#Else
        Dim stringOcr As String = OcrLocal(FQN, SourceGuid, RC, RetMsg)
        If SourceType.ToUpper.Equals("EMAILATTACHMENT") Then
            AppendOcrTextEmail(SourceGuid, stringOcr)
        Else
            AppendOcrText(SourceGuid, stringOcr)
        End If
#End If


        If Not RC Then
            LOG.WriteToArchiveLog("NOTICE Failed to OCR: " + FQN + " / Source Type: " + SourceType + " / Guid: " + SourceGuid)
        End If

        Return RC
    End Function

    'Function OcrLocal(ByVal FQN As String, ByVal SourceGuid As String, ByRef RC As Boolean, ByRef RetMsg As String) As String
    '    'WDM OCR CHANGE

    '    RC = True
    '    RetMsg = ""

    '    Dim sProcessJpgAsTIF As String = System.Configuration.ConfigurationManager.AppSettings("ProcessJpgAsTIF")

    '    FQN = UTIL.ReplaceSingleQuotes(FQN)
    '    Dim xfile As String = FQN

    '    'If InStr(FQN, "9379423", CompareMethod.Text) Then
    '    '    messagebox.show("Here - 9379423")
    '    'End If

    '    Dim LL As Integer = 0
    '    Dim inputFile As String = ""
    '    Dim SuccessfullOCR As Boolean = True : LL = 1

    '    FQN  = UTIL.RemoveSingleQuotes(FQN ) : LL = 2

    '    Dim OrigFileFqn  = FQN : LL = 3
    '    Dim strRecText As String = "" : LL = 4

    '    GC.Collect() : LL = 6
    '    GC.WaitForFullGCComplete() : LL = 7

    '    Dim Doc1 As MODI.Document : LL = 8

    '    If File.Exists(FQN) Then : LL = 11
    '    Else : LL = 12
    '        LOG.WriteToArchiveLog("clsModi : OcrDocument : 100 : OCR File <" + FQN  + "> could not be found.") : LL = 15
    '        Return "" : LL = 17
    '    End If : LL = 18
    '    Try : LL = 20
    '        Dim bDeleteTempFile As Boolean = False : LL = 21
    '        Dim B As Boolean = False : LL = 22
    '        Dim NewName As String = "" : LL = 23
    '        : LL = 24
    '        Try
    '            If sProcessJpgAsTIF.Equals("1") And isJpg(FQN) Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 500
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 510
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN ) : LL = 520
    '                bDeleteTempFile = True : LL = 530
    '            ElseIf isTRF(FQN) = True Then : LL = 25
    '                NewName = CopyToProcessingDir(FQN) : LL = 26
    '                Dim BB As Boolean = OcrTRF(NewName, strRecText) : LL = 27
    '                If BB Then : LL = 28
    '                    Return strRecText : LL = 29
    '                Else : LL = 30
    '                    Return strRecText : LL = 31
    '                End If : LL = 32
    '            ElseIf isJpg(FQN) = True Then : LL = 33
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Png, SourceGuid ) : LL = 47
    '                NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
    '                If FQN.Trim.Length = 0 Then : LL = 48
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 49
    '                    Return "" : LL = 50
    '                End If : LL = 51
    '                'MarkImageCopyForDeletion(FQN ) : LL = 52
    '                bDeleteTempFile = True : LL = 53
    '            ElseIf isGif(FQN) Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 47
    '                NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
    '                If FQN.Trim.Length = 0 Then : LL = 48
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 49
    '                    Return "" : LL = 50
    '                End If : LL = 51
    '                'MarkImageCopyForDeletion(FQN ) : LL = 52
    '                bDeleteTempFile = True : LL = 53
    '            ElseIf isBmp(FQN) Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 47
    '                NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
    '                If FQN.Trim.Length = 0 Then : LL = 48
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 49
    '                    Return "" : LL = 50
    '                End If : LL = 51
    '                'MarkImageCopyForDeletion(FQN ) : LL = 52
    '                bDeleteTempFile = True : LL = 53
    '            ElseIf isPng(FQN) = True Then : LL = 33
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid ) : LL = 47
    '                NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
    '                If FQN.Trim.Length = 0 Then : LL = 48
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 49
    '                    Return "" : LL = 50
    '                End If : LL = 51
    '                'MarkImageCopyForDeletion(FQN ) : LL = 52
    '                bDeleteTempFile = True : LL = 53
    '            ElseIf isTif(FQN) = True Then : LL = 46
    '                'FQN  = ConvertToTiffTemp(FQN, ImageFormat.Png, SourceGuid ) : LL = 47
    '                NewName = FQN       '**WDM Added this fix 4/26/2010 @ 13:00
    '                If FQN.Trim.Length = 0 Then : LL = 48
    '                    SetOcrAttributesToFail(SourceGuid) : LL = 49
    '                    Return "" : LL = 50
    '                End If : LL = 51
    '                'MarkImageCopyForDeletion(FQN ) : LL = 52
    '                bDeleteTempFile = True : LL = 53
    '            End If : LL = 57
    '        Catch ex As Exception

    '        Finally

    '        End Try

    '        FQN = NewName        '**WDM Added this fix 4/26/2010 @ 13:00

    '        If FQN.Trim.Length = 0 Then : LL = 60
    '            LOG.WriteToArchiveLog("Severe Warning 200 - File zero bytes '" + xfile + "' FAILED TO OCR... skipping.") : LL = 61
    '            Return "" : LL = 62
    '        Else : LL = 63
    '            inputFile = FQN : LL = 64
    '        End If : LL = 65
    '        : LL = 66
    '        GC.Collect() : LL = 67
    '        GC.WaitForFullGCComplete() : LL = 68

    '        '****************************************************
    '        Doc1 = New MODI.Document : LL = 70
    '        '****************************************************

    '        Try
    '            Doc1.Create(inputFile) : LL = 71
    '        Catch ex As Exception
    '            LOG.WriteToArchiveLog("ERROR Severe 300.1 - File Reject '" + xfile + "' FAILED TO create OCR... skipping.") : LL = 72
    '            Return ""
    '        End Try
    '        : LL = 72
    '        Dim iCnt As Integer = Doc1.Images.Count : LL = 73
    '        : LL = 74
    '        If iCnt = 0 Then : LL = 75
    '            If iCnt = 0 Then : LL = 76
    '                Doc1.Close(False) ' clean up :LL =  77
    '                Doc1 = Nothing : LL = 78
    '                GC.Collect() : LL = 79
    '                GC.WaitForPendingFinalizers() : LL = 80
    '                Return "" : LL = 81
    '            End If : LL = 82
    '        End If : LL = 83

    '        Try
    '            '********************************************************************
    '            Doc1.OCR(MODI.MiLANGUAGES.miLANG_ENGLISH, False, True) : LL = 87
    '            '********************************************************************
    '        Catch ex As Exception
    '            : LL = 108
    '            LOG.WriteToArchiveLog("ERROR: 699a LL=" + LL.ToString + " : " + "There was an error when trying to ocr '" + FQN + "', skipping and not adding to the repository.") : LL = 109
    '            LOG.WriteToArchiveLog("ERROR: 699b: " + ex.Message) : LL = 110
    '            : LL = 111
    '            Dim FName As String = "" : LL = 112
    '            Dim FI As New FileInfo(FQN) : LL = 113
    '            FName = FI.Name : LL = 114
    '            Dim F1 As File : LL = 115
    '            Dim tFqn As String = UTIL.getTempPdfWorkingErrorDir + "\" + FName : LL = 116
    '            tFqn = tFqn.Replace("\\", "\")
    '            If F1.Exists(FQN) Then
    '                F1.Copy(FQN, tFqn, True)
    '                LOG.WriteToArchiveLog("ERROR: 699c: Copy saved in: '" + tFqn + "'.")
    '            End If

    '            F1 = Nothing
    '            SuccessfullOCR = False
    '        End Try

    '        If SuccessfullOCR = True Then : LL = 125
    '            : LL = 126
    '            If isJpg(FQN) = False And isPng(FQN) = False Then : LL = 127
    '                Try : LL = 128
    '                    Dim BX1 As Boolean = False
    '                    If BX1 Then
    '                        Doc1.SaveAs(NewName, MODI.MiFILE_FORMAT.miFILE_FORMAT_TIFF_LOSSLESS, MODI.MiCOMP_LEVEL.miCOMP_LEVEL_LOW) ' this will save the deskewed reoriented images, and the OCR text, back to the inputFile :LL =  129
    '                    End If
    '                Catch ex As Exception : LL = 130
    '                    Console.WriteLine("OcrDocument : " + ex.Message) : LL = 131
    '                End Try : LL = 132
    '                : LL = 133
    '            End If : LL = 134
    '            : LL = 135
    '            For imageCounter As Integer = 0 To (Doc1.Images.Count - 1) ' work your way through each page of results :LL =  136
    '                strRecText &= Doc1.Images(imageCounter).Layout.Text    ' this puts the ocr results into a string :LL =  137
    '            Next : LL = 138
    '            : LL = 139
    '            strRecText = strRecText.Trim : LL = 140
    '            : LL = 141
    '            'SetOcrAttributesToPass(SourceGuid) : LL = 142
    '            : LL = 143
    '            If bDeleteTempFile = True Then : LL = 144
    '                Dim MyFile As New FileInfo(FQN) : LL = 145
    '                If MyFile.Exists() Then : LL = 146
    '                    Try : LL = 147
    '                        MyFile.Delete() : LL = 148
    '                    Catch ex As Exception : LL = 149
    '                        Debug.Print(ex.Message) : LL = 150
    '                        'log.WriteToArchiveLog("clsModi : OcrDocument : 84 : " + ex.Message) :LL =  151
    '                    End Try : LL = 152
    '                    : LL = 153
    '                End If : LL = 154
    '                'Dim BB As Boolean = RemoveTempImageFile(FQN ) :LL =  155
    '                'If Not BB Then :LL =  156
    '                '    Debug.Print("Failedc to delete the TEMP image file.") :LL =  157
    '                'End If :LL =  158
    '                bDeleteTempFile = False : LL = 159
    '            End If : LL = 160
    '            'WDMXXX :LL =  161
    '            'removeTempOcrFiles() : LL = 162
    '        End If : LL = 163


    '    Catch ex As Exception
    '        xTrace(93172, "Failed to OCR <" + OrigFileFqn  + ">", "OcrDocument", ex)
    '        SetOcrAttributesToFail(SourceGuid)
    '        LOG.WriteToArchiveLog("clsModi : OcrDocument : 90a : LL = " + LL.ToString + " : Failed to OCR <" + FQN  + "> : " + ex.Message)

    '        Dim FName As String = ""
    '        Dim FI As New FileInfo(FQN)
    '        FName = FI.Name
    '        Dim F1 As File
    '        Dim tFqn As String = UTIL.getTempPdfWorkingErrorDir + "\" + FName
    '        If F1.Exists(FQN) Then
    '            Try
    '                F1.Copy(FQN, tFqn, True)
    '            Catch ex1 As Exception
    '                LOG.WriteToArchiveLog("ERROR: Could not copy '" + FQN + "' to backup error directory." + vbCrLf + ex1.Message)
    '            End Try

    '        End If

    '        F1 = Nothing
    '        'strRecText = ""


    '    Finally

    '        Try
    '            Doc1.Close(False) ' clean up
    '        Catch ex As Exception
    '            Console.WriteLine(ex.Message)
    '        End Try

    '        Try
    '            Doc1 = Nothing
    '        Catch ex As Exception
    '            Console.WriteLine(ex.Message)
    '        End Try


    '        GC.Collect()
    '        GC.WaitForPendingFinalizers()

    '        Try
    '            If File.Exists(inputFile) Then
    '                File.Delete(inputFile)
    '            End If
    '        Catch ex As Exception
    '            Console.WriteLine("Failed to delete:" + inputFile)
    '        End Try

    '    End Try

    '    'If SuccessfullOCR = False Then
    '    '    strRecText = ProcessImageAsBatch(inputFile, SourceGuid )
    '    'End If

    '    Return strRecText
    'End Function

    Function ProcessImageAsBatch(ByVal FQN AS String , ByVal SourceGuid AS String ) As String

        Dim OcrStr As String = ""
        Dim PDIR As String = UTIL.getTempProcessingDir
        Dim FileToProcess As String = ""
        Dim ConvertedFile As String = FQN  + ".TXT"
        Dim TopOcrDir As String = Application.StartupPath + "\TopOcrInstall"
        Dim CmdFile As String = UTIL.getTempProcessingDir + "\ProcessImage.bat"

        CmdFile = CmdFile.Replace("''", "'")
        TopOcrDir = TopOcrDir.Replace("''", "'")

        If Not Directory.Exists(TopOcrDir) Then
            Try
                Directory.CreateDirectory(TopOcrDir)
            Catch ex As Exception
                LOG.WriteToArchiveLog("FATAL Error ProcessImageAsBatch: Could not create temp directory: " + TopOcrDir)
            End Try
        End If

        Dim F As File
        If F.Exists(CmdFile) Then
            F.Delete(CmdFile)
        End If

        Dim MyFile As New FileInfo(FQN)
        Dim FileName As String = MyFile.Name
        FileToProcess = PDIR + "\" + FileName
        ConvertedFile = FileToProcess + ".TXT"

        ConvertedFile = PDIR + "\" + FQN + ".OCR.TXT"

        Try
            If Not F.Exists(FileToProcess) Then
                F.Copy(FQN, FileToProcess, True)
            End If
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: ProcessImageAsBatch 100: " + ex.Message + " : " + FQN)
            Return ""
        End Try

        Try
            'Dim CmdLine As String = "TopOCR.EXE, "

            Dim CmdExe As String = TopOcrDir + "\TopOcr.EXE"
            Dim ProcessLine As String = Chr(34) + FQN + Chr(34) + " " + Chr(34) + ConvertedFile + Chr(34)
            'Dim p As New Process
            'p.Start(TopOcrDir + "\TopOcr.EXE", ProcessLine)
            'p.WaitForExit()
            'p.Dispose()
            'GC.Collect()

            Dim sw As New StreamWriter(CmdFile)
            sw.WriteLine("CD\")
            sw.WriteLine("cd " + TopOcrDir)
            sw.WriteLine("topocr.exe " + ProcessLine)
            sw.Close()

            GC.Collect()
            GC.WaitForPendingFinalizers()

            ShellandWait(CmdFile)
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: ProcessImageAsBatch 200: " + ex.Message + " : " + FQN)
            Return ""
        End Try

        If F.Exists(ConvertedFile) Then
            Dim oRead As StreamReader
            Dim oFile As System.IO.File

            oRead = oFile.OpenText(ConvertedFile)
            OcrStr = oRead.ReadToEnd()

            oRead.Close()
            oRead.Dispose()
            oFile = Nothing
        Else
            LOG.WriteToNoticeLog("NOTICE: ProcessImageAsBatch 100 - No text found in " + FileToProcess + ".")
        End If
        F = Nothing

        Return OcrStr

    End Function
    Public Sub ShellandWait(ByVal ProcessPath As String)
        Dim objProcess As System.Diagnostics.Process
        Try
            objProcess = New System.Diagnostics.Process()
            objProcess.StartInfo.FileName = ProcessPath
            objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
            objProcess.Start()

            'Wait until the process passes back an exit code 
            objProcess.WaitForExit()

            'Free resources associated with this process
            objProcess.Close()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR ShellandWait 100 - " + ex.Message + vbCrLf + "Could not start process " & ProcessPath)

        End Try
    End Sub

    'Public Function OcrTRF(ByVal FQN As String, ByRef OcrText As String) As Boolean

    '    Dim miDoc As MODI.Document = Nothing
    '    Dim miWord() As MODI.Word = Nothing
    '    Dim strWordInfo As String = ""
    '    Dim i, j As Long
    '    Dim str As String = ""
    '    Dim Cont As Long = 0
    '    Dim IMG As Long = 0
    '    Dim B As Boolean = True

    '    Try
    '        miDoc = New MODI.Document
    '        miDoc.Create(FQN)
    '        str = ""
    '        Cont = 0
    '        IMG = miDoc.Images.Count - 1
    '        miDoc.OCR(MODI.MiLANGUAGES.miLANG_ENGLISH, False, True)
    '        Dim Words As String = ""
    '        For j = 0 To IMG
    '            'miDoc.Images(j).rotate(0)
    '            Windows.Forms.Application.DoEvents()
    '            For i = 0 To miDoc.Images(j).Layout.Words.count - 1
    '                ReDim Preserve miWord(Cont)
    '                miWord(Cont) = miDoc.Images(j).Layout.Words(i)
    '                Words = Words + " " + miWord(Cont).Text.ToString
    '                Cont += 1
    '            Next
    '        Next

    '        For i = 0 To miWord.Length - 1
    '            Windows.Forms.Application.DoEvents()
    '            str = str & " " & miWord(i).Text
    '        Next


    '    Catch ex As Exception
    '        LOG.WriteToArchiveLog("ERROR: OcrTRF - " + FQN + vbCrLf + ex.Message)
    '        str = ""
    '        B = False
    '    Finally
    '        miDoc.Close(False)
    '        miWord = Nothing
    '    End Try
    '    GC.Collect()
    '    GC.WaitForPendingFinalizers()
    '    OcrText = str
    '    Return B
    'End Function

    'Function AnalyzeDoc(ByVal Doc As MODI.Document) As Integer
    '    Dim B As Boolean = True
    '    If Doc Is Nothing Then
    '        B = False
    '        Return B
    '    End If
    '    Try
    '        '  MODI call for OCR 
    '        ' _MODIDocument.OCR(_MODIParameters.Language, '_MODIParameters.WithAutoRotation,              _MODIParameters.WithStraightenImage) 
    '        Doc.OCR(MODI.MiLANGUAGES.miLANG_ENGLISH, False, True)
    '        B = True
    '    Catch ex As Exception
    '        'MessageBox.Show("OCR was successful but no text was recognized")                 
    '        LOG.WriteToArchiveLog("clsModi :AnalyzeDoc - Failed analysis: " + ex.Message)
    '        B = False
    '    End Try
    '    Return B
    'End Function

    '    Function OcrDocumentLocal(ByVal FQN As String) As String
    '        '** This might be a good OCR function to use in the REMOTE OCR command line application for Server Side execution.
    '        Dim xfile As String = FQN
    '        Dim SourceGuid As String = "1234-5678-1234-5678"
    '        Dim inputFile As String = ""
    '        Dim strRecText As String = ""
    '        Dim AlwaysConvertToTempTif As Boolean = False
    '        Dim bDeleteTempFile As Boolean = False
    '        Dim Doc1 As New MODI.Document
    '        Dim FileExt As String = DMA.getFileExtension(FQN)
    '        Try

    '            Dim B As Boolean = False
    '            Dim NewName As String = ""
    '            If FileExt.ToUpper.Equals(".TIFF") Or FileExt.ToUpper.Equals("TIFF") Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            ElseIf FileExt.ToUpper.Equals(".JPEG") Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            ElseIf isTRF(FQN) = True Then
    '                'NewName = CopyToProcessingDir(FQN)
    '                Dim BB As Boolean = OcrTRF(FQN, strRecText)
    '                If Not BB Then
    '                    Dim FName As String = ""
    '                    Dim FI As New FileInfo(FQN)
    '                    FName = FI.Name
    '                    Dim F As File
    '                    Dim ErrorDir As String = UTIL.getTempPdfWorkingErrorDir
    '                    ErrorDir = ErrorDir.Replace("\\", "\")
    '                    If Not Directory.Exists(ErrorDir) Then
    '                        Directory.CreateDirectory(ErrorDir)
    '                    End If
    '                    Dim tFqn As String = ErrorDir + "\" + FName
    '                    tFqn = tFqn.Replace("\\", "\")

    '                    If Not F.Exists(tFqn) Then
    '                        F.Copy(FQN, tFqn, True)
    '                    End If
    '                    F = Nothing
    '                    Return strRecText
    '                Else
    '                    Return strRecText
    '                End If
    '            ElseIf isJpg(FQN) = True Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            ElseIf isGif(FQN) = True Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Jpeg, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            ElseIf isPng(FQN) = True Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            ElseIf isTif(FQN) = False Then
    '                FQN  = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
    '                NewName = FQN
    '                If FQN.Trim.Length = 0 Then
    '                    SetOcrAttributesToFail(SourceGuid)
    '                    Return ""
    '                End If
    '                'MarkImageCopyForDeletion(FQN )
    '                bDeleteTempFile = True
    '            End If

    '            FQN = NewName

    '            If FQN.Trim.Length = 0 Then
    '                LOG.WriteToArchiveLog("Severe warning 300  '" + xfile + "'did not OCR... returning.")
    '                Return ""
    '            Else
    '                inputFile = FQN
    '            End If

    '            Dim fType As String = UTIL.getFileSuffix(FQN)

    '            GC.Collect()
    '            GC.WaitForFullGCComplete()

    '            Doc1.Create(inputFile)
    '            Dim iCnt As Integer = Doc1.Images.Count
    '            If iCnt = 0 Then
    '                Return ""
    '            End If

    '            Doc1.OCR(MODI.MiLANGUAGES.miLANG_ENGLISH, False, True)
    '            Try
    '                Doc1.Save() ' this will save the deskewed reoriented images, and the OCR text, back to the inputFile
    '            Catch ex As Exception
    '                Console.WriteLine("Cound not save OCR'd Doc: " + ex.Message)
    '            End Try


    '            For imageCounter As Integer = 0 To (Doc1.Images.Count - 1) ' work your way through each page of results
    '                strRecText &= Doc1.Images(imageCounter).Layout.Text    ' this puts the ocr results into a string
    '            Next

    '            'SetOcrAttributesToPass(SourceGuid)
    'SKIPOUT:


    '            Return strRecText

    '        Catch ex As Exception
    '            strRecText = ""
    '            '** Failed all attempts to OCR - trash this bitch!
    '            Dim FName As String = ""
    '            Dim FI As New FileInfo(FQN)
    '            FName = FI.Name
    '            Dim F As File
    '            Dim ErrorDir As String = UTIL.getTempPdfWorkingErrorDir
    '            ErrorDir = ErrorDir.Replace("\\", "\")
    '            If Not Directory.Exists(ErrorDir) Then
    '                Directory.CreateDirectory(ErrorDir)
    '            End If
    '            Dim tFqn As String = ErrorDir + FName
    '            tFqn = tFqn.Replace("\\", "\")

    '            If Not F.Exists(tFqn) Then
    '                F.Copy(FQN, tFqn, True)
    '            End If
    '            F = Nothing

    '            'Dim NewOcrText As String = ""
    '            'NewOcrText = ProcessImageAsBatch(FQN, SourceGuid)
    '            'If NewOcrText.Length > 0 Then
    '            '    strRecText = NewOcrText
    '            '    Application.DoEvents()
    '            'Else
    '            '    'xTrace(93172, "OcrDocument: Failed to OCR <" + FQN  + ">", "OcrDocument", ex)
    '            '    SetOcrAttributesToFail(SourceGuid)
    '            '    Debug.Print(ex.Message)
    '            '    LOG.WriteToArchiveLog("clsModi : OcrDocument : 138 : Failed to OCR <" + FQN  + ">" + vbCrLf + ex.Message)
    '            '    strRecText = "Failed to OCR <" + FQN  + ">" + vbCrLf + ex.Message

    '            '    '** Failed all attempts to OCR - trash this bitch!
    '            '    Dim FName As String = ""
    '            '    Dim FI As New FileInfo(FQN)
    '            '    FName = FI.Name
    '            '    Dim F As File
    '            '    Dim ErrorDir As String = UTIL.getTempPdfWorkingErrorDir + "\ErrorImages\"
    '            '    ErrorDir = ErrorDir.Replace("\\", "\")
    '            '    If Not Directory.Exists(ErrorDir) Then
    '            '        Directory.CreateDirectory(ErrorDir)
    '            '    End If
    '            '    Dim tFqn As String = ErrorDir + FName
    '            '    tFqn = tFqn.Replace("\\", "\")
    '            '    F.Copy(FQN, tFqn, True)
    '            '    F = Nothing
    '            '    'strRecText = ""
    '            'End If
    '        Finally
    '            Doc1.Close() ' clean up            
    '            Doc1 = Nothing
    '            GC.Collect()
    '            GC.WaitForPendingFinalizers()

    '            If bDeleteTempFile = True Then
    '                Dim MyFile As New FileInfo(FQN)
    '                If MyFile.Exists() Then
    '                    Try
    '                        MyFile.Delete()
    '                    Catch ex As Exception
    '                        Debug.Print(ex.Message)
    '                        LOG.WriteToArchiveLog("clsModi :OcrDocument - Failed to delete  " + FQN + " : 132 : " + vbCrLf + ex.Message)
    '                    End Try
    '                End If
    '                MyFile = Nothing
    '                bDeleteTempFile = False
    '                GC.Collect()
    '                GC.WaitForPendingFinalizers()
    '            End If

    '        End Try
    '        Return strRecText

    '    End Function

    '    Function OcrDocumentJpg(ByVal FQN ) As String
    '        Dim XFile As String = FQN
    '        Dim SourceGuid As String = "1234-5678-1234-5678"
    '        Dim inputFile As String = ""
    '        Dim strRecText As String = ""
    '        Dim AlwaysConvertToTempTif As Boolean = False

    '        Dim Doc1 As New MODI.Document
    '        'Dim Doc2 As New MODI.Document
    '        'Dim Doc3 As New MODI.Document
    '        'Dim Doc4 As New MODI.Document

    '        Try
    '            Dim bDeleteTempFile As Boolean = False

    '            If FQN.Trim.Length = 0 Then
    '                LOG.WriteToArchiveLog("Severe warning 100 file '" + XFile + "' did not OCR... returning.")
    '                Return ""
    '            Else
    '                inputFile = FQN
    '            End If

    '            'Dim fType  = UTIL.getFileSuffix(FQN)

    '            GC.Collect()
    '            GC.WaitForFullGCComplete()

    '            Doc1.Create(inputFile)
    '            Dim iCnt As Integer = Doc1.Images.Count
    '            If iCnt = 0 Then
    '                Return ""
    '            End If

    '            'Doc1.SaveAs(FQN  + ".LossLess.TIF", MODI.MiFILE_FORMAT.miFILE_FORMAT_TIFF_LOSSLESS)
    '            Doc1.OCR(MODI.MiLANGUAGES.miLANG_ENGLISH, False, True)

    '            For imageCounter As Integer = 0 To (Doc1.Images.Count - 1) ' work your way through each page of results
    '                strRecText &= Doc1.Images(imageCounter).Layout.Text    ' this puts the ocr results into a string
    '            Next

    '            SetOcrAttributesToPass(SourceGuid)
    'SKIPOUT:
    '            If bDeleteTempFile = True Then
    '                Dim MyFile As New FileInfo(FQN)
    '                If MyFile.Exists() Then
    '                    Try
    '                        MyFile.Delete()
    '                    Catch ex As Exception
    '                        Debug.Print(ex.Message)
    '                        LOG.WriteToArchiveLog("clsModi :OcrDocument - Failed to delete  " + FQN + " : 132 : " + vbCrLf + ex.Message)
    '                    End Try
    '                End If
    '                MyFile = Nothing
    '                bDeleteTempFile = False
    '                GC.Collect()
    '                GC.WaitForPendingFinalizers()
    '            End If

    '            Return strRecText

    '        Catch ex As Exception
    '            'xTrace(93172, "OcrDocument: Failed to OCR <" + FQN  + ">", "OcrDocument", ex)
    '            SetOcrAttributesToFail(SourceGuid)
    '            Debug.Print(ex.Message)
    '            LOG.WriteToArchiveLog("clsModi : OcrDocument : 138 : Failed to OCR <" + FQN  + ">" + vbCrLf + ex.Message)
    '            strRecText = "Failed to OCR <" + FQN  + ">" + vbCrLf + ex.Message

    '            '** Failed all attempts to OCR - trash this bitch!
    '            Dim FName As String = ""
    '            Dim FI As New FileInfo(FQN)
    '            FName = FI.Name
    '            Dim F As File
    '            Dim tFqn As String = UTIL.getTempPdfWorkingErrorDir + "\" + FName
    '            F.Copy(FQN, tFqn, True)
    '            F = Nothing

    '        Finally
    '            Doc1.Close() ' clean up            
    '            Doc1 = Nothing
    '            'Doc2.Close() ' clean up            
    '            'Doc2 = Nothing
    '            'Doc3.Close() ' clean up            
    '            'Doc3 = Nothing
    '            'Doc4.Close() ' clean up            
    '            'Doc4 = Nothing
    '            GC.Collect()
    '            GC.WaitForPendingFinalizers()
    '        End Try
    '        Return strRecText


    '    End Function

    Function GenCopy(ByVal FQN) As String
        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

Dim fName AS String  = DMA.getFileName(FQN) 
Dim TempFile AS String  = WorkingDirectory + "\" + fName 
        FileCopy(FQN, TempFile)
        Return TempFile
    End Function

    Function isTif(ByVal fqn) As Boolean

Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)

        If fExt.Equals("TIF") Or fExt.Equals("TIFF") Or fExt.Equals(".TIF") Or fExt.Equals(".TIFF") Then
            Return True
        Else
            Return False
        End If

    End Function
    Function isJpg(ByVal fqn) As Boolean

Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)

        If fExt.Equals("JPG") Or fExt.Equals(".JPG") Or fExt.Equals("JPEG") Or fExt.Equals(".JPEG") Then
            Return True
        Else
            Return False
        End If

    End Function
    Function isTRF(ByVal fqn) As Boolean
Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)
        If fExt.Equals("TRF") Or fExt.Equals(".TRF") Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' 'USAGE
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Jpeg)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Emf)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Exif)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Gif)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Icon)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.MemoryBmp)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Png)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Tiff)
    ''' 'ConvertBMP("C:\test.bmp", ImageFormat.Wmf)
    ''' </summary>
    ''' <param name="BMPFullPath"></param>
    ''' <param name="imgFormat"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ConvertBMP(ByVal BMPFullPath As String, ByVal imgFormat As ImageFormat) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""


        Try
            'bitmap class in system.drawing.imaging
            Dim objBmp As New Bitmap(BMPFullPath)


            'below 2 functions in system.io.path
            sNewFile = GetDirectoryName(BMPFullPath)
            sNewFile &= GetFileNameWithoutExtension(BMPFullPath)


            sNewFile &= "." & imgFormat.ToString
            objBmp.Save(sNewFile, imgFormat)


            bAns = True 'return true on success
        Catch
            sNewFile = ""
            bAns = False 'return false on error
        End Try


        Return sNewFile


    End Function

    Public Sub ConvertFileToTiff(ByVal FQN As String, ByVal SourceGuid AS String )
        Dim S As String = ConvertToTiffTemp(FQN, ImageFormat.Tiff, SourceGuid )
        Debug.Print(S)
    End Sub

    Public Function ConvertToTiff(ByVal FQN As String, ByVal imgFormat As ImageFormat) As Boolean


        Dim bAns As Boolean
        Dim sNewFile As String


        Try
            'bitmap class in system.drawing.imaging
            Dim objBmp As New Bitmap(FQN)


            'below 2 functions in system.io.path
            sNewFile = GetDirectoryName(FQN)
            sNewFile &= GetFileNameWithoutExtension(FQN)


            sNewFile &= "." & imgFormat.ToString
            objBmp.Save(sNewFile, imgFormat)


            bAns = True 'return true on success
        Catch ex As Exception
            bAns = False 'return false on error
            LOG.WriteToArchiveLog("clsModi : ConvertToTiff : 171 : " + ex.Message)
        End Try
        Return bAns


    End Function

    ''' <summary>
    ''' Converts graphic files into the TIFF format
    ''' </summary>
    ''' <param name="FQN"></param>
    ''' <param name="imgFormat"></param>
    ''' <param name="SourceGuid"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ConvertToTiffTemp(ByVal FQN As String, ByVal imgFormat As ImageFormat, ByVal SourceGuid AS String ) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""
        Dim OrigDirName As String = ""

        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        Dim objBmp As New Bitmap(FQN)

        Try
            'bitmap class in system.drawing.imaging

            'below 2 functions in system.io.path
            OrigDirName = GetDirectoryName(FQN)
            sNewFile = GetFileNameWithoutExtension(FQN).Trim
            sNewFile &= "." & imgFormat.ToString
            sNewFile = WorkingDirectory + "\" + sNewFile
            sNewFile = sNewFile.Replace("\\", "\")
            objBmp.Save(sNewFile, imgFormat)
            bAns = True 'return true on success            
            
        Catch ex As Exception

            xTrace(77342, "Failed to convert <" + FQN + "> to TIF file.", "ConvertToTiffTemp", ex)
            bAns = False 'return false on error
            sNewFile = ""
            SetOcrAttributesToFail(SourceGuid)
            LOG.WriteToArchiveLog("clsModi : ConvertToTiffTemp : 187 : Failed to convert <" + FQN + "> to TIF file." + vbCrLf + ex.Message)
        Finally
            objBmp.Dispose()
            objBmp = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return sNewFile

    End Function

    Public Function ConvertToJPGTemp(ByVal FQN As String, ByVal imgFormat As ImageFormat, ByVal SourceGuid AS String ) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""
        Dim OrigDirName As String = ""

        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        Try
            'bitmap class in system.drawing.imaging
            Dim objBmp As New Bitmap(FQN)
            'below 2 functions in system.io.path
            OrigDirName = GetDirectoryName(FQN)
            sNewFile = GetFileNameWithoutExtension(FQN).Trim
            sNewFile &= "." & imgFormat.ToString
            sNewFile = WorkingDirectory + "\" + sNewFile
            sNewFile = sNewFile.Replace("\\", "\")
            objBmp.Save(sNewFile, imgFormat)
            bAns = True 'return true on success            
            objBmp.Dispose()
            objBmp = Nothing
        Catch ex As Exception

            bAns = False 'return false on error
            sNewFile = ""
            SetOcrAttributesToFail(SourceGuid)
            LOG.WriteToArchiveLog("clsModi : ConvertToJPGTemp : 187 : Failed to convert <" + FQN + "> to JPG file." + vbCrLf + ex.Message)

        End Try

        Return sNewFile

    End Function
    Function XgetTempImageDir() As String
        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        DMA.CreateMissingDir(WorkingDirectory )
        Return WorkingDirectory 
    End Function
    Public Function CopyToProcessingDir(ByVal FQN As String) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""
        Dim OrigDirName As String = ""

        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        Dim F As File
        sNewFile = DMA.getFileName(FQN)
        sNewFile = WorkingDirectory  + "\" + sNewFile

        Try
            If F.Exists(FQN) Then
                F.Copy(FQN, sNewFile, True)
            End If
        Catch ex As Exception
            sNewFile = ""
            LOG.WriteToArchiveLog("clsModi : ConvertToJPGTemp : 187 : Failed to convert <" + FQN + "> to JPG file." + vbCrLf + ex.Message)
        Finally
            F = Nothing
        End Try

        Return sNewFile

    End Function

    Public Function ConvertFromMemStream(ByVal FQN As String, ByVal imgFormat As ImageFormat, ByVal SourceGuid AS String ) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""
        Dim OrigDirName As String = ""
        Dim MemImage As MemoryStream

        MemImage = StreamToMemory(FQN)

        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        Try
            'bitmap class in system.drawing.imaging
            Dim objBmp As New Bitmap(MemImage)
            'below 2 functions in system.io.path
            OrigDirName = GetDirectoryName(FQN)
            sNewFile = GetFileNameWithoutExtension(FQN).Trim
            sNewFile &= ".MS.TIF"
            sNewFile = WorkingDirectory + "\" + sNewFile
            sNewFile = sNewFile.Replace("\\", "\")
            objBmp.Save(sNewFile, imgFormat)
            bAns = True 'return true on success            
            objBmp.Dispose()
            objBmp = Nothing
        Catch ex As Exception

            xTrace(77342, "Failed to convert <" + FQN + "> to TIF file.", "ConvertToTiffTemp", ex)
            bAns = False 'return false on error
            sNewFile = ""
            SetOcrAttributesToFail(SourceGuid)
            LOG.WriteToArchiveLog("clsModi : ConvertToTiffTemp : 187 : Failed to convert <" + FQN + "> to TIF file." + vbCrLf + ex.Message)

        End Try

        Return sNewFile

    End Function

    Public Function copyTiffTemp(ByVal FQN As String) As String


        Dim bAns As Boolean = False
        Dim sNewFile As String = ""
        Dim OrigDirName As String = ""

        Dim WorkingDirectory As String = UTIL.getTempProcessingDir
        WorkingDirectory = WorkingDirectory + "\ImageConvert\"
        WorkingDirectory = WorkingDirectory.Replace("\\", "\")
        If Not Directory.Exists(WorkingDirectory) Then
            Directory.CreateDirectory(WorkingDirectory)
        End If

        Try
            OrigDirName = GetDirectoryName(FQN)
            sNewFile = GetFileNameWithoutExtension(FQN).Trim
            sNewFile = DMA.getEnvVarTempDir + "\" + sNewFile + ".TIF"
            Dim F As File
            F.Copy(FQN, sNewFile)

        Catch ex As Exception
            sNewFile = ""
            LOG.WriteToArchiveLog("clsModi : copyTiffTemp : 100 : " + ex.Message)
        End Try
        Return sNewFile
    End Function

    Public Sub PDFExtract(ByVal SourceGuid As String, ByVal FQN As String, ByVal SourceType As String)

        If File.Exists(FQN) Then
            Dim B As Boolean = UTIL.ckPdfSearchable(FQN)
            If B Then
                Return
            End If
        End If

        '*******************************************************
        ' Open a file that is to be loaded into a byte array
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)
        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim SourceBinary() As Byte
        If (lBytes > 0) Then
            ReDim SourceBinary(lBytes - 1)
            oFileStream.Read(SourceBinary, 0, lBytes)
            oFileStream.Close()
        End If
        '*******************************************************
        Dim OriginalSize As Integer = SourceBinary.Length
        Dim fileBinary() As Byte = COMP.CompressBuffer(SourceBinary)
        Dim CompressedSize As Integer = fileBinary.Length
        '*******************************************************

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Dim FI As New FileInfo(FQN)
        Dim FileNameOnly As String = FI.Name
        FI = Nothing
        GC.Collect()

#If RemoteOcr Then

        Dim PDF As New clsPdfAnalyzer
        Dim PageCnt As Integer = PDF.CountPdfImages(FQN)
        frmNotify.lblPdgPages.Text = "PDF: " + PageCnt.ToString
        frmNotify.Refresh()
        PDF = Nothing '
        GC.Collect()

        Proxy.PDFExtract(SourceGuid, FileNameOnly, SourceType, fileBinary, gCurrUserGuidID, gMachineID, RC, RetMsg)
#Else
        PdfExtractLocal(SourceType, FQN, SourceGuid)
#End If

        frmNotify.lblPdgPages.Text = "*"

        If RC Then
            Return
        Else
            LOG.WriteToArchiveLog("ERROR PDFExtract : " + RetMsg)
            Return
        End If

        FQN = UTIL.ReplaceSingleQuotes(FQN)

        

    End Sub

    Sub PdfExtractLocal(ByVal SourceType As String, ByVal FQN As String, ByVal SourceGuid As String)
        '** OK - If you are here this PDF is not SEARCHABLE, we cannot take the chance that it will not be found and might contain graphics,
        '** so just process it and let the users complain.
        'If gPdfExtended = False Then
        '    Return
        'End If

        Dim AttachmentName As String = DMA.getFileName(FQN)

        If Not File.Exists(FQN) Then
            LOG.WriteToArchiveLog("ERROR: PDFExtractLocal - could not find file '" + FQN + "'.")
            Return
        End If

        '** Pass the PDF File up to the Server to process
        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)

        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length
        Dim fileData(0) As Byte

        If (lBytes > 0) Then
            ReDim fileData(lBytes - 1)
            ' Read the file into a byte array
            oFileStream.Read(fileData, 0, lBytes)
            oFileStream.Close()
        End If


        Dim PdfImages As New List(Of String)
        Dim PDF As New clsPdfAnalyzer
        Dim B As Boolean = False

        Dim SuccessfulOCR As Boolean = False
        Dim XText As String = frmReconMain.SB2.Text

        FQN = UTIL.RemoveSingleQuotes(FQN)

        Try
Dim FileExt AS String  = DMA.getFileExtension(FQN) 
            If FileExt.ToUpper.Equals(".PDF") Or FileExt.ToUpper.Equals("PDF") Then

Dim S AS String  = "" 
                If SourceType.Equals("CONTENT") Then
                    S  = "Update DataSource set OcrText = '' where SourceGuid = '" + SourceGuid  + "' "
                Else
                    S  = "Update EmailAttachment set OcrText = '' where EmailGuid = '" + SourceGuid  + "' and AttachmentName = '" + UTIL.RemoveSingleQuotes(AttachmentName) + "' "
                End If
                B = ExecuteSqlNewConn(S)
                Dim ReturnMsg As String = ""

                Dim ListOfImages As New List(Of System.Drawing.Image)
                Dim bUseListOfIMages As Boolean = False
                If bUseListOfIMages = True Then
                    ListOfImages = PDF.ExtractImages(FQN)
                End If

                Dim iCnt As Integer = PDF.ExtractImages(SourceGuid , FQN, PdfImages, ReturnMsg, False)
                If iCnt > 0 Then
                    Try
Dim tFqn AS String  = "" 
                        For II As Integer = 0 To PdfImages.Count - 1

                            frmExchangeMonitor.lblCnt.Text = "Pg: " + II.ToString + " of " + PdfImages.Count.ToString
                            frmExchangeMonitor.Refresh()

                            frmNotify2.lblMsg2.Text = "Pg: " + II.ToString + " of " + PdfImages.Count.ToString
                            frmExchangeMonitor.Refresh()

                            frmNotify.lblPdgPages.Text = "Pg: " + II.ToString + " of " + PdfImages.Count.ToString
                            frmNotify.Refresh()

                            Application.DoEvents()
                            tFqn  = PdfImages(II)
                            AttachmentName = DMA.getFileName(tFqn )
                            'DOES THE FILE EXIST HERE?
                            Dim bNewAttachmentAdded As Boolean = False
                            If SourceType.Equals("CONTENT") Then
                                frmNotify.lblPdgPages.Text = "Pg: " + II.ToString + " of " + PdfImages.Count.ToString
                                frmNotify.Refresh()
                            Else
                                frmNotify.lblPdgPages.Text = "Pg: " + II.ToString + " of " + PdfImages.Count.ToString
                                frmNotify.Refresh()

                                Dim AttachmentExists As Integer = iCount("Select count(*) from EmailAttachment where EmailGuid = '" + SourceGuid  + "' and AttachmentName = '" + UTIL.RemoveSingleQuotes(AttachmentName) + "' ")
                                If AttachmentExists = 0 Then
                                    Dim RetCode As String = getRetentionPeriodMax()
                                    Dim ispublic As String = "Y"
                                    bNewAttachmentAdded = InsertAttachmentFqn(gCurrUserGuidID, UTIL.ReplaceSingleQuotes(tFqn ), SourceGuid , UTIL.ReplaceSingleQuotes(AttachmentName ), FileExt , gCurrUserGuidID, RetCode, ispublic)
                                    If bNewAttachmentAdded = False Then
                                        GoTo SKIPX01
                                    End If
                                End If
                            End If
                            Dim OcrText As String = ""
                            Try
                                OcrText = ""

                                Dim RC As Boolean = False
                                Dim RetMsg As String = ""

                                Dim BBX As Boolean = OcrDocument(SourceType, tFqn, SourceGuid, gCurrUserGuidID, gMachineID, RC, RetMsg, OcrText)

                                If Not BBX Then
                                    SuccessfulOCR = False
                                Else
                                    SuccessfulOCR = True
                                    
                                End If

                            Catch ex As Exception
                                Console.WriteLine(ex.Message)
                                SuccessfulOCR = False
                            End Try
                            OcrText = OcrText.Replace("PDF4NET", "ECM PDX")
                            OcrText = OcrText.Replace("4NET", "ECMX")
                            If OcrText.Length > 0 Then
                                If SourceType.Equals("CONTENT") Then
                                    AppendOcrText(SourceGuid , OcrText )
                                Else
                                    AppendEmailOcrText(SourceGuid, OcrText, UTIL.RemoveSingleQuotes(AttachmentName))
                                End If
                            End If
                            'If SuccessfulOCR = False Then
                            '    OcrText = ""
                            '    OcrText = ProcessImageAsBatch(UTIL.ReplaceSingleQuotes(tFqn ), SourceGuid )
                            '    OcrText = OcrText.Replace("PDF4NET", "ECM PDX")
                            '    OcrText = OcrText.Replace("4NET", "ECMX")
                            '    If OcrText.Length > 0 Then
                            '        If SourceType.Equals("CONTENT") Then
                            '            AppendOcrText(SourceGuid , OcrText )
                            '        Else
                            '            AppendEmailOcrText(SourceGuid, OcrText, UTIL.RemoveSingleQuotes(AttachmentName))
                            '        End If
                            '    End If
                            'End If
SKIPX01:
                        Next

                    Catch ex As Exception
                        LOG.WriteToPDFLog("ERROR PDFExtractLocal 100 - " + FQN + vbCrLf + ex.Message)
                    End Try
                End If
                'FrmMDIMain.SB.Text = ""
                FQN = UTIL.ReplaceSingleQuotes(FQN)
                Dim PdfContent As String = PDF.ExtractText(FQN, False)
                If PdfContent.Trim.Length > 0 Then
                    'AppendOcrText(SourceGuid , PdfContent)
                    If SourceType.Equals("CONTENT") Then
                        AppendOcrText(SourceGuid , PdfContent)
                    Else
                        AppendEmailOcrText(SourceGuid, PdfContent, AttachmentName)
                    End If
                End If

            End If
        Catch ex As Exception
            LOG.WriteToPDFLog("ERROR: PDFExtractLocal 100 - " + ex.Message + vbCrLf + FQN)
        Finally
            PDF = Nothing
            PdfImages = Nothing
            GC.Collect()
            frmReconMain.SB2.Text = XText
        End Try

        'If SuccessfulOCR = False Then
        '    Dim OcrText As String = ""
        '    OcrText = ProcessImageAsBatch(tFqn , SourceGuid )
        '    OcrText = OcrText.Replace("PDF4NET", "ECM PDX")
        '    OcrText = OcrText.Replace("4NET", "ECMX")
        '    If OcrText.Length > 0 Then
        '        If SourceType.Equals("CONTENT") Then
        '            AppendOcrText(SourceGuid , OcrText )
        '        Else
        '            AppendEmailOcrText(SourceGuid, OcrText)
        '        End If
        '    End If
        'End If
    End Sub

    ' open a file stream for reading, and load into a memory stream
    Public Function StreamToMemory(ByVal FQN As String) As MemoryStream

        Dim input As FileStream
        Dim output As MemoryStream

        input = New FileStream(FQN, FileMode.Open, FileAccess.Read, FileShare.Read)
        output = StreamToMemory(input)
        input.Close()

        Return output
    End Function

    ' transfer contents of input stream to memory stream
    Public Function StreamToMemory(ByVal input As Stream) As IO.MemoryStream

        Dim buffer(1023) As Byte
        Dim count As Integer = 1024
        Dim output As MemoryStream

        ' build a new stream
        If input.CanSeek Then
            output = New MemoryStream(input.Length)
        Else
            output = New MemoryStream
        End If

        ' iterate stream and transfer to memory stream
        Do
            count = input.Read(buffer, 0, count)
            If count = 0 Then Exit Do
            output.Write(buffer, 0, count)
        Loop

        ' rewind stream
        output.Position = 0

        ' pass back
        Return output
    End Function
    Function isGif(ByVal fqn) As Boolean

Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)

        If fExt.Equals("GIF") Or fExt.Equals(".GIF") Then
            Return True
        Else
            Return False
        End If

    End Function
    Function isBmp(ByVal fqn) As Boolean

Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)

        If fExt.Equals("BMP") Or fExt.Equals(".BMP") Then
            Return True
        Else
            Return False
        End If

    End Function
    Function isPng(ByVal fqn) As Boolean

Dim fExt AS String  = UTIL.getFileSuffix(fqn) 
        fExt = UCase(fExt)

        If fExt.Equals("PNG") Or fExt.Equals(".PNG") Then
            Return True
        Else
            Return False
        End If

    End Function

End Class

Imports System
Imports System.IO
Imports System.Text
Imports System.Drawing
Imports System.Drawing.Imaging
Imports O2S.Components.PDF4NET
Imports O2S.Components.PDF4NET.PDFFile

Public Class clsPdfAnalyzer
    Inherits clsDatabase

    Dim LOG As New clsLogging
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility

Dim TempDir AS String  = System.IO.Path.GetTempPath 

    Function CountPdfImages(ByVal FQN As String) As Integer
        Try
            Dim doc As New PDFDocument(FQN)
            Dim I As Integer = doc.Pages.Count
            doc.Dispose()
            GC.Collect()
            GC.WaitForFullGCComplete()
            Return I
        Catch ex As Exception
            Console.WriteLine("ERROR CountPdfImages 01: " + ex.Message)
            Return 0
        End Try
        
    End Function

    Function ExtractImages(ByVal SourceGuid AS String , ByVal FQN AS String , ByRef PdfImages As List(Of String)) As Integer

        Dim fName As String = DMA.getFileName(FQN)
        Dim TempDir As String = LOG.getTempPdfWorkingDir()
        PdfImages.Clear()

        Dim RC As Integer = 0

        Try
            ' Load the PDF file.
            Dim doc As New PDFDocument(FQN)
            Try
                ' Serial number goes here
                doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6"
                Dim i As Integer = 0
                While i < doc.Pages.Count
                    ' Convert the pages to PDFImportedPage to get access to ExtractImages method.
                    Dim ip As PDFImportedPage = TryCast(doc.Pages(i), PDFImportedPage)
                    Dim images As Bitmap() = ip.ExtractImages()
                    ' Save the page images to disk, if there are any.
                    Dim j As Integer = 0
                    While j < images.Length
                        RC += 1
                        Dim NewFileName As String = TempDir  + "\ECM.PDF.Image." + SourceGuid  + "." + i.ToString + "." + j.ToString() + ".TIF"
                        images(j).Save(NewFileName, ImageFormat.Tiff)
                        PdfImages.Add(NewFileName)
                        j = j + 1
                    End While
                    i = i + 1

                    System.Windows.Forms.Application.DoEvents()

                End While
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages Message - " + ex.Message)
            Finally
                doc.Dispose()
            End Try
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 01 clsPdfAnalyzer:ExtractImages Message - " + ex.Message)
            LOG.WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages FQN - " + FQN)
            Console.WriteLine(ex.Message)
            'Console.WriteLine(ex.InnerException.ToString)
        End Try
        Return RC
    End Function

    Public Function ExtractImages(ByVal sourcePdf As String) As List(Of Image)
        Dim imgList As New List(Of Image)

        Dim raf As iTextSharp.text.pdf.RandomAccessFileOrArray = Nothing
        Dim reader As iTextSharp.text.pdf.PdfReader = Nothing
        Dim pdfObj As iTextSharp.text.pdf.PdfObject = Nothing
        Dim pdfStrem As iTextSharp.text.pdf.PdfStream = Nothing

        Try
            raf = New iTextSharp.text.pdf.RandomAccessFileOrArray(sourcePdf)
            reader = New iTextSharp.text.pdf.PdfReader(raf, Nothing)

            For i As Integer = 0 To reader.XrefSize - 1
                pdfObj = reader.GetPdfObject(i)
                If Not IsNothing(pdfObj) AndAlso pdfObj.IsStream() Then
                    pdfStrem = DirectCast(pdfObj, iTextSharp.text.pdf.PdfStream)
                    Dim subtype As iTextSharp.text.pdf.PdfObject = pdfStrem.Get(iTextSharp.text.pdf.PdfName.SUBTYPE)
                    If Not IsNothing(subtype) AndAlso subtype.ToString = iTextSharp.text.pdf.PdfName.IMAGE.ToString Then
                        Dim bytes() As Byte = iTextSharp.text.pdf.PdfReader.GetStreamBytesRaw(CType(pdfStrem, iTextSharp.text.pdf.PRStream))
                        If Not IsNothing(bytes) Then
                            Try
                                Using memStream As New System.IO.MemoryStream(bytes)
                                    memStream.Position = 0
                                    Dim img As Image = Image.FromStream(memStream)
                                    imgList.Add(img)
                                End Using
                            Catch ex As Exception
                                'Most likely the image is in an unsupported format
                                'Do nothing
                                'You can add your own code to handle this exception if you want to
                            End Try
                        End If
                    End If
                End If
            Next
            reader.Close()
        Catch ex As Exception
            log.WriteToArchiveLog("WARNING: ExtractImages 101.1 - " + ex.Message + " : " + sourcePdf)
        End Try
        Return imgList
    End Function

    Function ExtractImages(ByVal SourceGuid As String, ByVal FQN As String, ByRef PdfImages As List(Of String), ByRef ReturnMsg As String, ByVal RetainFiles As Boolean) As Integer
        If gPdfExtended = False Then
            Return 0
        End If
        'Dim xDate As Date = #8/31/2010#
        'If Now > xDate Then
        '    LOG.WriteToPDFLog("Notice: ECM Extended PDF processing evaluation expired.")
        '    Return 0
        'End If

        FQN = UTIL.ReplaceSingleQuotes(FQN)
        Dim fName As String = DMA.getFileName(FQN)
        Dim TempDir As String = UTIL.getTempProcessingDir
        TempDir = TempDir + "\PdfExtract\"
        TempDir = TempDir.Replace("\\", "\")

        If Not Directory.Exists(TempDir) Then
            Try
                Directory.CreateDirectory(TempDir)
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: Directory " + TempDir + "could be created, aborting processing of " + FQN + ".")
                xTrace(992166, "clsPdfAnalyzer/ExtractImages", "ERROR: Directory " + TempDir + "could be created, aborting processing of " + FQN + ".")
            End Try

        End If

        PdfImages.Clear()
        Dim RC As Integer = 0

        Try

            ' Load the PDF file.
            Dim doc As New PDFDocument(FQN)
            Try
                ' Serial number goes here
                doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6"
                Dim i As Integer = 0
                ReturnMsg = "Images Found in PDF = 0" + vbCrLf
                Console.WriteLine("Processing PDF Pages: " + doc.Pages.Count.ToString)
                While i < doc.Pages.Count
                    ' Convert the pages to PDFImportedPage to get access to ExtractImages method.
                    Dim ip As PDFImportedPage = TryCast(doc.Pages(i), PDFImportedPage)
                    Dim images As Bitmap() = ip.ExtractImages()
                    ' Save the page images to disk, if there are any.
                    Dim j As Integer = 0
                    frmMain.SB2.Text = "PDF Pages: " + i.ToString + " of " + doc.Pages.Count.ToString
                    Application.DoEvents()
                    While j < images.Length
                        RC += 1

                        Dim NewFileName As String = ""
                        NewFileName = TempDir + "\" + SourceGuid  + "~" + i.ToString + "." + j.ToString() + ".TIF"
                        NewFileName = NewFileName.Replace("\\", "\")
                        images(j).Save(NewFileName, ImageFormat.Tiff)

                        PdfImages.Add(NewFileName)
                        j = j + 1
                        ReturnMsg = "Images Found in PDF = " + (j + 1).ToString + vbCrLf
                    End While
                    i = i + 1
                End While

            Catch ex As Exception
                Console.WriteLine(ex.Message)
            Finally
                doc.Dispose()
            End Try
        Catch ex As Exception
            ReturnMsg += ex.Message
            LOG.WriteToPDFLog("ERROR 01 clsPdfAnalyzer:ExtractImages Message - " + ex.Message)
            LOG.WriteToPDFLog("ERROR 02 clsPdfAnalyzer:ExtractImages could not process FQN - " + FQN)
            Console.WriteLine(ex.Message)
            'Console.WriteLine(ex.InnerException.ToString)

            Dim FName1 As String = ""
            Dim FI As New FileInfo(FQN)
            FName1 = FI.Name
            Dim F As File
            Dim tFqn As String = UTIL.getTempPdfWorkingErrorDir + "\" + FName1
            LOG.WriteToPDFLog("ERROR 03 clsPdfAnalyzer:ExtractImages bad file copied to - '" + tFqn + "'.")
            F.Copy(FQN, tFqn, True)
            F = Nothing

        End Try
        Return RC
    End Function

    Function ExtractText(ByVal FQN AS String , ByVal RetainFiles As Boolean) As String

        If gPdfExtended = False Then
            Return ""
        End If

        'Dim xDate As Date = #8/31/2010#
        'If Now > xDate Then
        '    LOG.WriteToPDFLog("Notice: ECM Extended PDF processing evaluation expired.")
        '    Return ""
        'End If

        Dim fName As String = DMA.getFileName(FQN)
        TempDir = LOG.getTempEnvironDir(RetainFiles)

Dim S AS String  = "" 
        Try
            Dim pdfDoc As New PDFDocument(FQN)
            Try
                pdfDoc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6"

                Dim i As Integer = 0
                While i < pdfDoc.Pages.Count
                    Dim ip As PDFImportedPage = pdfDoc.Pages(i)
                    'Console.WriteLine("Page {0}:", i + 1)
                    Dim text As String = ip.ExtractText()
                    'Console.WriteLine(text)
                    S = S + text
                    i = i + 1
                End While
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            Finally
                pdfDoc.Dispose()
            End Try

        Catch ex As Exception
            LOG.WriteToPDFLog("ERROR 01 clsPdfAnalyzer:ExtractText Message - " + ex.Message)
            LOG.WriteToPDFLog("ERROR 02 clsPdfAnalyzer:ExtractText FQN - " + FQN)
            Console.WriteLine(ex.Message)
            Console.WriteLine(ex.InnerException.ToString)

            Dim FName1 As String = ""
            Dim FI As New FileInfo(FQN)
            FName1 = FI.Name
            Dim F As File
            Dim tFqn As String = UTIL.getTempPdfWorkingErrorDir + "\" + FName1
            F.Copy(FQN, tFqn, True)
            F = Nothing
        End Try
        Return S
    End Function

    Public Function GetParentImageProcessingFile() As String

        Return "C:\temp\"
    End Function

    Function ExtractText(ByVal FQN AS String ) As String

        'Dim xDate As Date = #8/31/2010#
        'If Now > xDate Then
        '    log.WriteToArchiveLog("Notice: ECM Extended PDF processing evaluation expired.")
        '    Return ""
        'End If

        Dim fName As String = DMA.getFileName(FQN)
        Dim TempDir As String = LOG.getTempPdfWorkingDir()

Dim S AS String  = "" 
        Try
            Dim pdfDoc As New PDFDocument(FQN)
            Try
                ' Serial number goes here
                pdfDoc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6"

                Dim i As Integer = 0
                While i < pdfDoc.Pages.Count
                    Dim ip As PDFImportedPage = pdfDoc.Pages(i)
                    'Console.WriteLine("Page {0}:", i + 1)
                    Dim text As String = ip.ExtractText()
                    'Console.WriteLine(text)
                    S = S + text
                    i = i + 1
                End While
            Catch ex As Exception
                log.WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractText Message - " + ex.Message)
            Finally
                pdfDoc.Dispose()
            End Try
        Catch ex As Exception
            log.WriteToArchiveLog("ERROR 01 clsPdfAnalyzer:ExtractText Message - " + ex.Message)
            log.WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractText FQN - " + FQN)
            Console.WriteLine(ex.Message)
            Console.WriteLine(ex.InnerException.ToString)

            '** Failed all attempts to OCR - trash this bitch!
            Dim FName2 As String = ""
            Dim FI As New FileInfo(FQN)
            FName2 = FI.Name

            Dim F As File
            Dim tFqn As String = LOG.getTempPdfWorkingErrorDir() + "\" + fName
            F.Copy(FQN, tFqn, True)
            F = Nothing
            'strRecText = ""

        End Try
        Return S
    End Function

End Class

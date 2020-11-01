Imports System.IO

Public Class frmOcrPdf

    Dim LOG As New clsLogging
    Dim CMODI As New clsModi
    Dim WorkingDirectory As String = ""
    Dim PDF As New clsPdfAnalyzer
    Dim PdfImages As New List(Of String)
    Dim UTIL As New clsUtility

    Private Sub frmOcrPdf_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed
Dim TempDir AS String  = UTIL.getTempPdfWorkingDir(False) 
    End Sub

    Private Sub frmOcrPdf_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        WorkingDirectory  = CMODI.getWorkingDirectory(gCurrUserGuidID, "CONTENT WORKING DIRECTORY")
    End Sub

    Private Sub btnSelect_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelect.Click

        OpenFileDialog1.ShowDialog()
        txtFile.Text = OpenFileDialog1.FileName

        Dim P As Process
        P.Start(txtFile.Text)

    End Sub

    Private Sub btnProcess_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        Dim TempDir As String = UTIL.getTempPdfWorkingDir(False)
        ProcessPDF()
    End Sub
    Sub ProcessPDF()

        Try
            Dim I As Integer = 9999
            Dim tGuid As String = "XXX1-XXX2-XXX3-XXX4"
Dim SourceType AS String  = ".PDF" 
            ScanPDF(tGuid , I, SourceType)

        Catch ex As Exception
            LOG.WriteToOcrLog("ERROR: frmReOcr:getOcrText 100 - " + ex.Message)
        End Try

        SB.Text = "Finished processing."

    End Sub
    Sub ScanPDF(ByVal tGuid AS String , ByVal ImageID As Integer, ByVal SourceType AS String )

Dim SourceGuid AS String  = tGuid 
Dim SourceName AS String  = Me.txtFile.Text.Trim 
Dim VersionNbr AS String  = "0" 
Dim DataSourceOwnerUserID AS String  = "" 
Dim FQN AS String  = "" 
Dim OrigFQN AS String  = "" 
        Dim StructuredData As Boolean = False
        Dim AllOcrText As String = ""

        Me.txtErrors.Text = ""
        Me.txtOcr.Text = ""

        OrigFQN  = SourceName 
        Dim ReturnMsg As String = ""
        FQN = Me.WorkingDirectory + SourceName

        Dim ListOfImages As New List(Of Image)

        Dim bUseListOfIMages As Boolean = False
        If bUseListOfIMages = True Then
            ListOfImages = PDF.ExtractImages(OrigFQN )
        End If

        Dim iCnt As Integer = PDF.ExtractImages(SourceGuid , OrigFQN , PdfImages, ReturnMsg, True)

        If ReturnMsg.Length > 0 Then
            Me.txtErrors.Text = "Images Found: " + PdfImages.Count.ToString
        End If

        Me.lbImages.Items.Clear()
        For i As Integer = 0 To PdfImages.Count - 1
            lbImages.Items.Add(PdfImages(i))
        Next

        If iCnt > 0 Then
            Try
Dim tFqn AS String  = "" 
                For II As Integer = 0 To PdfImages.Count - 1
                    frmReconMain.SB.Text = II.ToString + " of " + PdfImages.Count.ToString
                    tFqn  = PdfImages(II)
                    Dim OcrText As String = ""
                    Try
                        OcrText = CMODI.OcrDocument(tFqn , SourceGuid )
                    Catch ex As Exception
                        Console.WriteLine(ex.Message)
                    End Try
                    OcrText = OcrText.Replace("PDF4NET", "ECM PDX")
                    OcrText = OcrText.Replace("4NET", "ECMX")
                    If OcrText.Length > 0 Then
                        AllOcrText = AllOcrText + vbCrLf + "____________________________________________________" + vbCrLf
                        AllOcrText = AllOcrText + OcrText
                    End If
                Next

            Catch ex As Exception
                LOG.WriteToPDFLog("ERROR PDFXTRACT 100 - " + FQN + vbCrLf + ex.Message)
            End Try
        End If
        frmReconMain.SB.Text = ""
        Dim PdfContent As String = PDF.ExtractText(OrigFQN , True)
        If PdfContent.Trim.Length > 0 Then
            AllOcrText = AllOcrText + vbCrLf + "==========================" + vbCrLf
            AllOcrText += AllOcrText + PdfContent
        End If

        Me.txtOcr.Text = AllOcrText

        'Dim B As Boolean = False

        'If SourceType.Equals("CONTENT") Then
        '    B = CMODI.writeImageSourceDataFromDbWriteToFile(SourceGuid , FQN , False)
        'Else
        '    Dim currFileSize As Integer = DB.getEmailSize(SourceGuid )
        '    If currFileSize = 0 Then
        '        Return
        '    End If
        '    currFileSize = currFileSize + 1
        '    B = CMODI.writeEmailFromDbToFile(SourceGuid , WorkingDirectory , "PDF", currFileSize)
        'End If

        'If B Then
        '    '** Extract the OCR
        '    Try
        '        CMODI.PDFXTRACT(SourceGuid, FQN , SourceType)
        '    Catch ex As Exception
        '        LOG.WriteToOcrLog("ERROR: frmRePdf:ScanPDF - 100: " + FQN + vbCrLf + ex.Message + vbCrLf)

        '    Finally
        '        Dim F As File
        '        If F.Exists(FQN) Then
        '            F.Delete(FQN)
        '        End If
        '    End Try
        'Else
        '    LOG.WriteToOcrLog("ERROR frmRePdf:ScanPDF - Restoration failed for " + SourceName + "  to '" + FQN + "'.")
        'End If

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Private Sub lbImages_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbImages.SelectedIndexChanged
        Dim FQN As String = lbImages.SelectedItem
        Dim F As File
        If F.Exists(FQN) Then
            Me.picGraphic.Image = Image.FromFile(FQN)
        Else
            SB.Text = "File does not appear to exist."
        End If
    End Sub

    Private Sub rbNormal_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbNormal.CheckedChanged
        If rbNormal.Checked Then
            Me.picGraphic.SizeMode = PictureBoxSizeMode.Normal
            picGraphic.Refresh()
            Application.DoEvents()
        End If
        
    End Sub

    Private Sub rbResize_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbResize.CheckedChanged
        If rbResize.Checked Then
            picGraphic.SizeMode = PictureBoxSizeMode.StretchImage
            picGraphic.Refresh()
            Application.DoEvents()
        End If
    End Sub
End Class

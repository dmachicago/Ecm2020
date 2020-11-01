Imports System.IO

Public Class frmOCRdisplay

    Dim LOG As New clsLogging
    Dim DMA As New clsDma
    Dim FormLoaded As Boolean = False
    Dim UTIL As New clsUtility

    Private Sub frmOCRdisplay_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GetLocation(Me)

Dim FQN AS String  = "C:\Program Files\Adobe\Acrobat 8.0\Designer 8.0\DE\Samples\Dunning Notice\Images\Dunning Notice.tif" 
        cbFiles.Items.Add(FQN)
        FQN = "C:\Program Files\Adobe\Acrobat 8.0\Designer 8.0\EN\Samples\Tax Receipt\Images\Tax Receipt.tif"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Program Files\Adobe\Acrobat 8.0\Designer 8.0\DE\Samples\E-Ticket\Images\E-Ticket.tif"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Program Files\Adobe\Acrobat 8.0\Designer 8.0\DE\Samples\Purchase Order\Images\Purchase Order.tif"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Program Files\Adobe\Acrobat 8.0\Designer 8.0\DE\Samples\Purchase Order\Images\Purchase Order.tif"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Users\wmiller\Documents\Fax\Inbox\WelcomeFax.tif"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Users\wmiller\Documents\Docs\_timeSheet.09.09.2007.thru.0.15.07.tif"
        cbFiles.Items.Add(FQN)
        FQN = "C:\Users\wmiller\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.Outlook\7QC0YFBW\pastedGraphic (6).tiff"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Examples\WCFWFCardSpace\CardSpace\CreatingManagedCards\CS\SampleCards\images\fabrikam.jpg"
        cbFiles.Items.Add(FQN)
        FQN  = "C:\Inetpub\wwwroot\StatFileLoader\Images\Accenture01.jpg"
        cbFiles.Items.Add(FQN)
        FormLoaded = True
    End Sub
    'Sub execOcr(ByVal FQN , ByRef OcrText , ByVal SourceGuid )
    '    SB.Text = "Beginning Scan"
    '    SB.Refresh()
    '    Application.DoEvents()
    '    Dim S  = CMODI.OcrDocument(FQN )
    '    SB.Text = "Ending Scan"
    '    SB.Refresh()
    '    Application.DoEvents()
    '    'CMODI.RemoveTempImageFile(FQN )
    '    Me.rtbOcrText.Text = S
    'End Sub

    Private Sub btnOcr_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOcr.Click

        Me.Cursor = Cursors.WaitCursor
        DeleteTempImageFiles()

        Dim TempSourceGuid As String = "XXXX-XXXX-XXXX-XXXX"
        Dim CMODI As New clsModi
        Dim NewFile As String = ""
Dim FQN AS String  = "" 
        Try
            SB.Text = "Beginning to process image."
            SB.Refresh()
            Application.DoEvents()
            Reset()

            PictureBox1.Image = Nothing
Dim OcrText AS String  = "" 
            FQN  = cbFiles.Text

            NewFile = CMODI.CopyToProcessingDir(FQN)

            If NewFile.Length = 0 And FQN.Length > 0 Then
                NewFile = FQN
            End If

            Dim F As File
            If Not F.Exists(NewFile) Then
                MsgBox(NewFile + " cannot be found.")
                Me.Cursor = Cursors.Default
                Return
            End If
            F = Nothing
            If ckPageScan.Checked Then
                OcrText = CMODI.OcrDocument(NewFile)
                Me.rtbOcrText.Text = OcrText
            Else
                Dim B As Boolean = CMODI.OcrTRF(NewFile, OcrText)
                Me.rtbOcrText.Text = OcrText
            End If
            'execOcr(FQN , OcrText , TempSourceGuid)
            PictureBox1.Image = Image.FromFile(NewFile)
            SB.Text = "Completed."
            SB.Refresh()
            Application.DoEvents()
        Catch ex As Exception

            Dim NewOcrText As String = ""
            NewOcrText = CMODI.ProcessImageAsBatch(NewFile, TempSourceGuid)
            If NewOcrText.Length > 0 Then
                Me.rtbOcrText.Text = NewOcrText
                PictureBox1.Image = Image.FromFile(NewFile)
                SB.Text = "Completed."
                SB.Refresh()
                Application.DoEvents()
            Else
                SB.Text = "Error processing this image: PLEASE ENSURE OFFICE MODI IS INSTALLED."
Dim ErrMsg AS String  = "Error 843.66.3 - " + ex.Message + vbCrLf + "Please make sure Microsoft Office Document Imaging (MODI) is installed - Error processing this image.." 
                If InStr(ErrMsg, "could not find file", CompareMethod.Text) > 0 Then
                    ErrMsg += vbCrLf + vbCrLf + "And please, verify the file does exist - '" + NewFile + "'"
                    ErrMsg += vbCrLf + "Processing DIR: " + FQN
                    ErrMsg += vbCrLf + "File to Process: " + NewFile
                End If
                MsgBox(ErrMsg)
                LOG.WriteToSqlLog(ErrMsg)
            End If
            
        Finally
            CMODI = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
            'Reset()
            'Dim F As File
            'If F.Exists(NewFile) Then
            '    F.Delete(NewFile)
            'End If
            'F = Nothing
        End Try
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub cbFiles_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbFiles.SelectedIndexChanged

    End Sub

    Private Sub btnShowPic_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowPic.Click
        Try
Dim FQN AS String  = cbFiles.Text 
            PictureBox1.Image = Image.FromFile(FQN )
        Catch ex As Exception
            SB.Text = "Error displaying image."
            MsgBox("Error 843.66.5 - " + ex.Message)
        End Try

    End Sub

    Private Sub btnGetGraphic_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetGraphic.Click
        Try
            If OpenFileDialog1.ShowDialog() = DialogResult.OK Then
                Dim fName = OpenFileDialog1.FileName.ToString
                Me.cbFiles.Items.Add(fName)
                Me.cbFiles.Text = fName

Dim FQN AS String  = cbFiles.Text 
                PictureBox1.Image = Image.FromFile(FQN )
            End If
        Catch ex As Exception
            SB.Text = "Error acquiring image."
            MsgBox("Error 843.66.4 - " + ex.Message)
        End Try


    End Sub

    Private Sub rbNormal_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbNormal.CheckedChanged
        If rbNormal.Checked Then
            PictureBox1.SizeMode = PictureBoxSizeMode.Normal
            PictureBox1.Refresh()
            Application.DoEvents()
        End If
    End Sub

    Private Sub rbZoom_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbZoom.CheckedChanged
        If rbZoom.Checked Then
            PictureBox1.SizeMode = PictureBoxSizeMode.Zoom
            PictureBox1.Refresh()
            Application.DoEvents()
        End If
    End Sub

    Private Sub rbStretch_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbStretch.CheckedChanged
        If rbStretch.Checked Then
            PictureBox1.SizeMode = PictureBoxSizeMode.StretchImage
            PictureBox1.Refresh()
            Application.DoEvents()
        End If
    End Sub

    Private Sub rbCenter_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbCenter.CheckedChanged
        If rbCenter.Checked Then
            PictureBox1.SizeMode = PictureBoxSizeMode.CenterImage
            PictureBox1.Refresh()
            Application.DoEvents()
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub frmOCRdisplay_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If FormLoaded = False Then Return
        ResizeControls(Me)

    End Sub

    Private Sub ckPageScan_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckPageScan.CheckedChanged
        If ckPageScan.Checked Then
            Me.ckWordScan.Checked = False
        End If
    End Sub

    Private Sub ckWordScan_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckWordScan.CheckedChanged
        If ckWordScan.Checked Then
            ckPageScan.Checked = False
        End If
    End Sub
    Sub DeleteTempImageFiles()
        Dim CMODI As New clsModi
        Try
Dim WorkingDirectory AS String  = util.getTempPdfWorkingDir(False) 
            DMA.deleteDirectoryFiles(WorkingDirectory )
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR DeleteTempImageFiles - " + ex.Message)
        Finally
            CMODI = Nothing
        End Try
        

    End Sub
End Class

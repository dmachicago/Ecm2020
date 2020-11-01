'Imports C1.Silverlight.FlexGrid
'Imports C1.Silverlight.Pdf
'Imports C1.Silverlight.PdfViewer
Imports System.IO.IsolatedStorage
Imports System.IO
Imports Microsoft.Win32
Imports System.Windows.Media
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text
Imports iTextSharp.text.html.simpleparser
Imports System.Text
Imports System.Net
Imports System.Reflection

Partial Public Class popupExportSearchGrid
    
    Dim ISO As New clsIsolatedStorage

    Dim _UserID As String
    'Dim GVAR As App = App.Current

    Public Sub New(ByVal _dgGrid As DataGrid)
        InitializeComponent()

        dgGrid.ItemsSource = _dgGrid.ItemsSource
        _UserID = _UserID

    End Sub

    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.DialogResult = True
    End Sub

    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        Me.DialogResult = False
    End Sub

    Private Sub ChildWindow_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        Console.WriteLine("Unloaded")
    End Sub

    Private Sub btnGraphic_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnGraphic.Click
        Dim fSave As New Microsoft.Win32.SaveFileDialog
        fSave.ShowDialog()

        If fSave.SafeFileName.Length = 0 Then
            MessageBox.Show("No 'SAVE AS' file name specified, returning.")
            Return
        End If

        If fSave.SafeFileName.Length > 0 Then
            generateTiffFile(fSave.SafeFileName)
        End If

        fSave = Nothing

        GC.Collect()
    End Sub

    Private Sub btnExcel_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnExcel.Click
        Dim fSave As New Microsoft.Win32.SaveFileDialog
        fSave.ShowDialog()

        If fSave.SafeFileName.Length = 0 Then
            MessageBox.Show("No 'SAVE AS' file name specified, returning.")
            Return
        End If

        If fSave.SafeFileName.Length > 0 Then
            generateCsvFile(fSave.SafeFileName)
        End If

        fSave = Nothing

        GC.Collect()

    End Sub

    Private Sub btnHtml_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnHtml.Click
        Dim fSave As New Microsoft.Win32.SaveFileDialog
        fSave.Filter = "HTML Format (.html)| *.html"
        fSave.ShowDialog()

        If fSave.SafeFileName.Length = 0 Then
            MessageBox.Show("No SAVE AS file name specified, returning.")
            Return
        End If

        Dim FILENAME As String = fSave.SafeFileName
        generateHtmlFile(FILENAME)
        GC.Collect()
    End Sub

    Private Sub btnText_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnText.Click
        Dim fSave As New Microsoft.Win32.SaveFileDialog
        fSave.Filter = "Text Format (.txt)| *.txt"
        fSave.ShowDialog()

        If fSave.SafeFileName.Length = 0 Then
            MessageBox.Show("No SAVE AS file name specified, returning.")
            Return
        End If

        Dim FILENAME As String = fSave.SafeFileName
        generateTextFile(FILENAME)
        GC.Collect()

    End Sub

   
    Private Sub CopyStream(ByVal memStream As MemoryStream, ByVal saveStream As Stream)
        Try
            Const bufferSize As Integer = 1024 * 100
            Dim count As Integer = 0

            Dim memLength As Long = memStream.Length
            Dim buffer As Byte() = New Byte(memLength - 1) {}

            memStream.Seek(0, SeekOrigin.Begin)
            count = memStream.Read(buffer, 0, memLength)

            While count > 0
                saveStream.Write(buffer, 0, count)
                count = memStream.Read(buffer, 0, bufferSize)
            End While
        Catch ex As Exception
            Console.WriteLine("ERROR CopyStream 001x: " + ex.Message)
            'MessageBox.Show("ERROR CopyStream 001x: " + ex.Message)
        End Try
        

    End Sub

    Private Sub btnPdf_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnPdf.Click
        Dim fSave As New Microsoft.Win32.SaveFileDialog
        fSave.Filter = "PDF (.pdf)| *.pdf"
        fSave.ShowDialog()

        If fSave.SafeFileName.Length = 0 Then
            MessageBox.Show("No SAVE AS file name specified, returning.")
            Return
        End If

        Dim FILENAME As String = fSave.SafeFileName
        BuildReport(FILENAME)
        StartProcessFromIsolatedStorage(FILENAME)

    End Sub

    ''' <summary>
    ''' Builds the PDF report using itextsharp as the PDF builder.
    ''' </summary>
    ''' <param name="FQN">The Fully Qualified File name.</param>
    Sub BuildReport(FQN As String)

        Dim S As String = ""
        Dim fs As FileStream = New FileStream(FQN, FileMode.Create, FileAccess.Write, FileShare.None)
        Dim doc As New Document()
        Dim PDF As PdfWriter = PdfWriter.GetInstance(doc, fs)
        Dim C1 As Chunk = New Chunk()
        Dim P As Phrase = New Phrase()
        Dim CB As PdfContentByte = PDF.DirectContent

        P.Clear()

        doc.Open()

        Dim XTotal As Integer = 0
        Dim X As Integer = 0
        Dim Y As Integer = 0
        Dim W As Integer = 500
        Dim H As Integer = 700
        Dim LineCount As Integer = 0

        Dim iControl As Integer = 0
        Dim iLines As Integer = 0

        Dim fXBold As Font = New Font("Arial", 16)
        Dim fBold As Font = New Font("Arial", 12)
        Dim fNormal As Font = New Font("Arial", 10)

        Dim NewLine As String = ""
        Dim II As Integer = 0

        X = 30
        Y = 10
        Dim r As New Rect(X, Y, W, H)
        XTotal += X

        Dim COLS As New Dictionary(Of String, Integer)
        Dim TypeGrid As String = "CONTENT"
        Dim iCol As Integer = 0
        Dim iTgtCol As Integer = -1
        For Each COL As DataGridColumn In dgGrid.Columns
            If COL.Header.ToUpper.Equals("SUBJECT") Then
                TypeGrid = "EMAIL"
                iTgtCol = iCol
            End If
            If COL.Header.ToUpper.Equals("SOURCENAME") Then
                TypeGrid = "CONTENT"
                iTgtCol = iCol
            End If
            COLS.Add(COL.Header, iCol)
            iCol += 1
        Next

        Dim sResponse As String = ""
        Dim DR As DataGridRow = Nothing

        NewLine = TypeGrid + " Search List " + Now.ToString
        CB.LineTo(5, 50)
        CB.Stroke()
        C1.Append(NewLine)        

        NewLine = "__________________________________________________________________"
        C1.Append(NewLine)
        doc.Add(C1)

        Y += 20

        Dim iCnt As Integer = 0
        Dim sTitle As String = ""

        Dim iRow As Integer = 0
        iCol = 0
        For Each DR In dgGrid.Items
            iCnt += 1
            iCol = 0
            For Each sKey As String In COLS.Keys
                iCol += 1
                If iCol = 1 Then
                    X = 30
                    Y += 15
                    r.X = X
                    r.Y = Y
                    sTitle = sKey + " / " + DR.Item(sKey).ToString + " : Item " + iCnt.ToString + " of " + dgGrid.Items.Count.ToString
                    NewLine = "__________________________________________________________________"
                    P.Clear()
                    P.Add(NewLine)
                    doc.Add(P)
                    P.Clear()
                Else
                    X = 75
                    Y += 15
                    r.X = X
                    r.Y = Y
                    Dim tVal As String = DR.Item(sKey).ToString
                    If tVal.Trim.Length > 65 Then
                        tVal = Mid(tVal, 1, 65) + "..."
                    End If
                    If tVal.Trim.Length > 0 Then
                        P.Clear()
                        NewLine = sKey + " / " + tVal
                        P.Add(NewLine)
                        doc.Add(P)
                        P.Clear()
                    End If
                End If
            Next
        Next


        X = 100
        Y += 25
        r.X = X
        r.Y = Y

        P.Clear()
        NewLine = "Print Date: " + Now.ToShortDateString
        P.Add(NewLine)
        doc.Add(P)
        P.Clear()
        doc.Add(P)

        LineCount += 1

        doc.Close()

        Dim isoStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)

        Using isoStream As IsolatedStorageFileStream = New IsolatedStorageFileStream(FQN, FileMode.CreateNew, isoStore)
            Using writer As StreamWriter = New StreamWriter(isoStream)
                writer.WriteLine(doc)                
            End Using
        End Using

    End Sub

    Private Sub btnOpenFile_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnOpenFile.Click

        'PdfViewer.Visibility = Visibility.Collapsed

    End Sub

    Protected Sub generateHtmlFile(FQN As String)
        dgGrid.SelectAllCells()
        dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader

        ApplicationCommands.Copy.Execute(Nothing, dgGrid)
        dgGrid.UnselectAllCells()

        Dim result As String = Clipboard.GetData(DataFormats.Html).ToString

        Clipboard.Clear()

        Dim file As System.IO.StreamWriter = New System.IO.StreamWriter(FQN)
        file.WriteLine(result)
        file.Close()
    End Sub

    Protected Sub generateCsvFile(FQN As String)
         dgGrid.SelectAllCells()
        dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader

        ApplicationCommands.Copy.Execute(Nothing, dgGrid)
        dgGrid.UnselectAllCells()

        Dim result As String = Clipboard.GetData(DataFormats.CommaSeparatedValue).ToString

        Clipboard.Clear()

        Dim file As System.IO.StreamWriter = New System.IO.StreamWriter(FQN)
        file.WriteLine(result)
        file.Close()
    End Sub
    Protected Sub generateTextFile(FQN As String)
        dgGrid.SelectAllCells()
        dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader

        ApplicationCommands.Copy.Execute(Nothing, dgGrid)
        dgGrid.UnselectAllCells()

        Dim result As String = Clipboard.GetData(DataFormats.UnicodeText).ToString

        Clipboard.Clear()

        Dim file As System.IO.StreamWriter = New System.IO.StreamWriter(FQN)
        file.WriteLine(result)
        file.Close()
    End Sub
    Protected Sub generateTiffFile(FQN As String)
        dgGrid.SelectAllCells()
        dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader

        ApplicationCommands.Copy.Execute(Nothing, dgGrid)
        dgGrid.UnselectAllCells()

        Dim result2 As String = Clipboard.GetData(DataFormats.Bitmap).ToString
        Dim result As String = Clipboard.GetData(DataFormats.Tiff).ToString

        Clipboard.Clear()

        Dim file As System.IO.StreamWriter = New System.IO.StreamWriter(FQN)
        file.WriteLine(result)
        file.Close()
    End Sub

    Public Sub StartProcessFromIsolatedStorage(isolatedFilePath As String)
        'System.IO.IsolatedStorage.IsolatedStorageFile isolatedStorageFile = System.IO.IsolatedStorage.IsolatedStorageFile.GetUserStoreForAssembly();
        Dim isolatedStorageFile As System.IO.IsolatedStorage.IsolatedStorageFile = System.IO.IsolatedStorage.IsolatedStorageFile.GetUserStoreForDomain()

        If Not isolatedStorageFile.FileExists(isolatedFilePath) Then
            Throw New FileNotFoundException(isolatedFilePath)
        End If

        Dim isolatedStorageType As Type = isolatedStorageFile.[GetType]()
        Dim piRootDirectory As System.Reflection.PropertyInfo = isolatedStorageType.GetProperty("RootDirectory", System.Reflection.BindingFlags.NonPublic Or System.Reflection.BindingFlags.Instance)
        Dim fullPath As String = System.IO.Path.Combine(piRootDirectory.GetValue(isolatedStorageFile, Nothing).ToString(), isolatedFilePath)
        System.Diagnostics.Process.Start(fullPath)
    End Sub

End Class

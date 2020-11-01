Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Microsoft.Office.Interop

Public Class clsDLMaster

    Function DownLoadSelectedItems(dgContent As DataGrid, DGEmail As DataGrid) As String
        Dim msg As String = ""
        If dgContent.SelectedItems.Count > 0 Then
            msg += DownLoadSelectedContent(dgContent)
        End If
        If DGEmail.SelectedItems.Count > 0 Then
            msg += DownLoadSelectedEmail(DGEmail)
        End If
        Return msg
    End Function

    Function DownLoadSelectedContent(DG As DataGrid) As String

        Dim msg As String = ""
        Dim DS As New DS_CONTENT
        Dim ColumnValue As Object
        Dim ListOfGuids As List(Of String) = New List(Of String)
        Dim View As DataView = TryCast(DG.ItemsSource, DataView)

        For Each ViewRow As DataRowView In DG.SelectedItems
            Try
                If View IsNot Nothing Then
                    'Dim ViewRow As DataRowView = View.Item(DG.SelectedIndex)
                    ColumnValue = ViewRow.Item("SourceGuid")  'or ViewRow.Item(0) for positional value.
                    Dim SourceGuid As String = ColumnValue.ToString
                    ListOfGuids.Add(SourceGuid)
                End If
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        Next

        msg += DownloadContent(ListOfGuids)

        Return msg

    End Function

    Function DownLoadSelectedEmail(DG As DataGrid) As String

        Dim msg As String = ""
        Dim DS As New DS_CONTENT
        Dim ColumnValue As Object
        Dim ListOfGuids As List(Of String) = New List(Of String)
        Dim View As DataView = TryCast(DG.ItemsSource, DataView)

        For Each ViewRow As DataRowView In DG.SelectedItems
            Try
                If View IsNot Nothing Then
                    'Dim ViewRow As DataRowView = View.Item(DG.SelectedIndex)
                    ColumnValue = ViewRow.Item("EmailGuid")  'or ViewRow.Item(0) for positional value.
                    Dim CurrentGuid As String = ColumnValue.ToString
                    ListOfGuids.Add(CurrentGuid)
                End If
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        Next

        msg += DownloadEmail(ListOfGuids)

        Return msg

    End Function

    Function DownloadContent(ListOfGuids As List(Of String)) As String

        Dim msg As String = "* "
        Dim CS As String = gFetchCS()
        Dim SourceName As String = ""
        Dim SourceImage As Byte() = Nothing
        Dim FileLength As Integer = 0

        For Each SourceGuid As String In ListOfGuids
            Dim s As String = "Select SourceName, FileLength, SourceImage from DataSource where SourceGuid = '" + SourceGuid + "'"
            Using CONN As New SqlConnection(CS)
                CONN.Open()
                Using command As New SqlCommand(s, CONN)
                    Using rsData As SqlDataReader = command.ExecuteReader()
                        If rsData.HasRows Then
                            rsData.Read()
                            SourceName = rsData.GetValue(0)
                            FileLength = rsData.GetInt32(1)

                            Dim myBytes(FileLength) As Byte
                            Dim bytesRead As Long = rsData.GetBytes(rsData.GetOrdinal("SourceImage"), 0, myBytes, 0, FileLength)

                            Dim fs As FileStream = New FileStream(gDownloadDIR + SourceName, FileMode.Create)
                            fs.Write(myBytes, 0, Convert.ToInt32(bytesRead))
                            fs.Close()
                            Console.WriteLine(bytesRead & " bytes downloaded from file " + SourceName)
                            msg += SourceName + Environment.NewLine
                        Else
                            Console.WriteLine("ERROR: File " + SourceName + " failed to download.")
                            msg += "ERROR: Failed " + SourceName
                        End If
                    End Using
                End Using
            End Using


        Next
        Return msg
    End Function

    Sub displayEmail(tDict As Dictionary(Of String, String))
        Dim oApp As Microsoft.Office.Interop.Outlook.Application
        Dim oEmail As Outlook.MailItem
        oApp = New Outlook.Application
        oEmail = oApp.CreateItem(Outlook.OlItemType.olMailItem)
        With oEmail
            .To = tDict("to")
            .CC = tDict("cc")
            .BCC = tDict("bcc")
            .Subject = tDict("subject")
            .BodyFormat = Outlook.OlBodyFormat.olFormatPlain
            .Body = tDict("body")
            '.Importance = olImportanceHigh
            '.ReadReceiptRequested = True
            '.Attachments.Add "C:\Cat.bmp", olByValue
            .Recipients.ResolveAll()
            .Save()
            .Display() 'Show the email message and allow for editing before sending
            '.Send 'You can automatically send the email without displaying it.
        End With
        oEmail = Nothing
        oApp.Quit()
        oApp = Nothing
    End Sub

    Function DownloadEmail(ListOfGuids As List(Of String)) As String

        Dim msg As String = "DOWNLOADED EMAILS: " + Environment.NewLine

        Dim Subject As String = ""
        Dim SentTo As String = ""
        Dim SourceTypeCode As String = ""
        'Dim EmailImage As Byte() = Nothing
        Dim RowID As Integer = 0
        Dim ImageBytes As Integer = 0
        Dim SourceName As String = ""
        Dim CS As String = gFetchCS()
        Dim S As String = ""
        Dim b As Boolean = False

        For Each EmailGuid As String In ListOfGuids
            S = "Select ShortSubj, SentTo, [EmailGuid], SourceTypeCode, RowID, DATALENGTH([EmailImage]) As ImageBytes,  [EmailImage] 
                    From [dbo].[Email] 
                    Where EmailGuid = '" + EmailGuid + "'"

            'Dim CONN As New SqlConnection(CS)
            Using CONN As New SqlConnection(CS)
                CONN.Open()
                Using command As New SqlCommand(S, CONN)
                    Using rsData As SqlDataReader = command.ExecuteReader()
                        If rsData.HasRows Then
                            rsData.Read()
                            Subject = rsData.GetValue(0)
                            SentTo = rsData.GetValue(1)
                            SourceTypeCode = rsData.GetValue(3)
                            RowID = rsData.GetInt32(4)
                            Dim strImageBytes = rsData.GetValue(5).ToString

                            ImageBytes = Convert.ToInt32(strImageBytes)

                            Dim myBytes(ImageBytes) As Byte
                            Dim bytesRead As Long = rsData.GetBytes(rsData.GetOrdinal("EmailImage"), 0, myBytes, 0, ImageBytes)

                            If (Subject.Trim.Length.Equals(0)) Then
                                SourceName = SentTo + "-" + RowID.ToString
                            Else
                                SourceName = Subject + "-" + RowID.ToString
                            End If

                            SourceName = SourceName.Replace(" ", "-")
                            SourceName = SourceName.Replace(":", ".")
                            SourceName += "." + SourceTypeCode

                            Dim BB As Boolean = FilenameIsOK(SourceName)
                            If Not BB Then
                                SourceName = "EMail-" + RowID.ToString + "." + SourceTypeCode
                            End If
                            If Not Directory.Exists(gDownloadDIR) Then
                                Directory.CreateDirectory(gDownloadDIR)
                            End If
                            Using fs As FileStream = New FileStream(gDownloadDIR + SourceName, FileMode.Create)
                                fs.Write(myBytes, 0, Convert.ToInt32(bytesRead))
                            End Using
                            'fs.Close()
                            msg += SourceName + Environment.NewLine
                        Else
                            Console.WriteLine("ERROR: Email '" + SourceName + "' failed to download.")
                            msg += "ERROR: Failed " + SourceName
                        End If
                    End Using
                End Using
            End Using
        Next

        Return msg
    End Function

    Function FilenameIsOK(ByVal fileName As String) As Boolean
        Return Not (Path.GetFileName(fileName).Intersect(Path.GetInvalidFileNameChars()).Any() OrElse Path.GetDirectoryName(fileName).Intersect(Path.GetInvalidPathChars()).Any())
    End Function

End Class
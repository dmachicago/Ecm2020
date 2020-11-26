Imports System.Runtime.InteropServices
Imports Microsoft.Office.Interop.Word
'Imports Microsoft.Office.Core
Imports Microsoft.Office.Interop
Imports Microsoft.Office.Interop.Excel


Public Class clsMsWord
    Dim ATTR As New clsATTRIBUTES
    Dim sAttr As New clsSOURCEATTRIBUTE
    Dim DBARCH As New clsDatabaseARCH
    Dim ddebug As Boolean = False
    Dim DFLT As New clsValidateCodes
    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility
    Dim Office2007 As Int32 = 1

    ''' Captures the metadata embedded within a word document for both 2003 and 2007
    Public Sub getWordDocMetaData(ByVal FQN As String)


        Dim oWord As Microsoft.Office.Interop.Word.Application
        Dim oDoc As Microsoft.Office.Interop.Word.Document
        Dim oBuiltInProps As Object = Nothing
        Dim oCustomProps As Object = Nothing

        'Dim oProp As DocumentProperty
        Dim oProp As Object

        'Start Word and open the document template.
        oWord = New Word.Application
        oWord.Visible = True
        'oDoc = oWord.Documents.Add
        oDoc = oWord.Documents.Open(FQN)

        Try
            'Get the Built-in Document Properties collection.
            oBuiltInProps = oDoc.BuiltInDocumentProperties
            Dim strValue As String = ""
            'Dim Prop As DocumentProperty
            Dim Prop As Object
            For Each oProp In oDoc.BuiltInDocumentProperties
                Debug.Print(oProp.Name & " = ")
                Debug.Print(oProp.Value)
            Next
        Catch ex As Exception
            MessageBox.Show("Error 8273.1 : Could not open document '" + FQN + "'" + Environment.NewLine + ex.Message)
            LOG.WriteToArchiveLog("clsMsWord : getMetaData : 17 : " + ex.Message)
        End Try
    End Sub
    Public Sub initWordDocMetaData(ByVal FQN As String, ByVal DocGuid As String, ByVal OriginalFileType As String)

        Dim fName As String = DMA.getFileName(FQN)

        If fName.Trim.Length > 0 Then
            If Mid(fName, 1, 1) = "~" Then
                LOG.WriteToArchiveLog("initWordDocMetaData: " + fName + ", appears to be a temp file - no metadata available.")
                Return
            End If
        End If

        Dim bExit As Boolean = False
        Dim SS As String = ""
        Dim B As Boolean = False

        '** Dale Added this 7/14/2009 to stop deletion of already existing metadata.
        Dim DoThis As Boolean = False
        If DoThis = True Then
            SS = "delete FROM [SourceAttribute] where [SourceGuid] = '" + DocGuid + "'"
            B = DBARCH.ExecuteSqlNewConn(SS, False)
        End If

        Dim oWord As Microsoft.Office.Interop.Word.Application
        Dim oDoc As Microsoft.Office.Interop.Word.Document
        Dim oBuiltInProps As Object = Nothing
        Dim oCustomProps As Object = Nothing

        Try
            'Dim oProp As DocumentProperty
            'Start Word and open the document template.
            oWord = CreateObject("Word.Application")
            oWord.Visible = False
            'oDoc = oWord.Documents.Add
            oDoc = oWord.Documents.Open(FQN)
            If ddebug Then Debug.Print(oDoc.FullName)
            'Make the application invisible
            oWord.Visible = False
        Catch ex As Exception
            If ddebug Then Debug.Print("Error 23977.1 : ABORT - Document Issue: '" + FQN + "'" + Environment.NewLine + ex.Message)
            DBARCH.xTrace(23977, SS, "Error 23977 : Could not process WORD document '" + FQN + "'" + Environment.NewLine + ex.Message)
            LOG.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 32 : " + ex.Message + Environment.NewLine + FQN)
            Return
        End Try


        Try
            'Get the Built-in Document Properties collection.            
            oBuiltInProps = oDoc.BuiltInDocumentProperties
            Dim strValue As String = oBuiltInProps.Item("Author").Value
            If ddebug Then Debug.Print(strValue)
            strValue = oBuiltInProps.Item("Subject").Value
            If ddebug Then Debug.Print(strValue)
            strValue = oBuiltInProps.Item(2).Value
            If ddebug Then Debug.Print(strValue)

            'For Each O As Object In oBuiltInProps
            '    Try
            '        Console.WriteLine(O.name + " : " + O.value.ToString)
            '    Catch ex As Exception
            '        Console.WriteLine(ex.Message)
            '    End Try
            'Next

            For i As Integer = 1 To 34

                Try
                    Dim strValue2 As String = ""
                    If oBuiltInProps.Item(i).name = Nothing Then
                        strValue = ""
                    Else
                        strValue = oBuiltInProps.Item(i).name
                    End If

                    If oBuiltInProps.Item(i).Value = Nothing Then
                        strValue2 = ""
                    Else
                        strValue2 = oBuiltInProps.Item(i).Value.ToString
                    End If

                    If ddebug Then Console.WriteLine(i.ToString + " : " + strValue + ":" + strValue2)
                    If strValue.Length > 0 And strValue2.Length > 0 Then
                        sAttr.setAttributename(strValue)
                        sAttr.setAttributevalue(strValue2)
                        sAttr.setSourceguid(DocGuid)
                        sAttr.setDatasourceowneruserid(gCurrUserGuidID)
                        sAttr.setSourcetypecode(OriginalFileType)
                        Dim bb As Boolean = DBARCH.ItemExists("Attributes", "AttributeName", strValue, "C")
                        If bb = False Then
                            DFLT.addDefaultAttributes(strValue, "", "Auto added: initWordDocMetaData", "MS Word")
                        End If
                        Dim iCnt As Integer = sAttr.cnt_PK35(strValue, gCurrUserGuidID, DocGuid)
                        If iCnt > 0 Then
                            Dim WC As String = sAttr.wc_PK35(strValue, gCurrUserGuidID, DocGuid)
                            sAttr.Update(WC)
                        Else
                            sAttr.Insert()
                        End If

                    End If
                Catch ex As Exception
                    If ddebug Then Console.WriteLine("Error 23977.1 : " + strValue + " : " + ex.Message)
                    'DBARCH.xTrace(23946, "Error 23977.1 : ABORT - Document Issue.", "Failed to add Metedata for: " + FQN, ex)
                    'log.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 58 : " + ex.Message)
                End Try
            Next


        Catch ex As Exception
            If ddebug Then Debug.Print("Error 8273.1 : Could not open document '" + FQN + "'" + Environment.NewLine + ex.Message)
            DBARCH.xTrace(23947, "InitWordDocMetaData", "ABORT - Document Issue: Could not open document '" + FQN + "' : " + ex.Message.ToString)
        Finally
            Try
                'oDoc.Application.Quit(False, Nothing, Nothing)
                oDoc.Close(False, Nothing, Nothing)
            Catch ex As Exception
                Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("ERROR: clsMsWord : initWordDocMetaData : 65a : " + ex.Message)
            End Try

            Try
                oWord.Application.Quit(False, Nothing, Nothing)
                oWord = Nothing
                oCustomProps = Nothing
                oBuiltInProps = Nothing
                oDoc = Nothing
                oWord = Nothing
            Catch ex As Exception
                Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("ERROR: clsMsWord : initWordDocMetaData : 65b : " + ex.Message)
            End Try

        End Try


    End Sub
    Public Sub initExcelMetaData(ByVal FQN As String, ByVal DocGuid As String, ByVal OriginalFileType As String)
        'Open the workbook\

        If Office2007 = 0 Then
        Else
            LOG.WriteToArchiveLog("WARNING: METADATA CAPTURE DOES NOT WORK IN OFFICE 2003: " + FQN)
            Return
        End If

        Dim LL As Integer = 0
        LL = 1
        'Dim oExcelApp As New Excel.Application 'remove this, you're setting them to nothing= New Excel.Application
        Dim oExcelApp As New Excel.Application 'remove this, you're setting them to nothing= New Excel.Application
        LL = 2
        'Dim oWorkbook As New Microsoft.Office.Interop.Excel.Workbook 'remove this, you're setting them to nothing= Nothing
        Dim oWorkbook As Microsoft.Office.Interop.Excel.Workbook 'remove this, you're setting them to nothing= Nothing
        LL = 3
        Dim oBuiltInProps As Object = Nothing
        LL = 4

        Try

            Dim strValue As String = ""

            '#If Office2007 Then
            oWorkbook = oExcelApp.Workbooks.Open(FQN, , False)
            LL = 5
            oBuiltInProps = oWorkbook.BuiltinDocumentProperties
            Dim II As Integer = 34

            For i As Integer = 1 To II
                Try
                    LL = 6
                    Dim strValue2 As String = ""
                    If oBuiltInProps.item(i).name = Nothing Then
                        strValue = ""
                    Else
                        strValue = oBuiltInProps.Item(i).name.ToString
                    End If

                    If oBuiltInProps.Item(i).Value = Nothing Then
                        strValue2 = ""
                    Else
                        strValue2 = oBuiltInProps.Item(i).Value.ToString
                    End If
                    If ddebug Then Debug.Print(i.ToString + ":" + strValue + ":" + strValue2)
                    LL = 7
                    If strValue.Length > 0 And strValue2.Length > 0 Then
                        sAttr.setAttributename(strValue)
                        sAttr.setAttributevalue(strValue2)
                        sAttr.setSourceguid(DocGuid)
                        sAttr.setDatasourceowneruserid(gCurrUserGuidID)
                        sAttr.setSourcetypecode(OriginalFileType)
                        LL = 8
                        Dim iCnt As Integer = sAttr.cnt_PK35(strValue, gCurrUserGuidID, DocGuid)
                        LL = 9
                        If iCnt = 0 Then
                            sAttr.Insert()
                        Else
                            Dim WC As String = sAttr.wc_PK35(strValue, gCurrUserGuidID, DocGuid)
                            sAttr.Update(WC)
                        End If
                    End If
                    LL = 10
                Catch ex As Exception
                    'If ddebug Then

                    'End If
                    Console.WriteLine("NOTICE 23988.1 : ABORT - Document Issue: '" + FQN + "'" + Environment.NewLine + ex.Message)
                    'Return
                End Try

            Next
            If Not oBuiltInProps Is Nothing Then
                oBuiltInProps = Nothing
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTIFICATION: clsMsWord : initExcelMetaData : 94 -No metadata available- : LL = " + LL.ToString + " : " + FQN + " :ErrMsg- " + ex.Message + Environment.NewLine + FQN)
        Finally
            oExcelApp.Application.Quit()
            oExcelApp.Quit()
            oExcelApp = Nothing
            Dim PP As Process
            'For Each PP In Process.GetProcesses
            '    Console.WriteLine(PP)
            'Next
            For Each RunningProcess In Process.GetProcessesByName("Excel")
                RunningProcess.Kill()
            Next
        End Try
    End Sub
    Public Sub listProps(ByVal FQN AS String )
        If Office2007 = 1 Then
            Dim oWord As Microsoft.Office.Interop.Word.Application
            Dim oDoc As Microsoft.Office.Interop.Word.Document
            Dim oBuiltInProps As Object
            Dim oCustomProps As Object
            'Dim oProp As Object
            Dim strValue As String


            'Create an instance of Word and make it visible.
            oWord = CreateObject("Word.Application")
            oWord.Visible = True
            'Create a new document
            oDoc = oWord.Documents.Open(FQN)


            'Get the Built-in Document Properties collection.
            oBuiltInProps = oDoc.BuiltInDocumentProperties
            'Get the value of the Author property and display it
            strValue = oBuiltInProps.Item("Author").Value
            MessageBox.Show("The author of this document is " & strValue)


            'Set the value of the Subject property.
            strValue = oBuiltInProps.Item("Subject").Value


            'Get the Custom Document Properties collection.
            'oCustomProps = oDoc.CustomDocumentProperties


            'Display a message box to give the user a chance to verify the
            'properties.
            MsgBox("Select Properties from the File menu " _
                   & "to view the changes." & Chr(10) _
                   & "Select the Summary tab to view " _
                   & "the Subject and the Custom tab to view the Custom " _
                   & "properties.", MsgBoxStyle.Information, _
                   "Check File Properties")


            'Clean up. We'll leave Word running.
            oCustomProps = Nothing
            oBuiltInProps = Nothing
            oDoc = Nothing
            oWord = Nothing
        Else
            LOG.WriteToArchiveLog("WARNING: OBJECT PROPERTIES DO NOT WORK IN OFFICE 2003.")
        End If
    End Sub
End Class

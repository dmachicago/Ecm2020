Imports Outlook = Microsoft.Office.Interop.Outlook
Imports System.Reflection
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Configuration.AppSettingsReader
Imports System.Configuration.ConfigurationSettings
Imports System.Security.Principal


Public Class clsRecon

    'Dim DBARCH As New clsDatabaseARCH
    Dim EMAIL As New clsEMAIL
    Dim RECIPS As New clsRECIPIENTS
    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Public Function OutlookFolderNames() As String
        Try
            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
'            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' Debug.Print sArray(ictr)
            'Next
            '*********************************************************
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook._NameSpace
            Dim oParentFolder As Outlook.MAPIFolder
            Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0


            oOutlook = New Outlook.Application()
            oMAPI = oOutlook.GetNamespace("MAPI")
Dim MailboxName AS String  = "Personal Folders" 
            oParentFolder = oMAPI.Folders.Item(MailboxName)


            ReDim Preserve sArray(0)


            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        Debug.Print(oParentFolder.Folders.Item(i).Name)
                    End If
                Next i
            Else
                sArray(0) = oParentFolder.Name
            End If
            'OutlookFolderNames = sArray
            oMAPI = Nothing
        Catch ex As Exception
            messagebox.show(ex.Message)
            log.WriteToArchiveLog("clsRecon : OutlookFolderNames : 23 : " + ex.Message)
        End Try
        Return ""
    End Function


    Sub ConvertName(ByRef FQN AS String )
        For i As Integer = 1 To FQN.Length
Dim CH AS String  = Mid(FQN, i, 1) 
            If CH = " " Then
                Mid(FQN, i, 1) = "_"
            End If
            If CH = ":" Then
                Mid(FQN, i, 1) = "."
            End If
            If CH = "/" Then
                Mid(FQN, i, 1) = "."
            End If
        Next
    End Sub
End Class

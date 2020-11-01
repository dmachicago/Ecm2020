Imports System
Imports System.Net.Mail
Imports System.IO
Imports System.Web.Mail
Imports System.Net.NetworkCredential


Public Class clsEmail

    Private mMailServer As String
    Private mTo As String
    Private mFrom As String
    Private mMsg As String
    Private mSubject As String

    Private Shared Property strFrom As MailAddress

    Public Function btnSendTextMsg(ByVal Carrier As String, _
                                ByVal PhoneNumber As String, _
                                ByVal Sender As String, _
                                ByVal Subject As String, _
                                ByVal MailServer As String, _
                                ByVal TextMessage As String, _
                                ByRef RetMsg As String) As Boolean

        Dim B As Boolean = false
        mTo = Trim(PhoneNumber) & Trim(Carrier)
        mFrom = Trim(Sender)
        mSubject = Trim(Subject)
        mMailServer = Trim(MailServer)
        mMsg = Trim(TextMessage)

        ' Within a try catch, format and send the message to
        ' the recipient. Catch and handle any errors.
        Try
            Dim message As New System.Net.Mail.MailMessage(mFrom, mTo, mSubject, mMsg)
            Dim mySmtpClient As New SmtpClient(mMailServer)
            mySmtpClient.UseDefaultCredentials = True
            mySmtpClient.Send(message)
            B = True
        Catch ex As Exception
            RetMsg = "ERRORR SMS Send: " + ex.Message
            B = false
        End Try
        Return B
    End Function

    Public Shared Sub SendMailAlertNotification(ByVal UserName As String, _
                            ByVal UserPW As String, _
                            ByVal strFrom As String, _
                            ByVal strTo As String, _
                            ByVal CC As String, _
                            ByVal Subject As String, _
                            ByVal Body As String, _
                            ByVal Attachments As String, _
                            ByVal SMTPServer As String, _
                            ByRef RC As Boolean, _
                            ByRef RetMsg As String)

        Try
            Dim Server As New SmtpClient(SMTPServer)
            Server.Credentials = New System.Net.NetworkCredential(UserName, UserPW)
            Dim email As New System.Net.Mail.MailMessage

            email.From = New MailAddress(strFrom)
            email.To.Add(strTo)
            email.Subject = Subject
            email.Body = Body
            email.CC.Add(CC)
            'If Not Attachments.Equals(String.Empty) Then
            '    Dim strFile As String
            '    Dim strAttach() As String = Attachments.Split(";")
            '    For Each strFile In strAttach
            '        email.Attachments.Add(New MailAttachment(strFile.Trim()))
            '    Next
            'End If
            Try
                Server.Send(email)
                RC = True
            Catch ex As Exception
                RetMsg = "ERROR 01: SendMailAlertNotification" + ex.Message
                RC = false
            End Try
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            RetMsg = "ERROR 02: SendMailAlertNotification" + ex.Message
            RC = false
        End Try

    End Sub
    Public Shared Sub SendMailAlertNotification(ByVal strTo As String, _
                            ByVal AlertWords As String, _
                            ByVal TriggeringUser As String, _
                            ByVal Attachments As String, _
                            ByVal SMTPServer As String, _
                            ByRef RC As Boolean, _
                            ByRef RetMsg As String)

        Try
            Dim UserName As String = "EcmNotification"
            Dim UserPW As String = "xxxJunebug1"
            Dim Server As New SmtpClient(SMTPServer)
            Server.Credentials = New System.Net.NetworkCredential(UserName, UserPW)
            Dim email As New System.Net.Mail.MailMessage

            email.From = New MailAddress("EcmAlert@EcmLibrary.com")
            email.To.Add(strTo)
            email.Subject = "ECM Security Alert Notification"
            Dim tMsg As String = "The following alerts were triggered by user: " + TriggeringUser + vbCrLf + AlertWords
            tMsg.Trim()
            If tMsg.Substring(tMsg.Length - 1, 1).Equals(",") Then
                tMsg.Remove(tMsg.Length - 1, 1)
                tMsg = tMsg + "."
            End If
            email.Body = tMsg
            'email.CC.Add(CC)
            'If Not Attachments.Equals(String.Empty) Then
            '    Dim strFile As String
            '    Dim strAttach() As String = Attachments.Split(";")
            '    For Each strFile In strAttach
            '        email.Attachments.Add(New MailAttachment(strFile.Trim()))
            '    Next
            'End If
            Try
                Server.Send(email)
                RC = True
            Catch ex As Exception
                RetMsg = "ERROR 01: SendMailAlertNotification" + ex.Message
                RC = false
            End Try
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            RetMsg = "ERROR 02: SendMailAlertNotification" + ex.Message
            RC = false
        End Try

    End Sub

    Public Shared Sub SendMailSecurityScanNotification(ByVal strTo As String, _
                            ByVal SeachName As String, _
                            ByVal AlertWords As String, _
                            ByVal TriggeringUser As String, _
                            ByVal Attachments As String, _
                            ByRef RC As Boolean, _
                            ByRef RetMsg As String)

        Try
            Dim SMTPServer As String = "securesmtp.popmail.com"
            Dim UserName As String = "EcmNotification"
            Dim UserPW As String = "xxxJunebug1"
            Dim Server As New SmtpClient(SMTPServer)
            Server.Credentials = New System.Net.NetworkCredential(UserName, UserPW)
            Dim email As New System.Net.Mail.MailMessage

            email.From = New MailAddress("EcmAlert@EcmLibrary.com")
            email.To.Add(strTo)
            email.Subject = "ECM Security Alert Notification"
            Dim tMsg As String = "The following alerts were triggered by user: " + TriggeringUser + vbCrLf + AlertWords
            tMsg.Trim()
            If tMsg.Substring(tMsg.Length - 1, 1).Equals(",") Then
                tMsg.Remove(tMsg.Length - 1, 1)
                tMsg = tMsg + "."
            End If
            email.Body = tMsg
            'email.CC.Add(CC)
            'If Not Attachments.Equals(String.Empty) Then
            '    Dim strFile As String
            '    Dim strAttach() As String = Attachments.Split(";")
            '    For Each strFile In strAttach
            '        email.Attachments.Add(New MailAttachment(strFile.Trim()))
            '    Next
            'End If
            Try
                Server.Send(email)
                RC = True
            Catch ex As Exception
                RetMsg = "ERROR 01: SendMailAlertNotification" + ex.Message
                RC = false
            End Try
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            RetMsg = "ERROR 02: SendMailAlertNotification" + ex.Message
            RC = false
        End Try

    End Sub
End Class

Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsEMAIL

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim ARCHHIST As New clsARCHIVEHIST
    Dim ARCHHISTTYPE As New clsARCHIVEHISTCONTENTTYPE




    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma



    Dim EmailGuid As String = ""
    Dim SUBJECT As String = ""
    Dim SentTO As String = ""
    Dim Body As String = ""
    Dim Bcc As String = ""
    Dim BillingInformation As String = ""
    Dim CC As String = ""
    Dim Companies As String = ""
    Dim CreationTime As String = ""
    Dim ReadReceiptRequested As String = ""
    Dim ReceivedByName As String = ""
    Dim ReceivedTime As String = ""
    Dim AllRecipients As String = ""
    Dim UserID As String = ""
    Dim SenderEmailAddress As String = ""
    Dim SenderName As String = ""
    Dim Sensitivity As String = ""
    Dim SentOn As String = ""
    Dim MsgSize As String = ""
    Dim DeferredDeliveryTime As String = ""
    Dim EmailIdentifier As String = ""
    Dim EntryID As String = ""
    Dim ExpiryTime As String = ""
    Dim LastModificationTime As String = ""
    Dim EmailImage As String = ""
    Dim Accounts As String = ""
    Dim RowID As String = ""
    Dim ShortSubj As String = ""
    Dim SourceTypeCode As String = ""
    Dim OriginalFolder As String = ""
    Dim StoreID As String = ""




    '** Generate the SET methods 
    Public Sub setEmailguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Emailguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        EmailGuid = val
    End Sub


    Public Sub setSubject(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SUBJECT = val
    End Sub


    Public Sub setSentto(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SentTO = val
    End Sub


    Public Sub setBody(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Body = val
    End Sub


    Public Sub setBcc(ByRef val As String)
        val = Mid(val, 1, 79).Trim
        val = UTIL.RemoveSingleQuotes(val)
        Bcc = val
    End Sub


    Public Sub setBillinginformation(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BillingInformation = val
    End Sub


    Public Sub setCc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CC = val
    End Sub


    Public Sub setCompanies(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Companies = val
    End Sub


    Public Sub setCreationtime(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreationTime = val
    End Sub


    Public Sub setReadreceiptrequested(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ReadReceiptRequested = val
    End Sub


    Public Sub setReceivedbyname(ByRef val As String)
        val = Mid(val, 1, 79).Trim
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Receivedbyname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ReceivedByName = val
    End Sub


    Public Sub setReceivedtime(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Receivedtime' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ReceivedTime = val
    End Sub


    Public Sub setAllrecipients(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AllRecipients = val
    End Sub


    Public Sub setCurrentuser(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'UserID' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setSenderemailaddress(ByRef val As String)
        val = Mid(val, 1, 79).Trim
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Senderemailaddress' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SenderEmailAddress = val
    End Sub


    Public Sub setSendername(ByRef val As String)
        val = Mid(val, 1, 99).Trim
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sendername' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SenderName = val
    End Sub


    Public Sub setSensitivity(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Sensitivity = val
    End Sub


    Public Sub setSenton(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Senton' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SentOn = val
    End Sub


    Public Sub setMsgsize(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        MsgSize = val
    End Sub


    Public Sub setDeferreddeliverytime(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        DeferredDeliveryTime = val
    End Sub

    Public Sub setEmailIdentifier(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        EmailIdentifier = val
    End Sub

    Public Sub setEntryid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        EntryID = val
    End Sub

    Public Sub setStoreID(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        StoreID = val
    End Sub
    Public Sub setExpirytime(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ExpiryTime = val
    End Sub


    Public Sub setLastmodificationtime(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastModificationTime = val
    End Sub


    Public Sub setEmailimage(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        EmailImage = val
    End Sub


    Public Sub setAccounts(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Accounts = val
    End Sub


    Public Sub setShortsubj(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ShortSubj = val
    End Sub


    Public Sub setSourcetypecode(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub


    Public Sub setOriginalfolder(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        OriginalFolder = val
    End Sub






    '** Generate the GET methods 
    Public Function getEmailguid() As String
        If Len(EmailGuid) = 0 Then
            MessageBox.Show("GET: Field 'Emailguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(EmailGuid)
    End Function
    Public Function getStoreID() As String
        Return UTIL.RemoveSingleQuotes(StoreID)
    End Function
    Public Function getSubject() As String
        Return UTIL.RemoveSingleQuotes(SUBJECT)
    End Function


    Public Function getSentto() As String
        Return UTIL.RemoveSingleQuotes(SentTO)
    End Function


    Public Function getBody() As String
        Return UTIL.RemoveSingleQuotes(Body)
    End Function


    Public Function getBcc() As String
        Return UTIL.RemoveSingleQuotes(Bcc)
    End Function


    Public Function getBillinginformation() As String
        Return UTIL.RemoveSingleQuotes(BillingInformation)
    End Function


    Public Function getCc() As String
        Return UTIL.RemoveSingleQuotes(CC)
    End Function


    Public Function getCompanies() As String
        Return UTIL.RemoveSingleQuotes(Companies)
    End Function


    Public Function getCreationtime() As String
        Return UTIL.RemoveSingleQuotes(CreationTime)
    End Function


    Public Function getReadreceiptrequested() As String
        Return UTIL.RemoveSingleQuotes(ReadReceiptRequested)
    End Function


    Public Function getReceivedbyname() As String
        If Len(ReceivedByName) = 0 Then
            MessageBox.Show("GET: Field 'Receivedbyname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ReceivedByName)
    End Function


    Public Function getReceivedtime() As String
        If Len(ReceivedTime) = 0 Then
            MessageBox.Show("GET: Field 'Receivedtime' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ReceivedTime)
    End Function


    Public Function getAllrecipients() As String
        Return UTIL.RemoveSingleQuotes(AllRecipients)
    End Function


    Public Function getCurrentuser() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'UserID' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getSenderemailaddress() As String
        If Len(SenderEmailAddress) = 0 Then
            MessageBox.Show("GET: Field 'Senderemailaddress' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SenderEmailAddress)
    End Function


    Public Function getSendername() As String
        If Len(SenderName) = 0 Then
            MessageBox.Show("GET: Field 'Sendername' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SenderName)
    End Function


    Public Function getSensitivity() As String
        Return UTIL.RemoveSingleQuotes(Sensitivity)
    End Function


    Public Function getSenton() As String
        If Len(SentOn) = 0 Then
            MessageBox.Show("GET: Field 'Senton' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SentOn)
    End Function


    Public Function getMsgsize() As String
        If Len(MsgSize) = 0 Then
            MsgSize = "null"
        End If
        Return MsgSize
    End Function


    Public Function getDeferreddeliverytime() As String
        Return UTIL.RemoveSingleQuotes(DeferredDeliveryTime)
    End Function


    Public Function getCE_EmailIdentifiers() As String
        Return UTIL.RemoveSingleQuotes(EntryID)
    End Function


    Public Function getExpirytime() As String
        Return UTIL.RemoveSingleQuotes(ExpiryTime)
    End Function


    Public Function getLastmodificationtime() As String
        Return UTIL.RemoveSingleQuotes(LastModificationTime)
    End Function


    Public Function getEmailimage() As String
        If Len(EmailImage) = 0 Then
            EmailImage = "null"
        End If
        Return EmailImage
    End Function


    Public Function getAccounts() As String
        Return UTIL.RemoveSingleQuotes(Accounts)
    End Function


    Public Function getRowid() As String
        If Len(RowID) = 0 Then
            MessageBox.Show("GET: Field 'Rowid' cannot be NULL.")
            Return ""
        End If
        If Len(RowID) = 0 Then
            RowID = "null"
        End If
        Return RowID
    End Function


    Public Function getShortsubj() As String
        Return UTIL.RemoveSingleQuotes(ShortSubj)
    End Function


    Public Function getSourcetypecode() As String
        Return UTIL.RemoveSingleQuotes(SourceTypeCode)
    End Function


    Public Function getOriginalfolder() As String
        Return UTIL.RemoveSingleQuotes(OriginalFolder)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If EmailGuid.Length = 0 Then Return False
        If ReceivedByName.Length = 0 Then Return False
        If ReceivedTime.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If SenderEmailAddress.Length = 0 Then Return False
        If SenderName.Length = 0 Then Return False
        If SentOn.Length = 0 Then Return False
        If RowID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If EmailGuid.Length = 0 Then Return False
        If ReceivedByName.Length = 0 Then Return False
        If ReceivedTime.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If SenderEmailAddress.Length = 0 Then Return False
        If SenderName.Length = 0 Then Return False
        If SentOn.Length = 0 Then Return False
        Return True
    End Function

    Function ckEmailAlreadyExists(EmailFolderName As String, ByVal EmailIdentifier As String) As Boolean

        Dim SS As String = "select COUNT(*) from Email where EmailIdentifier = '" + EmailIdentifier + "' "
        Dim iCnt As Integer = DBARCH.iCount(SS)

        If (iCnt = 0) Then
            DBARCH.saveContentOwner(EmailGuid, gCurrUserGuidID, "E", EmailFolderName, gMachineID, gNetworkID)
            Return False
        Else
            Return True
        End If
    End Function


    '** Generate the INSERT method 
    Public Function InsertNewEmail(MachineName As String,
                                   NetworkName As String,
                                   ByVal EmailSuffix As String,
                                   ByVal EmailIdentifier As String,
                                   CRC As String,
                                   EmailFolderName As String) As Boolean

        Dim bRtn As Boolean = ckEmailAlreadyExists(EmailFolderName, EmailIdentifier)
        If bRtn = True Then
            Return True
        End If

        Dim b As Boolean = False
        Dim NewID As String = Guid.NewGuid.ToString
        Dim s As String = ""
        s = s + " INSERT INTO Email(RowGuid, "
        s = s + "EmailGuid," + vbCrLf
        s = s + "SUBJECT," + vbCrLf
        s = s + "SentTO," + vbCrLf
        s = s + "Body," + vbCrLf
        s = s + "Bcc," + vbCrLf
        s = s + "BillingInformation," + vbCrLf
        s = s + "CC," + vbCrLf
        s = s + "Companies," + vbCrLf
        s = s + "CreationTime," + vbCrLf
        s = s + "ReadReceiptRequested," + vbCrLf
        s = s + "ReceivedByName," + vbCrLf
        s = s + "ReceivedTime," + vbCrLf
        s = s + "AllRecipients," + vbCrLf
        s = s + "UserID," + vbCrLf
        s = s + "SenderEmailAddress," + vbCrLf
        s = s + "SenderName," + vbCrLf
        s = s + "Sensitivity," + vbCrLf
        s = s + "SentOn," + vbCrLf
        s = s + "MsgSize," + vbCrLf
        s = s + "DeferredDeliveryTime," + vbCrLf
        s = s + "EntryID," + vbCrLf
        s = s + "ExpiryTime," + vbCrLf
        s = s + "LastModificationTime," + vbCrLf
        's = s + "EmailImage," + vbcrlf
        s = s + "Accounts," + vbCrLf
        s = s + "ShortSubj," + vbCrLf
        s = s + "SourceTypeCode," + vbCrLf
        s = s + "OriginalFolder, StoreID, EmailIdentifier, CRC, RecHash) values ( "
        s = s + "'" + NewID + "'" + "," + vbCrLf
        s = s + "'" + EmailGuid + "'" + "," + vbCrLf
        s = s + "'" + SUBJECT + "'" + "," + vbCrLf
        s = s + "'" + SentTO + "'" + "," + vbCrLf
        s = s + "'" + Body + "'" + "," + vbCrLf
        s = s + "'" + Bcc + "'" + "," + vbCrLf
        s = s + "'" + BillingInformation + "'" + "," + vbCrLf
        s = s + "'" + CC + "'" + "," + vbCrLf
        s = s + "'" + Companies + "'" + "," + vbCrLf
        s = s + "'" + CreationTime + "'" + "," + vbCrLf
        s = s + "'" + ReadReceiptRequested + "'" + "," + vbCrLf
        s = s + "'" + ReceivedByName + "'" + "," + vbCrLf
        s = s + "'" + ReceivedTime + "'" + "," + vbCrLf
        s = s + "'" + AllRecipients + "'" + "," + vbCrLf
        s = s + "'" + UserID + "'" + "," + vbCrLf
        s = s + "'" + SenderEmailAddress + "'" + "," + vbCrLf
        s = s + "'" + SenderName + "'" + "," + vbCrLf
        s = s + "'" + Sensitivity + "'" + "," + vbCrLf
        s = s + "'" + SentOn + "'" + "," + vbCrLf
        s = s + MsgSize + "," + vbCrLf
        s = s + "'" + DeferredDeliveryTime + "'" + "," + vbCrLf
        s = s + "'" + EntryID + "'" + "," + vbCrLf
        s = s + "'" + ExpiryTime + "'" + "," + vbCrLf
        s = s + "'" + LastModificationTime + "'" + "," + vbCrLf
        's = s + EmailImage + "," + vbcrlf
        s = s + "'" + Accounts + "'" + "," + vbCrLf
        's = s + RowID + "," + vbcrlf
        s = s + "'" + ShortSubj + "'" + "," + vbCrLf
        s = s + "'" + SourceTypeCode + "'" + "," + vbCrLf
        s = s + "'" + OriginalFolder + "'" + "," + vbCrLf
        s = s + "'" + StoreID + "'" + "," + vbCrLf
        s = s + "'" + EmailIdentifier + "', " + vbCrLf
        s = s + "'" + CRC + "', " + vbCrLf
        s = s + "'" + CRC + "') " + vbCrLf

        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(s, False)

        s = "Update DataSource set CRC = '" + CRC + "' where EmailGuid = '" + NewID + "'"
        BB = DBARCH.ExecuteSqlNewConn(s, False)
        s = "Update DataSource set ImageHash = convert(nvarchar(100), " + CRC + ") where EmailGuid = '" + NewID + "'"
        BB = DBARCH.ExecuteSqlNewConn(s, False)

        If BB Then
            If OriginalFolder.Length = 0 Then
                OriginalFolder = "NONE SUPPLIED"
            End If

            DBARCH.UpdateCurrArchiveStats(OriginalFolder, EmailSuffix)

            BB = DBARCH.saveContentOwner(EmailGuid, UserID, "E", EmailFolderName, MachineName, NetworkName)

        Else
            Console.WriteLine("ERROR 110xx1 - Failed rto insert Email '" + SUBJECT + "'.")
        End If



        Return BB


    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update Email set "
        s = s + "EmailGuid = '" + getEmailguid() + "'" + ", "
        s = s + "SUBJECT = '" + getSubject() + "'" + ", "
        s = s + "SentTO = '" + getSentto() + "'" + ", "
        s = s + "Body = '" + getBody() + "'" + ", "
        s = s + "Bcc = '" + getBcc() + "'" + ", "
        s = s + "BillingInformation = '" + getBillinginformation() + "'" + ", "
        s = s + "CC = '" + getCc() + "'" + ", "
        s = s + "Companies = '" + getCompanies() + "'" + ", "
        s = s + "CreationTime = '" + getCreationtime() + "'" + ", "
        s = s + "ReadReceiptRequested = '" + getReadreceiptrequested() + "'" + ", "
        s = s + "ReceivedByName = '" + getReceivedbyname() + "'" + ", "
        s = s + "ReceivedTime = '" + getReceivedtime() + "'" + ", "
        s = s + "AllRecipients = '" + getAllrecipients() + "'" + ", "
        s = s + "UserID = '" + getCurrentuser() + "'" + ", "
        s = s + "SenderEmailAddress = '" + getSenderemailaddress() + "'" + ", "
        s = s + "SenderName = '" + getSendername() + "'" + ", "
        s = s + "Sensitivity = '" + getSensitivity() + "'" + ", "
        s = s + "SentOn = '" + getSenton() + "'" + ", "
        s = s + "MsgSize = " + getMsgsize() + ", "
        s = s + "DeferredDeliveryTime = '" + getDeferreddeliverytime() + "'" + ", "
        s = s + "EntryID = '" + getCE_EmailIdentifiers() + "'" + ", "
        s = s + "ExpiryTime = '" + getExpirytime() + "'" + ", "
        s = s + "LastModificationTime = '" + getLastmodificationtime() + "'" + ", "
        's = s + "EmailImage = " + getEmailimage() + ", "
        s = s + "Accounts = '" + getAccounts() + "'" + ", "
        s = s + "ShortSubj = '" + getShortsubj() + "'" + ", "
        s = s + "SourceTypeCode = '" + getSourcetypecode() + "'" + ", "
        s = s + "OriginalFolder = '" + getOriginalfolder() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function




    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "EmailGuid,"
        s = s + "SUBJECT,"
        s = s + "SentTO,"
        s = s + "Body,"
        s = s + "Bcc,"
        s = s + "BillingInformation,"
        s = s + "CC,"
        s = s + "Companies,"
        s = s + "CreationTime,"
        s = s + "ReadReceiptRequested,"
        s = s + "ReceivedByName,"
        s = s + "ReceivedTime,"
        s = s + "AllRecipients,"
        s = s + "UserID,"
        s = s + "SenderEmailAddress,"
        s = s + "SenderName,"
        s = s + "Sensitivity,"
        s = s + "SentOn,"
        s = s + "MsgSize,"
        s = s + "DeferredDeliveryTime,"
        s = s + "EntryID,"
        s = s + "ExpiryTime,"
        s = s + "LastModificationTime,"
        s = s + "EmailImage,"
        s = s + "Accounts,"
        s = s + "RowID,"
        s = s + "ShortSubj,"
        s = s + "SourceTypeCode,"
        s = s + "OriginalFolder "
        s = s + " FROM Email"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "EmailGuid,"
        s = s + "SUBJECT,"
        s = s + "SentTO,"
        s = s + "Body,"
        s = s + "Bcc,"
        s = s + "BillingInformation,"
        s = s + "CC,"
        s = s + "Companies,"
        s = s + "CreationTime,"
        s = s + "ReadReceiptRequested,"
        s = s + "ReceivedByName,"
        s = s + "ReceivedTime,"
        s = s + "AllRecipients,"
        s = s + "UserID,"
        s = s + "SenderEmailAddress,"
        s = s + "SenderName,"
        s = s + "Sensitivity,"
        s = s + "SentOn,"
        s = s + "MsgSize,"
        s = s + "DeferredDeliveryTime,"
        s = s + "EntryID,"
        s = s + "ExpiryTime,"
        s = s + "LastModificationTime,"
        s = s + "EmailImage,"
        s = s + "Accounts,"
        s = s + "RowID,"
        s = s + "ShortSubj,"
        s = s + "SourceTypeCode,"
        s = s + "OriginalFolder "
        s = s + " FROM Email"
        s = s + WhereClause

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from Email"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from Email"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_FULL_UI_EMAIL(ByVal EmailIdentifier As String) As Integer

        EmailIdentifier = UTIL.RemoveSingleQuotes(EmailIdentifier)

        Dim B As Integer = 0
        Dim TBL As String = "Email"
        Dim WC As String = "Where EmailIdentifier = '" + EmailIdentifier + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_FULL_UI_EMAIL
    Public Function cnt_EntryID(EmailIdentifier As String) As Integer

        Dim iCnt As Integer = 0
        Dim TBL As String = "Email"
        Dim WC As String = "Where EmailIdentifier = '" + EmailIdentifier + "' "

        iCnt = DBARCH.iGetRowCount(TBL, WC)

        Return iCnt
    End Function     '** cnt_FULL_UI_EMAIL
    Public Function cnt_PI_EMAIL_01(ByVal ReceivedTime As DateTime, ByVal SentOn As DateTime, ByVal ShortSubj As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "Email"
        Dim WC As String = "Where ReceivedTime = '" + ReceivedTime + "' and   SentOn = '" + SentOn + "' and   ShortSubj = '" + ShortSubj + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PI_EMAIL_01
    Public Function cnt_PK27(ByVal EmailGuid As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "Email"
        Dim WC As String = "Where EmailGuid = '" + EmailGuid + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK27
    Public Function cnt_UK_EMAIL(ByVal RowID As Integer) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "Email"
        Dim WC As String = "Where RowID = " & RowID


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_UK_EMAIL


    '** Generate Index ROW Queries 
    Public Function getRow_FULL_UI_EMAIL(ByVal UserID As String, ByVal ReceivedByName As String, ByVal ReceivedTime As DateTime, ByVal SenderEmailAddress As String, ByVal SenderName As String, ByVal SentOn As DateTime) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Email"
        Dim WC As String = "Where UserID = '" + UserID + "' and   ReceivedByName = '" + ReceivedByName + "' and   ReceivedTime = '" + ReceivedTime + "' and   SenderEmailAddress = '" + SenderEmailAddress + "' and   SenderName = '" + SenderName + "' and   SentOn = '" + SentOn + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_FULL_UI_EMAIL
    Public Function getRow_PI_EMAIL_01(ByVal ReceivedTime As DateTime, ByVal SentOn As DateTime, ByVal ShortSubj As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Email"
        Dim WC As String = "Where ReceivedTime = '" + ReceivedTime + "' and   SentOn = '" + SentOn + "' and   ShortSubj = '" + ShortSubj + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI_EMAIL_01
    Public Function getRow_PK27(ByVal EmailGuid As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Email"
        Dim WC As String = "Where EmailGuid = '" + EmailGuid + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK27
    Public Function getRow_UK_EMAIL(ByVal RowID As Integer) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Email"
        Dim WC As String = "Where RowID = " & RowID


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UK_EMAIL


    ''' Build Index Where Caluses 
    '''
    Public Function wc_FULL_UI_EMAIL(ByVal UserID As String, ByVal ReceivedByName As String, ByVal ReceivedTime As DateTime, ByVal SenderEmailAddress As String, ByVal SenderName As String, ByVal SentOn As DateTime) As String


Dim WC AS String  = "Where UserID = '" + UserID + "' and   ReceivedByName = '" + ReceivedByName + "' and   ReceivedTime = '" + ReceivedTime + "' and   SenderEmailAddress = '" + SenderEmailAddress + "' and   SenderName = '" + SenderName + "' and   SentOn = '" + SentOn + "'" 


        Return WC
    End Function     '** wc_FULL_UI_EMAIL
    Public Function wc_PI_EMAIL_01(ByVal ReceivedTime As DateTime, ByVal SentOn As DateTime, ByVal ShortSubj As String) As String


Dim WC AS String  = "Where ReceivedTime = '" + ReceivedTime + "' and   SentOn = '" + SentOn + "' and   ShortSubj = '" + ShortSubj + "'" 


        Return WC
    End Function     '** wc_PI_EMAIL_01
    Public Function wc_PK27(ByVal EmailGuid As String) As String


Dim WC AS String  = "Where EmailGuid = '" + EmailGuid + "'" 


        Return WC
    End Function     '** wc_PK27
    Public Function wc_UK_EMAIL(ByVal RowID As Integer) As String


Dim WC AS String  = "Where RowID = " & RowID 


        Return WC
    End Function     '** wc_UK_EMAIL
End Class

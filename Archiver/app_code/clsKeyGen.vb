Imports System.IO
Imports System.Math
Imports System.Text
Imports System.Security.Cryptography
Imports ECMEncryption

Public Class clsKeyGen

    Dim LOG As New clsLogging
    Dim ENC As new ECMEncrypt

    Public FileName As String = ""
    Public DirName As String = ""
    Public FileLength As Integer = 0
    Public FileNameHash As String = ""
    Public CreateDate As Date = Nothing
    Public LastWriteDate As Date = Nothing
    Public FileExt As String = ""
    Public CRC As Decimal = 0
    Public FileNameCrc As Decimal = 0
    Public DirNameCrc As Decimal = 0
    Public FileHash As String = ""
    Public GroupKey As String = ""
    Public KeyHash As String = ""

    Public EmailSubject As String = ""
    Public EmailBody As String = ""
    Public SubjectLength As Integer = 0
    Public BodyLength As Integer = 0
    Public EmailNbrAttachments As Integer = 0
    Public EmailAuthor As String = ""
    Public EmailCreateDate As Date = Nothing
    
    Dim F As IO.FileInfo

    Function HashFile(ByVal FileNameOnly As String, _
                       ByVal FileLength As String, _
                       ByVal FileExt As String, _
                       ByVal FileCreationDate As String, _
                       ByVal FileLastUpdate As String) As String

        Dim FullKey As String = FileNameOnly + FileLength + FileExt + FileCreationDate + FileLastUpdate
        Dim HashKey As String = ""

        HashKey = getMD5HashX(FullKey)

        Return HashKey
    End Function

    Function genHashContent(ByVal CreateDate As String, ByVal SourceName As String, ByVal OriginalFileType As String, ByVal FileLength As String, ByVal CRC As String) As String

        SourceName = SourceName.Replace("'", "`")

        Dim FullKey As String = CreateDate + SourceName + OriginalFileType + FileLength + CRC
        Dim HashKey As String = ""

        HashKey = getMD5HashX(FullKey)

        Return HashKey
    End Function

    Public Function genEmailHashCode(ByVal Subject As String, ByVal body As String, _
                       ByVal SenderEmailAddress As String, _
                       ByVal CreationDate As String, _
                       ByVal NumberOfAttachments As String, _
                       ByVal FileExt As String) As String

        body = body.Replace("'", "`")
        Subject = Subject.Replace("'", "`")
        SenderEmailAddress = SenderEmailAddress.Replace("'", "`")
        CreationDate = FileExt.Replace("'", "`")
        FileExt = FileExt.Replace("'", "`")

        Dim FullKey As String = Subject + body + SenderEmailAddress + CreationDate + NumberOfAttachments + FileExt
        Dim HashKey As String = ""

        HashKey = ENC.getSha1HashKey(FullKey)
        'HashKey = getSha1Hash(FullKey)
        'HashKey = getMD5HashX(FullKey)

        Return HashKey
    End Function

    Function genFileKey(ByVal FQN As String) As String

        Dim HashStr As String = ""
        Dim FileKey As String = ""
        F = New IO.FileInfo(FQN)

        If F.Exists() Then

            FileKey = ENC.GenerateSHA512HashFromFile(FQN)

            'FileName = F.Name
            'FileExt = F.Extension
            'FileLength = F.Length
            'LastWriteDate = F.LastWriteTime
            'CreateDate = F.CreationTime

            'If FileExt.Length = 0 Then
            '    FileExt = ".UKN"
            'End If

            ''DirNameCrc = HashCalc(DirName)
            'FileNameCrc = HashCalc(FileName)

            'FileKey = GenFileHash(FQN)
            'KeyHash = HashCalc(FileKey)

            'HashStr = FileName + FileLength.ToString() + CreateDate.ToString() + LastWriteDate.ToString()
            'FileKey = getMD5HashX(HashStr)

            'GroupKey = FileHash & ":" & KeyHash.ToString

            ''FileKey = FileKey + KeyHash.ToString

        End If

        F = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return FileKey

    End Function

    Function genEmailKey(ByVal Subject As String, ByVal EmailBody As String, ByVal EmailCreateDate As String, ByVal EmailAuthor As String, ByVal NbrAttachments As String, ByVal EmailExt As String) As String

        Dim EmailKey As String = Subject + EmailBody + EmailCreateDate + EmailAuthor + NbrAttachments + EmailExt

        Dim MD5Key As String = getMD5HashX(EmailKey)

        'EmailKey = EmailKey + KeyHash.ToString

        Return MD5Key

    End Function

    Function GenFileHash(ByVal FQN AS String ) As String
        Dim GeneratedHash As String = ""
        FileHash = CalcFileCRC(FQN )

        DirName = F.DirectoryName.ToUpper
        FileName  = F.Name.ToUpper
        FileExt = F.Extension.ToUpper
        FileLength = F.Length
        LastWriteDate = F.LastWriteTime
        CreateDate = F.CreationTime

        'GeneratedHash += DirName + Chr(254)
        'GeneratedHash += DirNameCrc.ToString + Chr(254)
        GeneratedHash += FileName  + Chr(254)
        GeneratedHash += FileNameCrc.ToString + Chr(254)
        GeneratedHash += FileExt + Chr(254)
        GeneratedHash += FileLength.ToString + Chr(254)
        GeneratedHash += CreateDate.ToString + Chr(254)
        'GeneratedHash += LastWriteDate.ToString + Chr(254)
        GeneratedHash += FileHash

        Return GeneratedHash
    End Function

    Function GenEmailHash(ByVal Subject As String, ByVal EmailBody As String, ByVal EmailCreateDate As String, ByVal EmailAuthor As String, ByVal NbrAttachments As String, ByVal EmailExt As String) As String
        Dim GeneratedHash As String = ""

        GeneratedHash += Subject + Chr(254)
        GeneratedHash += EmailBody + Chr(254)
        GeneratedHash += EmailCreateDate + Chr(254)
        GeneratedHash += EmailAuthor + Chr(254)
        GeneratedHash += NbrAttachments + Chr(254)
        GeneratedHash += EmailExt

        Return GeneratedHash
    End Function


    Function HashCalc(ByVal tString As String) As Decimal
        Dim iHash As Decimal = 0

        For i As Integer = 1 To tString.Length
            Dim iAsc As Integer = Asc(Mid(tString, i, 1))
            iHash = iHash + iAsc
            iHash = iHash + i
            If i Mod 5 = 0 Then
                iHash = iHash + Sqrt(iHash)
                Math.Round(iHash, 6)
            End If
        Next
        Math.Round(iHash, 6)
        iHash = Truncate(iHash, 6)
        Return iHash
    End Function

    Function CalcFileCRC(ByVal FQN AS String ) As String

        Dim zipCrc As New Chilkat.ZipCrc()
        Dim crc As Long = 0
        crc = zipCrc.FileCrc(FQN)
        Dim hexStr As String
        hexStr = zipCrc.ToHex(crc)
        Return hexStr

    End Function

    Function Truncate(ByVal value As Decimal, ByVal decimals As Integer) As Decimal

        Return Math.Round(value - 0.5 / Math.Pow(10, decimals), decimals)

    End Function

    ''' <summary>
    ''' Get the MD5 Hash of a String
    ''' </summary>
    ''' <param name="strToHash">The String to Hash</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function getMD5HashX(ByVal strToHash As String) As String
        Dim md5Obj As New Security.Cryptography.MD5CryptoServiceProvider
        Dim bytesToHash() As Byte = System.Text.Encoding.UTF8.GetBytes(strToHash)

        bytesToHash = md5Obj.ComputeHash(bytesToHash)
        Dim strResult As String = System.Text.ASCIIEncoding.UTF8.GetString(bytesToHash)
        strResult = ""
        For Each b As Byte In bytesToHash
            strResult += b.ToString("x2")
        Next

        Return strResult
    End Function

    Function getSha1Hash(ByVal strToHash As String) As String

        Dim Sha1Obj As New Security.Cryptography.SHA1CryptoServiceProvider
        Dim bytesToHash() As Byte = System.Text.Encoding.UTF8.GetBytes(strToHash)

        bytesToHash = Sha1Obj.ComputeHash(bytesToHash)

        Dim strResult As String = System.Text.ASCIIEncoding.UTF8.GetString(bytesToHash)
        strResult = ""
        For Each b As Byte In bytesToHash
            strResult += b.ToString("x2")
        Next

        Return strResult
    End Function

    Private Function GenerateHash(ByVal SourceText As String) As String
        'Create an encoding object to ensure the encoding standard for the source text
        Dim Ue As New UnicodeEncoding
        'Retrieve a byte array based on the source text
        Dim ByteSourceText() As Byte = Ue.GetBytes(SourceText)
        'Instantiate an MD5 Provider object
        Dim Md5 As New MD5CryptoServiceProvider()
        'Compute the hash value from the source
        Dim ByteHash() As Byte = Md5.ComputeHash(ByteSourceText)
        'And convert it to String format for return
        Return Convert.ToBase64String(ByteHash)
    End Function

End Class

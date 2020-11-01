Imports System.Security.Cryptography
Imports System.IO
Imports System.Text
''' <summary>
''' Copyright @ DMA, Ltd., January 2009, all rights reserved.
''' Encryption class used to encrypt and decrypt strings of data.
''' </summary>
''' <remarks></remarks>
Public Class clsEncrypt


    Dim ddebug As Boolean = False
    'Dim UTIL As New clsUtility

    Public Function hashSha1File(ByVal FQN As String) As String

        FQN = FQN.replace("''", "'")

        Dim hashResult As String = String.Empty
        Dim FI As New FileInfo(FQN)
        Dim fSize As Integer = FI.Length
        FI = Nothing
        GC.Collect()

        Dim BUF_SIZE As Integer = 32
        Dim dataArray(BUF_SIZE - 1) As Byte
        Dim FileBuffer(fSize) As Byte
        Dim sha As New SHA1CryptoServiceProvider()


        Dim f As System.IO.FileStream
        f = New System.IO.FileStream(FQN, IO.FileMode.Open, IO.FileAccess.Read)
        f.Read(FileBuffer, 0, fSize - 1)

        Dim result As Byte() = sha.ComputeHash(dataArray)

        f.Close()
        f.Dispose()
        GC.Collect()
        GC.WaitForPendingFinalizers()

        hashResult = BitConverter.ToString(sha.Hash).Replace("-", "").ToLower
        Console.WriteLine("Length: " + hashResult.Length.ToString + "    : " + hashResult)
        Return hashResult

    End Function

    Public Function hashCrc32(ByVal filePath As String) As String
        Dim BUF_SIZE As Integer = 32
        Dim dataBuffer(BUF_SIZE - 1) As Byte
        Dim dataBufferDummy(BUF_SIZE - 1) As Byte
        Dim dataBytesRead As Integer = 0
        Dim hashResult As String = String.Empty
        Dim hashAlg As HashAlgorithm = Nothing
        Dim fs As FileStream = Nothing

        Dim f = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 8192)
        Dim sha1 = New SHA1CryptoServiceProvider()
        Dim Sha1Hash() As Byte = sha1.ComputeHash(f)

        hashResult = BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower
        f.Close()
        f.Dispose()
        GC.Collect()
        Return hashResult

        'Try
        '    hashAlg = New MD5CryptoServiceProvider ' or New SHA1CryptoServiceProvider
        '    fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)
        '    Do
        '        dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE)
        '        hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
        '    Loop Until dataBytesRead = 0
        '    hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
        '    hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower
        'Catch ex As IOException
        '    messagebox.show(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        'Catch ex As UnauthorizedAccessException
        '    messagebox.show(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        'Finally
        '    If Not fs Is Nothing Then
        '        fs.Close()
        '        fs.Dispose()
        '        fs = Nothing
        '    End If
        '    If Not hashAlg Is Nothing Then
        '        hashAlg.Clear() 'Dispose()
        '        hashAlg = Nothing
        '    End If
        'End Try
        'Return hashResult
    End Function

    Public Function hashSha1(ByVal filePath As String) As String
        Dim BUF_SIZE As Integer = 32
        Dim dataBuffer(BUF_SIZE - 1) As Byte
        Dim dataBufferDummy(BUF_SIZE - 1) As Byte
        Dim dataBytesRead As Integer = 0
        Dim hashResult As String = String.Empty
        Dim hashAlg As HashAlgorithm = Nothing
        Dim fs As FileStream = Nothing
        Try
            hashAlg = New SHA1CryptoServiceProvider
            fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)
            Do
                dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE)
                hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
            Loop Until dataBytesRead = 0
            hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
            hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower
        Catch ex As IOException
            MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        Catch ex As UnauthorizedAccessException
            MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        Finally
            If Not fs Is Nothing Then
                fs.Close()
                fs.Dispose()
                fs = Nothing
            End If
            If Not hashAlg Is Nothing Then
                hashAlg.Clear() 'Dispose()
                hashAlg = Nothing
            End If
        End Try
        Return hashResult
    End Function
    Public Function hashMd5(ByVal filePath As String) As String
        Dim BUF_SIZE As Integer = 32
        Dim dataBuffer(BUF_SIZE - 1) As Byte
        Dim dataBufferDummy(BUF_SIZE - 1) As Byte
        Dim dataBytesRead As Integer = 0
        Dim hashResult As String = String.Empty
        Dim hashAlg As HashAlgorithm = Nothing
        Dim fs As FileStream = Nothing
        Try
            hashAlg = New MD5CryptoServiceProvider
            fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)
            Do
                dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE)
                hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
            Loop Until dataBytesRead = 0
            hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
            hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower
        Catch ex As IOException
            MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        Catch ex As UnauthorizedAccessException
            MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
        Finally
            If Not fs Is Nothing Then
                fs.Close()
                fs.Dispose()
                fs = Nothing
            End If
            If Not hashAlg Is Nothing Then
                hashAlg.Clear() 'Dispose()
                hashAlg = Nothing
            End If
        End Try
        Return hashResult
    End Function

    Public Function EncryptString128Bit(ByVal vstrTextToBeEncrypted As String, _
                                       ByVal vstrEncryptionKey As String) As String


        Dim bytValue() As Byte
        Dim bytKey() As Byte
        Dim bytEncoded() As Byte
        Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}
        Dim intLength As Integer
        Dim intRemaining As Integer
        Dim objMemoryStream As New MemoryStream()
        Dim objCryptoStream As CryptoStream
        Dim objRijndaelManaged As RijndaelManaged




        '   **********************************************************************
        '   ******  Strip any null character from string to be encrypted    ******
        '   **********************************************************************


        vstrTextToBeEncrypted = StripNullCharacters(vstrTextToBeEncrypted)


        '   **********************************************************************
        '   ******  Value must be within ASCII range (i.e., no DBCS chars)  ******
        '   **********************************************************************


        bytValue = Encoding.ASCII.GetBytes(vstrTextToBeEncrypted.ToCharArray)


        intLength = Len(vstrEncryptionKey)


        '   ********************************************************************
        '   ******   Encryption Key must be 256 bits long (32 bytes)      ******
        '   ******   If it is longer than 32 bytes it will be truncated.  ******
        '   ******   If it is shorter than 32 bytes it will be padded     ******
        '   ******   with upper-case Xs.                                  ****** 
        '   ********************************************************************


        If intLength >= 32 Then
            vstrEncryptionKey = Strings.Left(vstrEncryptionKey, 32)
        Else
            intLength = Len(vstrEncryptionKey)
            intRemaining = 32 - intLength
            vstrEncryptionKey = vstrEncryptionKey & Strings.StrDup(intRemaining, "X")
        End If


        bytKey = Encoding.ASCII.GetBytes(vstrEncryptionKey.ToCharArray)


        objRijndaelManaged = New RijndaelManaged()


        '   ***********************************************************************
        '   ******  Create the encryptor and write value to it after it is   ******
        '   ******  converted into a byte array                              ******
        '   ***********************************************************************


        Try


            objCryptoStream = New CryptoStream(objMemoryStream, _
              objRijndaelManaged.CreateEncryptor(bytKey, bytIV), _
              CryptoStreamMode.Write)
            objCryptoStream.Write(bytValue, 0, bytValue.Length)


            objCryptoStream.FlushFinalBlock()


            bytEncoded = objMemoryStream.ToArray
            objMemoryStream.Close()
            objCryptoStream.Close()
        Catch






        End Try


        '   ***********************************************************************
        '   ******   Return encryptes value (converted from  byte Array to   ******
        '   ******   a base64 string).  Base64 is MIME encoding)             ******
        '   ***********************************************************************


        Return Convert.ToBase64String(bytEncoded)


    End Function








    Public Function DecryptString128Bit(ByVal vstrStringToBeDecrypted As String, _
                                        ByVal vstrDecryptionKey As String) As String


        Dim bytDataToBeDecrypted() As Byte
        Dim bytTemp() As Byte
        Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}
        Dim objRijndaelManaged As New RijndaelManaged()
        Dim objMemoryStream As MemoryStream
        Dim objCryptoStream As CryptoStream
        Dim bytDecryptionKey() As Byte


        Dim intLength As Integer = 0
        Dim intRemaining As Integer = 0
        Dim intCtr As Integer = 0
        Dim strReturnString As String = String.Empty
        Dim achrCharacterArray() As Char
        Dim intIndex As Integer = 0


        '   *****************************************************************
        '   ******   Convert base64 encrypted value to byte array      ******
        '   *****************************************************************


        bytDataToBeDecrypted = Convert.FromBase64String(vstrStringToBeDecrypted)


        '   ********************************************************************
        '   ******   Encryption Key must be 256 bits long (32 bytes)      ******
        '   ******   If it is longer than 32 bytes it will be truncated.  ******
        '   ******   If it is shorter than 32 bytes it will be padded     ******
        '   ******   with upper-case Xs.                                  ****** 
        '   ********************************************************************


        intLength = Len(vstrDecryptionKey)


        If intLength >= 32 Then
            vstrDecryptionKey = Strings.Left(vstrDecryptionKey, 32)
        Else
            intLength = Len(vstrDecryptionKey)
            intRemaining = 32 - intLength
            vstrDecryptionKey = vstrDecryptionKey & Strings.StrDup(intRemaining, "X")
        End If


        bytDecryptionKey = Encoding.ASCII.GetBytes(vstrDecryptionKey.ToCharArray)


        ReDim bytTemp(bytDataToBeDecrypted.Length)


        objMemoryStream = New MemoryStream(bytDataToBeDecrypted)


        '   ***********************************************************************
        '   ******  Create the decryptor and write value to it after it is   ******
        '   ******  converted into a byte array                              ******
        '   ***********************************************************************


        Try


            objCryptoStream = New CryptoStream(objMemoryStream, _
               objRijndaelManaged.CreateDecryptor(bytDecryptionKey, bytIV), _
               CryptoStreamMode.Read)


            objCryptoStream.Read(bytTemp, 0, bytTemp.Length)


            objCryptoStream.FlushFinalBlock()
            objMemoryStream.Close()
            objCryptoStream.Close()


        Catch


        End Try


        '   *****************************************
        '   ******   Return decypted value     ******
        '   *****************************************


        Return StripNullCharacters(Encoding.ASCII.GetString(bytTemp))


    End Function


    Public Function StripNullCharacters(ByVal vstrStringWithNulls As String) As String


        Dim intPosition As Integer
        Dim strStringWithOutNulls As String


        intPosition = 1
        strStringWithOutNulls = vstrStringWithNulls


        Do While intPosition > 0
            intPosition = InStr(intPosition, vstrStringWithNulls, vbNullChar)


            If intPosition > 0 Then
                strStringWithOutNulls = Left(strStringWithOutNulls, intPosition - 1) & _
                                  Right(strStringWithOutNulls, Len(strStringWithOutNulls) - intPosition)
            End If


            If intPosition > strStringWithOutNulls.Length Then
                Exit Do
            End If
        Loop


        Return strStringWithOutNulls


    End Function

    Public Function xEncryptTripleDES(ByVal sIn As String, ByVal sKey As String) As String
        Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider()
        Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider
        ' scramble the key
        sKey = ScrambleKey(sKey)
        ' Compute the MD5 hash.
        DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey))
        ' Set the cipher mode.
        DES.Mode = System.Security.Cryptography.CipherMode.ECB
        ' Create the encryptor.
        Dim DESEncrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateEncryptor()
        ' Get a byte array of the string.
        Dim Buffer As Byte() = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn)
        ' Transform and return the string.
        Return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
    End Function
    Public Function xEncryptTripleDES(ByVal sIn As String) As String
        Dim sKey As String = bKey()
        Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider()
        Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider
        ' scramble the key
        sKey = ScrambleKey(sKey)
        ' Compute the MD5 hash.
        DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey))
        ' Set the cipher mode.
        DES.Mode = System.Security.Cryptography.CipherMode.ECB
        ' Create the encryptor.
        Dim DESEncrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateEncryptor()
        ' Get a byte array of the string.
        Dim Buffer As Byte() = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn)
        ' Transform and return the string.
        Return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
    End Function


    Public Shared Function DecryptTripleDES(ByVal sOut As String, ByVal sKey As String) As String
        Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider
        Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider

        ' scramble the key
        sKey = ScrambleKey(sKey)
        ' Compute the MD5 hash.
        DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey))
        ' Set the cipher mode.
        DES.Mode = System.Security.Cryptography.CipherMode.ECB
        ' Create the decryptor.
        Dim DESDecrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateDecryptor()
        Dim Buffer As Byte() = Convert.FromBase64String(sOut)
        ' Transform and return the string.
        Return System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
    End Function

    Private Shared Function ScrambleKey(ByVal v_strKey As String) As String
        Dim sbKey As New System.Text.StringBuilder
        Dim intPtr As Integer
        For intPtr = 1 To v_strKey.Length
            Dim intIn As Integer = v_strKey.Length - intPtr + 1
            sbKey.Append(Mid(v_strKey, intIn, 1))
        Next
        Dim strKey As String = sbKey.ToString
        Return sbKey.ToString
    End Function


    Private Function bKey() As String
        Dim S As String = ""


        S = S + "N"
        S = S + "o"
        S = S + "w"
        S = S + "I"
        S = S + "s"
        S = S + "T"
        S = S + "h"
        S = S + "e"
        S = S + "T"
        S = S + "i"
        S = S + "m"
        S = S + "e"
        S = S + "F"
        S = S + "o"
        S = S + "r"
        S = S + "A"
        S = S + "l"
        S = S + "l"
        S = S + "G"
        S = S + "o"
        S = S + "o"
        S = S + "d"
        S = S + "M"
        S = S + "e"
        S = S + "n"


        Return S
    End Function


    Public Function xt001trc(ByVal S As String) As SortedList(Of String, String)
        Dim A As New SortedList(Of String, String)
        Dim B As Boolean = False
        Dim SS As String = ""
        Dim tKey As String = ""
        Dim tVal As String = ""

        SS = DecryptTripleDES128(S, B)
        Dim AR As String() = Split(SS, "|")


        For k As Integer = 0 To UBound(AR)
            If ddebug Then Debug.Print(k.ToString + ": " + AR(k).ToString)
        Next


        For i As Integer = 1 To UBound(AR)

            If i = 0 Then
                Debug.Print("here")
            ElseIf i Mod 2 <> 0 Then
                tKey = AR(i).ToString.Trim
            Else
                tVal = AR(i).ToString.Trim
            End If
            If i Mod 2 = 0 Then
                Try
                    Dim iDx As Integer = A.ContainsKey(tKey)
                    If ddebug Then Debug.Print("KEY: " + tKey)
                    If iDx <= 0 Then
                        A.Add(tKey, tVal)
                        If ddebug Then Debug.Print("Added Pair: " + tKey + ":" + tVal)
                    Else
                        If ddebug Then Debug.Print("key exists: " + tKey + ":" + tVal)
                    End If


                Catch ex As Exception
                    MessageBox.Show("clsEncrypt : xt001trc : 104 : " + ex.Message)
                End Try


            End If
        Next
        Return A
    End Function
    Private Function xmp2rt21() As String
        Dim S As String = ""


        S = S + "D"
        S = S + "a"
        S = S + "l"
        S = S + "e"
        S = S + "A"
        S = S + "n"
        S = S + "d"
        S = S + "L"
        S = S + "i"
        S = S + "z"
        S = S + "M"
        S = S + "a"
        S = S + "d"
        S = S + "e"
        S = S + "T"
        S = S + "h"
        S = S + "i"
        S = S + "s"
        S = S + "H"
        S = S + "a"
        S = S + "p"
        S = S + "p"
        S = S + "e"
        S = S + "n"
        S = S + "!"


        Return S
    End Function
    Public Function DecryptTripleDES128(ByVal sOut As String, ByRef B As Boolean) As String
        Try
            Dim sKey As String = xmp2rt21()
            Dim DES As New System.Security.Cryptography.TripleDESCryptoServiceProvider
            Dim hashMD5 As New System.Security.Cryptography.MD5CryptoServiceProvider


            ' scramble the key
            sKey = ScrambleKey(sKey)
            ' Compute the MD5 hash.
            DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey))
            ' Set the cipher mode.
            DES.Mode = System.Security.Cryptography.CipherMode.ECB
            ' Create the decryptor.
            Dim DESDecrypt As System.Security.Cryptography.ICryptoTransform = DES.CreateDecryptor()
            Dim Buffer As Byte() = Convert.FromBase64String(sOut)
            ' Transform and return the string.
            Return System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
        Catch ex As Exception
            MessageBox.Show("clsEncrypt : DecryptTripleDES : 141 : " + ex.Message)
            Return ""
        End Try
    End Function
End Class

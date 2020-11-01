Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Security.Cryptography
Imports System.IO

Namespace ECMEncryption
    Public Class ECMEncrypt
        Private Shared ReadOnly Encoding1252 As Encoding = Encoding.GetEncoding(1252)
        Private SHA3 As ECMEncryption.SHA3Crypto = New ECMEncryption.SHA3Crypto()
        Private aes As ECMEncryption.AES = New ECMEncryption.AES()
        Private RC As Integer = 0
        Private RetMsg As String = ""
        Private ddebug As Boolean = False
        Private BlockSize As Integer = 128
        Private IV As Byte() = {1, 4, 1, 4, 2, 1, 3, 5, 6, 2, 3, 7, 3, 0, 9, 5}

        Private Function getPw() As String
            Dim x As String = ""
            x += "N"
            x += "o"
            x += "w"
            x += "I"
            x += "s"
            x += "T"
            x += "h"
            x += "e"
            x += "T"
            x += "i"
            x += "m"
            x += "e"
            x += "F"
            x += "o"
            x += "r"
            x += "A"
            x += "l"
            x += "l"
            x += "Y"
            x += "o"
            x += "u"
            x += "n"
            x += "g"
            x += "M"
            x += "e"
            x += "n"
            Return x
        End Function

        Public Function AES256EncryptString(ByVal plainText As String) As String
            Dim mySHA256 As SHA256 = SHA256.Create()
            Dim key256 As Byte() = mySHA256.ComputeHash(Encoding.ASCII.GetBytes(getPw()))

            ' Instantiate a new Aes object to perform string symmetric encryption
            Dim encryptor As Aes = Cryptography.Aes.Create()
            encryptor.Mode = CipherMode.CBC

            ' Set key and IV
            Dim aesKey As Byte() = New Byte(31) {}
            Array.Copy(key256, 0, aesKey, 0, 32)
            encryptor.Key = aesKey
            encryptor.IV = IV

            ' Instantiate a new MemoryStream object to contain the encrypted bytes
            Dim memoryStream As MemoryStream = New MemoryStream()

            ' Instantiate a new encryptor from our Aes object
            Dim aesEncryptor As ICryptoTransform = encryptor.CreateEncryptor()

            ' Instantiate a new CryptoStream object to process the data and write it to the 
            ' memory stream
            Dim cryptoStream As CryptoStream = New CryptoStream(memoryStream, aesEncryptor, CryptoStreamMode.Write)

            ' Convert the plainText string into a byte array
            Dim plainBytes As Byte() = Encoding.ASCII.GetBytes(plainText)

            ' Encrypt the input plaintext string
            cryptoStream.Write(plainBytes, 0, plainBytes.Length)

            ' Complete the encryption process
            cryptoStream.FlushFinalBlock()

            ' Convert the encrypted data from a MemoryStream to a byte array
            Dim cipherBytes As Byte() = memoryStream.ToArray()

            ' Close both the MemoryStream and the CryptoStream
            memoryStream.Close()
            cryptoStream.Close()

            ' Convert the encrypted byte array to a base64 encoded string
            Dim cipherText As String = Convert.ToBase64String(cipherBytes, 0, cipherBytes.Length)

            ' Return the encrypted data as a string
            Return cipherText
        End Function

        Public Sub log(ByVal msg As String)
            msg += Date.Now.ToString() & " : " & msg
            Dim tfqn As String = "C:\temp\ENC.Log.txt"

            Using file As StreamWriter = New StreamWriter(tfqn, True)
                file.WriteLine(msg)
            End Using
        End Sub

        Public Function AES256DecryptString(ByVal cipherText As String, ByVal Optional ddbug As Integer = 0) As String
            If ddebug.Equals(1) Then log("AES256DecryptString 01")
            Dim mySHA256 As SHA256 = SHA256.Create()
            Dim key256 As Byte() = mySHA256.ComputeHash(Encoding.ASCII.GetBytes(getPw()))
            If ddebug.Equals(1) Then log("AES256DecryptString 02")
            ' Instantiate a new Aes object to perform string symmetric encryption
            Dim encryptor As Aes = Cryptography.Aes.Create()
            encryptor.Mode = CipherMode.CBC
            If ddebug.Equals(1) Then log("AES256DecryptString 03")
            ' Set key256 and IV
            Dim aesKey As Byte() = New Byte(31) {}
            Array.Copy(key256, 0, aesKey, 0, 32)
            encryptor.Key = aesKey
            encryptor.IV = IV
            If ddebug.Equals(1) Then log("AES256DecryptString 04")
            ' Instantiate a new MemoryStream object to contain the encrypted bytes
            Dim memoryStream As MemoryStream = New MemoryStream()
            If ddebug.Equals(1) Then log("AES256DecryptString 05")
            ' Instantiate a new encryptor from our Aes object
            Dim aesDecryptor As ICryptoTransform = encryptor.CreateDecryptor()
            If ddebug.Equals(1) Then log("AES256DecryptString 06")
            ' Instantiate a new CryptoStream object to process the data and write it to the 
            ' memory stream
            Dim cryptoStream As CryptoStream = New CryptoStream(memoryStream, aesDecryptor, CryptoStreamMode.Write)
            If ddebug.Equals(1) Then log("AES256DecryptString 07")
            ' Will contain decrypted plaintext
            Dim plainText As String = String.Empty
            Dim bSuccess As Boolean = True
            If ddebug.Equals(1) Then log("AES256DecryptString 08")

            Try
                If ddebug.Equals(1) Then log("AES256DecryptString 09")
                ' Convert the ciphertext string into a byte array
                Dim cipherBytes As Byte() = Convert.FromBase64String(cipherText)
                If ddebug.Equals(1) Then log("AES256DecryptString 10")
                ' Decrypt the input ciphertext string
                cryptoStream.Write(cipherBytes, 0, cipherBytes.Length)

                Try
                    If ddebug.Equals(1) Then log("AES256DecryptString 11")
                    ' Complete the decryption process
                    cryptoStream.FlushFinalBlock()
                Catch ex As Exception
                    bSuccess = False
                    If ddebug.Equals(1) Then log("ERROR: AES256DecryptString 12")
                    If ddebug.Equals(1) Then log(ex.Message)
                End Try

                If bSuccess.Equals(True) Then
                    If ddebug.Equals(1) Then log("ERROR: AES256DecryptString 13")
                    ' Convert the decrypted data from a MemoryStream to a byte array
                    Dim plainBytes As Byte() = memoryStream.ToArray()
                    If ddebug.Equals(1) Then log("ERROR: AES256DecryptString 14")
                    ' Convert the decrypted byte array to string
                    plainText = Encoding.ASCII.GetString(plainBytes, 0, plainBytes.Length)
                End If

            Finally
                If ddebug.Equals(1) Then log("ERROR: AES256DecryptString 15")
                ' Close both the MemoryStream and the CryptoStream
                memoryStream.Close()
                cryptoStream.Close()
            End Try

            If ddebug.Equals(1) Then log("ERROR: AES256DecryptString 16")
            ' Return the decrypted data as a string
            Return plainText
        End Function

        Public Function SHA3Encrypt(ByVal str As String) As String
            Return SHA3.Encrypt(str, getPw())
        End Function

        Public Function SHA3Decrypt(ByVal str As String) As String
            Return SHA3.Decrypt(str, getPw())
        End Function

        Public Function aesEncrypt(ByVal original As String) As String
            Dim str As String = aes.Encrypt(original)
            Return str
        End Function

        Public Function aesDecrypt(ByVal encstr As String) As String
            Dim str As String = aes.Decrypt(encstr)
            Return str
        End Function

        Private Function EncryptStringToBytes_Aes(ByVal plainText As String, ByVal Key As Byte(), ByVal IV As Byte()) As Byte()
            ' Check arguments. 
            If Equals(plainText, Nothing) OrElse plainText.Length <= 0 Then Throw New ArgumentNullException("plainText")
            If Key Is Nothing OrElse Key.Length <= 0 Then Throw New ArgumentNullException("Key")
            If IV Is Nothing OrElse IV.Length <= 0 Then Throw New ArgumentNullException("Key")
            Dim encrypted As Byte()

            ' Create an AesCryptoServiceProvider object 
            ' with the specified key and IV. 
            Using aesAlg As AesCryptoServiceProvider = New AesCryptoServiceProvider()
                aesAlg.Key = Key
                aesAlg.IV = IV
                ' Create a decrytor to perform the stream transform.
                Dim encryptor As ICryptoTransform = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV)

                ' Create the streams used for encryption. 
                Using msEncrypt As MemoryStream = New MemoryStream()

                    Using csEncrypt As CryptoStream = New CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write)

                        Using swEncrypt As StreamWriter = New StreamWriter(csEncrypt)
                            'Write all data to the stream.
                            swEncrypt.Write(plainText)
                        End Using

                        encrypted = msEncrypt.ToArray()
                    End Using
                End Using
            End Using

            ' Return the encrypted bytes from the memory stream. 
            Return encrypted
        End Function

        Private Function DecryptStringFromBytes_Aes(ByVal cipherText As Byte(), ByVal Key As Byte(), ByVal IV As Byte()) As String
            ' Check arguments. 
            If cipherText Is Nothing OrElse cipherText.Length <= 0 Then Throw New ArgumentNullException("cipherText")
            If Key Is Nothing OrElse Key.Length <= 0 Then Throw New ArgumentNullException("Key")
            If IV Is Nothing OrElse IV.Length <= 0 Then Throw New ArgumentNullException("IV")
            ' Declare the string used to hold 
            ' the decrypted text. 
            Dim plaintext As String = Nothing

            ' Create an AesCryptoServiceProvider object 
            ' with the specified key and IV. 
            Using aesAlg As AesCryptoServiceProvider = New AesCryptoServiceProvider()
                aesAlg.Key = Key
                aesAlg.IV = IV
                ' Create a decrytor to perform the stream transform.
                Dim decryptor As ICryptoTransform = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV)

                ' Create the streams used for decryption. 
                Using msDecrypt As MemoryStream = New MemoryStream(cipherText)

                    Using csDecrypt As CryptoStream = New CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read)

                        Using srDecrypt As StreamReader = New StreamReader(csDecrypt)
                            ' Read the decrypted bytes from the decrypting stream 
                            ' and place them in a string.
                            plaintext = srDecrypt.ReadToEnd()
                        End Using
                    End Using
                End Using
            End Using

            Return plaintext
        End Function

        'public string AES.(string str)
        '{
        '    byte[] byt = System.Text.Encoding.UTF8.GetBytes(str);
        '    string strModified = Convert.ToBase64String(byt);
        '    return strModified;
        '}

        Public Function ToBase64(ByVal str As String) As String
            Dim byt As Byte() = Encoding.UTF8.GetBytes(str)
            Dim strModified As String = Convert.ToBase64String(byt)
            Return strModified
        End Function

        Public Function FromBase64(ByVal str As String) As String
            Dim b As Byte() = Convert.FromBase64String(str)
            Dim strOriginal As String = Encoding.UTF8.GetString(b)
            Return strOriginal
        End Function

        Public Function EncryptTripleDES(ByVal TextToEncrypt As String) As String
            Try
                Dim mysecurityKey As String = getPw()
                Dim MyEncryptedArray As Byte() = Encoding.UTF8.GetBytes(TextToEncrypt)
                Dim MyMD5CryptoService As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()
                Dim MysecurityKeyArray As Byte() = MyMD5CryptoService.ComputeHash(Encoding.UTF8.GetBytes(mysecurityKey))
                MyMD5CryptoService.Clear()
                Dim MyTripleDESCryptoService = New TripleDESCryptoServiceProvider()
                MyTripleDESCryptoService.Key = MysecurityKeyArray
                MyTripleDESCryptoService.Mode = CipherMode.ECB
                MyTripleDESCryptoService.Padding = PaddingMode.PKCS7
                Dim MyCrytpoTransform = MyTripleDESCryptoService.CreateEncryptor()
                Dim MyresultArray As Byte() = MyCrytpoTransform.TransformFinalBlock(MyEncryptedArray, 0, MyEncryptedArray.Length)
                MyTripleDESCryptoService.Clear()
                Return Convert.ToBase64String(MyresultArray, 0, MyresultArray.Length)
            Catch ex As Exception
                Return ex.Message
            End Try
        End Function

        Public Function DecryptTripleDES(ByVal TextToDecrypt As String) As String
            Try
                Dim mysecurityKey As String = getPw()
                Dim MyDecryptArray As Byte() = Convert.FromBase64String(TextToDecrypt)
                Dim MyMD5CryptoService As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()
                Dim MysecurityKeyArray As Byte() = MyMD5CryptoService.ComputeHash(Encoding.UTF8.GetBytes(mysecurityKey))
                MyMD5CryptoService.Clear()
                Dim MyTripleDESCryptoService = New TripleDESCryptoServiceProvider()
                MyTripleDESCryptoService.Key = MysecurityKeyArray
                MyTripleDESCryptoService.Mode = CipherMode.ECB
                MyTripleDESCryptoService.Padding = PaddingMode.PKCS7
                Dim MyCrytpoTransform = MyTripleDESCryptoService.CreateDecryptor()
                Dim MyresultArray As Byte() = MyCrytpoTransform.TransformFinalBlock(MyDecryptArray, 0, MyDecryptArray.Length)
                MyTripleDESCryptoService.Clear()
                Return Encoding.UTF8.GetString(MyresultArray)
            Catch ex As Exception
                Return ex.Message
            End Try
        End Function

        Public Function AESDecryptPhrase(ByVal Phrase As String, ByVal pw As String) As String
            If pw.Length.Equals(0) Then pw = getPw()
            If Phrase.Equals("") Then Return ""
            'Decrypt

            Dim bytes As Byte() = Convert.FromBase64String(Phrase)
            Dim crypt As SymmetricAlgorithm = Cryptography.Aes.Create()
            Dim hash As HashAlgorithm = MD5.Create()
            crypt.Key = hash.ComputeHash(Encoding.Unicode.GetBytes(pw))
            crypt.IV = IV

            Using memoryStream As MemoryStream = New MemoryStream(bytes)

                Using cryptoStream As CryptoStream = New CryptoStream(memoryStream, crypt.CreateDecryptor(), CryptoStreamMode.Read)
                    Dim decryptedBytes As Byte() = New Byte(bytes.Length - 1) {}
                    cryptoStream.Read(decryptedBytes, 0, decryptedBytes.Length)
                    Phrase = Encoding.Unicode.GetString(decryptedBytes)
                End Using
            End Using

            Return Phrase.Substring(0, Phrase.Length - 1)
        End Function

        Public Function AESEncryptPhrase(ByVal Phrase As String, ByVal pw As String) As String
            If pw.Length.Equals(0) Then pw = getPw()
            Dim S As String = ""
            Dim bytes As Byte() = Encoding.Unicode.GetBytes(Phrase)
            'Encrypt
            Dim crypt As SymmetricAlgorithm = Cryptography.Aes.Create()
            Dim hash As HashAlgorithm = MD5.Create()
            crypt.BlockSize = BlockSize
            crypt.Key = hash.ComputeHash(Encoding.Unicode.GetBytes(pw))
            crypt.IV = IV

            Using memoryStream As MemoryStream = New MemoryStream()

                Using cryptoStream As CryptoStream = New CryptoStream(memoryStream, crypt.CreateEncryptor(), CryptoStreamMode.Write)
                    cryptoStream.Write(bytes, 0, bytes.Length)
                End Using

                S = Convert.ToBase64String(memoryStream.ToArray())
            End Using

            Return S
        End Function

        Public Function EncryptPhrase(ByVal Phrase As String) As String
            If Phrase.Equals(Nothing) Then
                Return ""
            End If

            If Phrase.Trim().Equals("") Then
                Return ""
            End If

            Dim S As String = ""
            Dim I As Integer = 0
            Dim CH As String = ""
            Dim SIC As String = ""
            Dim IC As Integer = 0

            Try

                For I = 0 To Phrase.Length - 1
                    IC = 0
                    CH = Phrase.Substring(I, 1)
                    IC = Convert.ToInt32(Convert.ToChar(CH))
                    IC = IC + 88
                    SIC = IC.ToString()

                    If SIC.Length < 2 Then
                        SIC = "00" & SIC
                    End If

                    If SIC.Length < 3 Then
                        SIC = "0" & SIC
                    End If

                    S += SIC
                Next

            Catch ex As Exception
                S = "ERROR 100xx01: " & ex.Message
            End Try

            Return S
        End Function

        Public Function Reverse(ByVal value As String) As String
            ' Convert to char array.
            Dim arr As Char() = value.ToCharArray()
            ' Use Array.Reverse function.
            Array.Reverse(arr)
            ' Construct new string.
            Return New String(arr)
        End Function

        Public Function EncryptPhraseShift(ByVal Phrase As String, ByVal shiftKey As String) As String
            Dim S As String = ""
            Dim I As Integer = 0
            Dim K As Integer = 0
            Dim CH As String = ""
            Dim WCH As String = ""
            Dim KCH As String = ""
            Dim SIC As String = ""
            Dim IC As Integer = 0
            Dim KIC As Integer = 0

            If shiftKey.Length.Equals(0) Then
                shiftKey = getPw()
            End If

            Dim RevshiftKey As String = Reverse(shiftKey)
            Dim sKey As String = shiftKey & RevshiftKey

            Try

                For I = 0 To Phrase.Length - 1

                    If K >= sKey.Length - 1 Then
                        K = 0
                    End If

                    IC = 0
                    CH = Phrase.Substring(I, 1)
                    KCH = sKey.Substring(K, 1)
                    IC = Convert.ToInt32(Convert.ToChar(CH))
                    KIC = Convert.ToInt32(Convert.ToChar(KCH))
                    IC = IC + 88 + KIC
                    SIC = IC.ToString()
                    WCH += Convert.ToString(Convert.ToInt32(SIC))
                    S += SIC
                    K += 1
                Next

            Catch ex As Exception
                Return "ERROR 100xx02: " & ex.Message
            End Try

            Return WCH
        End Function

        Public Function EncryptPhraseV1(ByVal Phrase As String, ByVal shiftKey As String) As String
            Dim S As String = ""
            Dim I As Integer = 0
            Dim K As Integer = 0
            Dim CH As String = ""
            Dim KCH As String = ""
            Dim SIC As String = ""
            Dim IC As Integer = 0
            Dim KIC As Integer = 0
            Dim RevshiftKey As String = Reverse(shiftKey)
            shiftKey = shiftKey & RevshiftKey

            Try

                For I = 0 To Phrase.Length - 1

                    If K >= shiftKey.Length Then
                        K = 0
                    End If

                    IC = 0
                    CH = Phrase.Substring(I, 1)
                    KCH = shiftKey.Substring(K, 1)
                    IC = Convert.ToInt32(Convert.ToChar(CH))
                    KIC = Convert.ToInt32(Convert.ToChar(KCH))
                    IC = IC + 88 + KIC
                    SIC = IC.ToString()

                    If SIC.Length < 2 Then
                        SIC = "00" & SIC
                    End If

                    If SIC.Length < 3 Then
                        SIC = "0" & SIC
                    End If

                    S += SIC
                    K += 1
                Next

            Catch ex As Exception
                'MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + SIC);
                Return "ERROR 100xx03: " & ex.Message
            End Try

            Return S
        End Function

        Public Function DecryptPhrase(ByVal Phrase As String, ByVal shiftKey As String) As String
            Dim S As String = ""
            Dim I As Integer = 0
            Dim K As Integer = 0
            Dim CH As String = ""
            Dim KCH As String = ""
            Dim IC As Integer = 0
            Dim IC2 As Integer = 0
            Dim CHX As String = ""

            'int KIC = 0;

            If shiftKey.Length.Equals(0) Then
                shiftKey = getPw()
            End If

            Dim RevshiftKey As String = Reverse(shiftKey)
            shiftKey = shiftKey & RevshiftKey

            Try

                For I = 0 To Phrase.Length - 1

                    If K >= shiftKey.Length Then
                        K = 0
                    End If

                    CH = Phrase.Substring(I, 1)
                    KCH = shiftKey.Substring(K, 1)
                    IC = Convert.ToInt32(Convert.ToChar(CH))
                    IC2 = Convert.ToInt32(Convert.ToChar(KCH))
                    IC = IC - 88 - IC2
                    CHX = Convert.ToString(Convert.ToChar(IC))
                    S += CHX
                    K += 1
                Next

            Catch ex As Exception
                'MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                Return "ERROR 100xx04: " & ex.Message
            End Try

            Return S
        End Function

        Public Function DecryptPhrase(ByVal Phrase As String) As String
            Dim S As String = ""
            Dim I As Integer = 0
            Dim CH As String = ""
            Dim IC As Integer = 0
            Dim CHX As Char

            Try

                For I = 0 To Phrase.Length - 1 Step 3
                    CH = Phrase.Substring(I, 3)
                    IC = Convert.ToInt32(CH)
                    'IC = Convert.ToInt32 (Convert.ToChar (CH));
                    IC = IC - 88
                    'CHX = System.Convert.ToString (Convert.ToChar (IC));
                    CHX = Convert.ToChar(IC)
                    S += CHX
                    'I += 2
                Next

            Catch ex As Exception
                'MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                Return "ERROR 100ZZ2: " & ex.Message
            End Try

            Return S
        End Function

        Public Function DecryptPhrase2(ByVal Phrase As String) As String
            Dim S As String = ""
            Dim I As Integer = 0
            Dim CH As String = ""
            Dim IC As Integer = 0
            Dim CHX As String = ""

            Try

                For I = 0 To Phrase.Length - 1 Step 3
                    CH = Phrase.Substring(I, 3)
                    IC = Convert.ToInt32(Convert.ToChar(CH))
                    IC = IC - 88
                    CHX = Convert.ToString(Convert.ToChar(IC))
                    S += CHX
                    'I += 2
                Next

            Catch ex As Exception
                'MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                Return "ERROR 100X02: " & ex.Message
            End Try

            Return S
        End Function

        Private Shared Function ScrambleKey(ByVal v_strKey As String) As String
            Dim sbKey As StringBuilder = New StringBuilder()
            Dim intPtr As Integer = 0

            For intPtr = 1 To v_strKey.Length
                Dim intIn As Integer = v_strKey.Length - intPtr + 1
                sbKey.Append(v_strKey.Substring(intIn - 1, 1))
            Next

            Dim strKey As String = Convert.ToString(sbKey.ToString())
            Return sbKey.ToString()
        End Function

        Public Function EncryptPhrase(ByVal sOut As String, ByRef RC As Boolean, ByRef RetMsg As String) As String
            If sOut.Length = 0 Then
                Return ""
            End If

            Dim sKey As String = getPw()
            Dim DES As TripleDESCryptoServiceProvider = New TripleDESCryptoServiceProvider()
            Dim hashMD5 As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()
            RC = True
            sKey = Convert.ToString(ScrambleKey(sKey))
            DES.Key = hashMD5.ComputeHash(Encoding.ASCII.GetBytes(sKey))
            DES.Mode = CipherMode.ECB
            Dim DESDecrypt As ICryptoTransform = DES.CreateDecryptor()
            Dim Buffer As Byte() = Convert.FromBase64String(sOut)
            Dim S As String = ""

            Try
                S = Convert.ToString(Encoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)))
            Catch __unusedException1__ As Exception
                RetMsg = "EncryptPhrase - Error in decrypting string."
                RC = False
                S = ""
            End Try

            Return S
        End Function


        'public string EncryptPhrase (string sOut)
        '{
        '    string pw = getPw ();
        '    return EncryptPhrase (sOut, pw);
        '}

        Public Function EncryptPhrase(ByVal sOut As String, ByVal pw As String) As String
            If sOut.Length = 0 Then
                Return ""
            End If

            If pw.Length.Equals(0) Then getPw()
            Dim DES As TripleDESCryptoServiceProvider = New TripleDESCryptoServiceProvider()
            Dim hashMD5 As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()
            RC = 0
            Dim sKey As String = Convert.ToString(ScrambleKey(pw))
            DES.Key = hashMD5.ComputeHash(Encoding.ASCII.GetBytes(sKey))
            DES.Mode = CipherMode.ECB
            Dim DESDecrypt As ICryptoTransform = DES.CreateDecryptor()
            Dim Buffer As Byte() = Convert.FromBase64String(sOut)
            Dim S As String = ""

            Try
                S = Convert.ToString(Encoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)))
            Catch __unusedException1__ As Exception
                RetMsg = "EncryptPhrase - Error in decrypting string."
                RC = -1
                S = ""
            End Try

            Return S
        End Function

        Public Function EncryptPhraseB64(ByVal sIn As String) As String
            Dim sKey As String = getPw()
            Dim DES As TripleDESCryptoServiceProvider = New TripleDESCryptoServiceProvider()
            Dim hashMD5 As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()
            sKey = Convert.ToString(ScrambleKey(sKey))
            DES.Key = hashMD5.ComputeHash(Encoding.ASCII.GetBytes(sKey))
            DES.Mode = CipherMode.ECB
            Dim DESEncrypt As ICryptoTransform = DES.CreateEncryptor()
            Dim Buffer As Byte() = Encoding.ASCII.GetBytes(sIn)
            Return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
        End Function


        'public String EncryptPhrase(String sIn, String sKey)
        '{
        '    if (sIn.Length == 0)
        '    {
        '        return "";
        '    }
        '    TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
        '    MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();
        '    sKey = System.Convert.ToString(ScrambleKey(sKey));
        '    DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
        '    DES.Mode = System.Security.Cryptography.CipherMode.ECB;
        '    ICryptoTransform DESEncrypt = DES.CreateEncryptor();
        '    Byte[] Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn);
        '    return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
        '}

        Public Function hashSha1File(ByVal FQN As String) As String
            FQN = FQN.Replace("''", "'")
            Dim hashResult As String = String.Empty
            Dim FI As FileInfo = New FileInfo(FQN)
            Dim fSize As Integer = Convert.ToInt32(FI.Length)
            FI = Nothing
            GC.Collect()
            Dim BUF_SIZE As Integer = 32
            Dim dataArray As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim FileBuffer As Byte() = New Byte(fSize + 1 - 1) {}
            Dim sha As SHA1CryptoServiceProvider = New SHA1CryptoServiceProvider()
            Dim f As FileStream = Nothing
            f = New FileStream(FQN, FileMode.Open, FileAccess.Read)
            f.Read(FileBuffer, 0, fSize - 1)
            Dim result As Byte() = sha.ComputeHash(dataArray)
            f.Close()
            f.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
            hashResult = Convert.ToString(BitConverter.ToString(sha.Hash).Replace("-", "").ToLower())
            'Console.WriteLine("Length: " + hashResult.Length.ToString() + "    : " + hashResult);
            Return hashResult
        End Function

        Public Function hashCrc32(ByVal filePath As String) As String
            Dim BUF_SIZE As Integer = 32
            Dim dataBuffer As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim dataBufferDummy As Byte() = New Byte(BUF_SIZE - 1) {}
            'int dataBytesRead = 0;
            Dim hashResult As String = String.Empty
            'HashAlgorithm hashAlg = null;
            'FileStream fs = null;

            Dim f = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 8192)
            Dim sha1 = New SHA1CryptoServiceProvider()
            Dim Sha1Hash As Byte() = sha1.ComputeHash(f)
            hashResult = Convert.ToString(BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower())
            f.Close()
            f.Dispose()
            GC.Collect()
            Return hashResult
        End Function

        Public Function hashSha1FileV2(ByVal filePath As String) As String
            Dim BUF_SIZE As Integer = 32
            Dim dataBuffer As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim dataBufferDummy As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim dataBytesRead As Integer = 0
            Dim hashResult As String = String.Empty
            Dim hashAlg As HashAlgorithm = Nothing
            Dim fs As FileStream = Nothing

            Try
                hashAlg = New SHA1CryptoServiceProvider()
                fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)

                Do
                    dataBytesRead = Convert.ToInt32(fs.Read(dataBuffer, 0, BUF_SIZE))
                    hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
                Loop While Not dataBytesRead = 0

                hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
                hashResult = Convert.ToString(BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower())
            Catch ex As IOException
                Return "ZZ001: " & ex.Message
            Catch ex As UnauthorizedAccessException
                Return "ZZ002: " & ex.Message
            Finally

                If Not ReferenceEquals(fs, Nothing) Then
                    fs.Close()
                    fs.Dispose()
                    fs = Nothing
                End If

                If Not ReferenceEquals(hashAlg, Nothing) Then
                    hashAlg.Clear() 'Dispose()
                    hashAlg = Nothing
                End If
            End Try

            Return hashResult
        End Function

        Public Function hashMd5File(ByVal filePath As String) As String
            Dim BUF_SIZE As Integer = 32
            Dim dataBuffer As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim dataBufferDummy As Byte() = New Byte(BUF_SIZE - 1) {}
            Dim dataBytesRead As Integer = 0
            Dim hashResult As String = String.Empty
            Dim hashAlg As HashAlgorithm = Nothing
            Dim fs As FileStream = Nothing

            Try
                hashAlg = New MD5CryptoServiceProvider()
                fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)

                Do
                    dataBytesRead = Convert.ToInt32(fs.Read(dataBuffer, 0, BUF_SIZE))
                    hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
                Loop While Not dataBytesRead = 0

                hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
                hashResult = Convert.ToString(BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower())
            Catch ex As IOException
                Return "YY001: " & ex.Message
            Catch ex As UnauthorizedAccessException
                Return "UnauthorizedAccessException: " & ex.Message
            Finally

                Try
                    fs.Close()
                    fs.Dispose()
                    fs = Nothing
                Catch ex As Exception
                    Console.WriteLine("XX022: " & ex.Message)
                End Try

                Try
                    hashAlg.Clear() 'Dispose()
                    hashAlg = Nothing
                Catch ex As Exception
                    Console.WriteLine("XX011: " & ex.Message)
                End Try
            End Try

            Return hashResult
        End Function

        Public Function DecryptTripleDES128(ByVal sOut As String, ByVal B As Boolean) As String
            Try
                Dim sKey = xmp2rt21()
                Dim DES As TripleDESCryptoServiceProvider = New TripleDESCryptoServiceProvider()
                Dim hashMD5 As MD5CryptoServiceProvider = New MD5CryptoServiceProvider()


                ' scramble the key
                sKey = ScrambleKey(sKey)
                ' Compute the MD5 hash.
                DES.Key = hashMD5.ComputeHash(Encoding.ASCII.GetBytes(sKey))
                ' Set the cipher mode.
                DES.Mode = CipherMode.ECB
                ' Create the decryptor.
                Dim DESDecrypt As ICryptoTransform = DES.CreateDecryptor()
                Dim Buffer As Byte() = Convert.FromBase64String(sOut)
                ' Transform and return the string.
                Return Encoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length))
            Catch ex As Exception
                Return "clsEncrypt : EncryptPhrase : 141 : " & ex.Message
            End Try
        End Function

        Private Function xmp2rt21() As String
            Dim S As String = ""
            S = S & "D"
            S = S & "a"
            S = S & "l"
            S = S & "e"
            S = S & "A"
            S = S & "n"
            S = S & "d"
            S = S & "L"
            S = S & "i"
            S = S & "z"
            S = S & "M"
            S = S & "a"
            S = S & "d"
            S = S & "e"
            S = S & "T"
            S = S & "h"
            S = S & "i"
            S = S & "s"
            S = S & "H"
            S = S & "a"
            S = S & "p"
            S = S & "p"
            S = S & "e"
            S = S & "n"
            S = S & "!"
            Return S
        End Function

        Public Function xt001trc(ByVal S As String, ByVal Optional ddebug As Integer = 0) As SortedList(Of String, String)
            Dim A As SortedList(Of String, String) = New SortedList(Of String, String)()
            'bool B = false;
            Dim SS As String = ""
            Dim tKey As String = ""
            Dim tVal As String = ""
            SS = AES256DecryptString(S, ddebug)
            Dim AR As Object() = SS.Split("|"c)

            For i As Integer = 1 To AR.Length - 1

                If i = 0 Then
                    Console.WriteLine("here")
                ElseIf i Mod 2 <> 0 Then
                    tKey = AR(i).ToString().Trim()
                Else
                    tVal = AR(i).ToString().Trim()
                End If

                If i Mod 2 = 0 Then

                    Try
                        Dim iDx As Integer = Convert.ToInt32(A.ContainsKey(tKey))

                        If iDx <= 0 Then
                            A.Add(tKey, tVal)
                        End If

                    Catch ex As Exception
                        Console.WriteLine("clsEncrypt : xt001trc : 104 : " & ex.Message)
                    End Try
                End If
            Next

            Return A
        End Function

        Public Sub saveString(ByVal action As String, ByVal s As String)
            'bool b = true;
            Dim path As String = "c:\temp\encrypted.txt"

            If action.Equals("r") Then

                ' This text is added only once to the file.
                If File.Exists(path) Then
                    File.Delete(path)
                End If

                If Not File.Exists(path) Then

                    ' Create a file to write to.
                    Using sw As StreamWriter = File.CreateText(path)
                        sw.WriteLine(s)
                    End Using
                End If
            End If

            If action.Equals("a") Then

                ' This text is always added, making the file longer over time if it is not deleted.
                Using sw As StreamWriter = File.AppendText(path)
                    sw.WriteLine(s)
                End Using
            End If
        End Sub

        Private Function StrToByteArray(ByVal str As String) As Byte()
            Dim encoding As UTF8Encoding = New UTF8Encoding()
            Return encoding.GetBytes(str)
        End Function ' StrToByteArray
        Public Function getSha1HashKey(ByVal strToHash As String) As String
            Dim hashResult As String = String.Empty
            Dim BUF_SIZE As Integer = strToHash.Length
            Dim dataArray As Byte() = New Byte(BUF_SIZE - 1 + 1 - 1) {}
            Dim FileBuffer As Byte() = StrToByteArray(strToHash)
            Dim sha As SHA1CryptoServiceProvider = New SHA1CryptoServiceProvider()
            Dim result As Byte() = sha.ComputeHash(dataArray)
            GC.Collect()
            GC.WaitForPendingFinalizers()
            hashResult = BitConverter.ToString(sha.Hash).Replace("-", "").ToLower()
            ' Console.WriteLine("Length: " + hashResult.Length.ToString + "    : " + hashResult)
            Return hashResult
        End Function

        Public Function getSha1HashFromFile(ByVal FileFQN As String) As String
            Dim BUF_SIZE As Integer = 32
            Dim dataBuffer As Byte() = New Byte(BUF_SIZE - 1 + 1 - 1) {}
            Dim dataBufferDummy As Byte() = New Byte(BUF_SIZE - 1 + 1 - 1) {}
            'int dataBytesRead = 0;
            Dim hashResult As String = String.Empty
            'HashAlgorithm hashAlg = null/* TODO Change to default(_) if this is not a reference type */;
            'FileStream fs = null;

            Dim f = New FileStream(FileFQN, FileMode.Open, FileAccess.Read, FileShare.Read, 8192)
            Dim sha1 = New SHA1CryptoServiceProvider()
            Dim Sha1Hash As Byte() = sha1.ComputeHash(f)
            hashResult = BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower()
            f.Close()
            f.Dispose()
            GC.Collect()
            Return hashResult
        End Function

        Public Function GenerateSHA256String(ByVal inputString As String) As String
            Dim sha512 As SHA256 = SHA256.Create()
            Dim bytes As Byte() = Encoding.UTF8.GetBytes(inputString)
            Dim hash As Byte() = sha512.ComputeHash(bytes)
            Return GetHexStringFromHash(hash)
        End Function

        Public Function GenerateSHA256HashFromFile(ByVal FQN As String) As String
            FQN = "C:\temp\Channels.txt"
            Dim BUF_SIZE As Integer = 32
            Dim dataBuffer As Byte() = New Byte(BUF_SIZE - 1 + 1 - 1) {}
            Dim dataBufferDummy As Byte() = New Byte(BUF_SIZE - 1 + 1 - 1) {}
            Dim hashResult As String = String.Empty
            Dim f = New FileStream(FQN, FileMode.Open, FileAccess.Read, FileShare.Read, 8192)
            Dim sha256 As SHA256 = SHA256.Create() ' SHA256Managed.Create();

            'byte[] bytes = Encoding.UTF8.GetBytes(inputString);
            Dim hash As Byte() = sha256.ComputeHash(f)
            Dim s As String = GetHexStringFromHash(hash)
            Return s
        End Function

        Public Function GenerateSHA256HashFromFileV2(ByVal FQN As String) As String
            Dim sha256 As SHA256 = SHA256.Create()
            Dim fi As FileInfo = New FileInfo(FQN)
            Dim fl As Long = fi.Length
            fi = Nothing
            fl = fl - 1    'SQL Server stores all but the last EOF byte in the FileStream store.
            Dim buffer As Byte() = New Byte(fl - 1) {}

            Using fs = New FileStream(FQN, FileMode.Open, FileAccess.Read, FileShare.Read)
                fs.Read(buffer, 0, fl)
            End Using

            Dim filehash As Byte() = sha256.ComputeHash(buffer)
            sha256.Dispose()
            Dim shash As String = GetHexStringFromHash(filehash)
            shash = "0x" & shash
            Return shash
        End Function

        Public Function GenerateSHA512StringV2(ByVal inputString As String) As String
            Dim sha512 As SHA512 = New SHA512Managed()
            Dim bytes As Byte() = Encoding.Unicode.GetBytes(inputString)
            Dim hash As Byte() = sha512.ComputeHash(bytes)
            Dim s As String = GetHexStringFromHash(hash)
            Return s
        End Function

        Public Function SHA512String(ByVal inputString As String) As String
            Dim hex As String = ""
            Dim DATA_SIZE As Integer = 125
            Dim data As Byte() = New Byte(DATA_SIZE - 1) {}
            Dim result As Byte()
            Dim shaM As SHA512 = New SHA512Managed()
            result = shaM.ComputeHash(data)
            hex = GetHexStringFromHash(result)
            Return hex
        End Function

        Public Function SHA512SqlServerHash(ByVal s As String) As String
            Dim bytes As Byte() = Encoding1252.GetBytes(s)
            Dim MgtSha As SHA512 = New SHA512Managed()
            Dim hashBytes As Byte() = MgtSha.ComputeHash(bytes)
            Dim HashStr As String = GetHexStringFromHash(hashBytes)
            Return HashStr
        End Function

        Public Function GenerateSHA512HashFromFile(ByVal FQN As String) As String
            Dim LL As Integer = 0
            Dim fl As Long = 0

            Try
                Dim shash As String = ComputeFileHash(FQN)
                Return shash
            Catch ex As Exception
                Console.WriteLine(ex.Message & ":" & LL.ToString() & " : " & fl.ToString())
                Dim shash As String = ComputeFileHash(FQN)
                Return shash
            End Try
        End Function


        'private string Bytes_To_String2(byte[] bytes_Input)
        '{
        '    StringBuilder strTemp = new StringBuilder(bytes_Input.Length * 2);
        '    foreach (byte b in bytes_Input)
        '        strTemp.Append(Conversion.Hex(b));
        '    return strTemp.ToString();
        '}

        Private Function ComputeFileHash(ByVal fileName As String) As String
            Dim S As String = ""
            Dim ourHash As Byte() = New Byte(0) {}

            ' If file exists, create a HashAlgorithm instance based off of MD5 encryption
            ' You could use a variant of SHA or RIPEMD160 if you like with larger hash bit sizes.
            If File.Exists(fileName) Then

                Try
                    Dim ourHashAlg As HashAlgorithm = HashAlgorithm.Create("SHA512")
                    Dim fileToHash As FileStream = New FileStream(fileName, FileMode.Open, FileAccess.Read)
                    ' Compute the hash to return using the Stream we created.
                    ourHash = ourHashAlg.ComputeHash(fileToHash)
                    fileToHash.Close()
                    S = GetHexStringFromHash(ourHash)

                    If Not S.Substring(1, 2).Equals("0x") Then
                        S += "0x" & S
                    End If

                Catch ex As IOException
                    Console.WriteLine("There was an error opening the file: " & ex.Message)
                End Try
            End If

            If Not S.Substring(1, 2).Equals("0x") Then
                S += "0x" & S
            End If

            Return S
        End Function

        Private Function GetHexStringFromHash(ByVal hash As Byte()) As String
            Dim result As StringBuilder = New StringBuilder()

            For i As Integer = 0 To hash.Length - 1
                result.Append(hash(i).ToString("X2"))
            Next

            Return result.ToString()
        End Function
    End Class
End Namespace

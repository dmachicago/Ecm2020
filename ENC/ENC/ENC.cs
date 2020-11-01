using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.IO;

namespace ECMEncryption
{

    public class ECMEncrypt
    {

        private static readonly Encoding Encoding1252 = Encoding.GetEncoding(1252);
        SHA3Crypto SHA3 = new SHA3Crypto();
        AES aes = new AES();

        int RC = 0;
        string RetMsg = "";
        bool ddebug = false;

        int BlockSize = 128;
        byte[] IV = { 1, 4, 1, 4, 2, 1, 3, 5, 6, 2, 3, 7, 3, 0, 9, 5 };

        private string getPw()
        {
            string x = "";
            x += "N";
            x += "o";
            x += "w";
            x += "I";
            x += "s";
            x += "T";
            x += "h";
            x += "e";
            x += "T";
            x += "i";
            x += "m";
            x += "e";
            x += "F";
            x += "o";
            x += "r";
            x += "A";
            x += "l";
            x += "l";
            x += "Y";
            x += "o";
            x += "u";
            x += "n";
            x += "g";
            x += "M";
            x += "e";
            x += "n";
            return x;
        }

        public string AES256EncryptString(string plainText)
        {
            SHA256 mySHA256 = SHA256Managed.Create();
            byte[] key256 = mySHA256.ComputeHash(Encoding.ASCII.GetBytes(getPw()));

            // Instantiate a new Aes object to perform string symmetric encryption
            Aes encryptor = Aes.Create();

            encryptor.Mode = CipherMode.CBC;

            // Set key and IV
            byte[] aesKey = new byte[32];
            Array.Copy(key256, 0, aesKey, 0, 32);
            encryptor.Key = aesKey;
            encryptor.IV = IV;

            // Instantiate a new MemoryStream object to contain the encrypted bytes
            MemoryStream memoryStream = new MemoryStream();

            // Instantiate a new encryptor from our Aes object
            ICryptoTransform aesEncryptor = encryptor.CreateEncryptor();

            // Instantiate a new CryptoStream object to process the data and write it to the 
            // memory stream
            CryptoStream cryptoStream = new CryptoStream(memoryStream, aesEncryptor, CryptoStreamMode.Write);

            // Convert the plainText string into a byte array
            byte[] plainBytes = Encoding.ASCII.GetBytes(plainText);

            // Encrypt the input plaintext string
            cryptoStream.Write(plainBytes, 0, plainBytes.Length);

            // Complete the encryption process
            cryptoStream.FlushFinalBlock();

            // Convert the encrypted data from a MemoryStream to a byte array
            byte[] cipherBytes = memoryStream.ToArray();

            // Close both the MemoryStream and the CryptoStream
            memoryStream.Close();
            cryptoStream.Close();

            // Convert the encrypted byte array to a base64 encoded string
            string cipherText = Convert.ToBase64String(cipherBytes, 0, cipherBytes.Length);

            // Return the encrypted data as a string
            return cipherText;
        }
        public void log(string msg)
        {
            msg += DateTime.Now.ToString() + " : " + msg;
            string tfqn = @"C:\temp\ENC.Log.txt";
            using (System.IO.StreamWriter file =
            new System.IO.StreamWriter(tfqn, true))
            {
                file.WriteLine(msg);
            }
        }
        public string AES256DecryptString(string cipherText, int ddbug = 0)
        {

            if (ddebug.Equals(1)) log("AES256DecryptString 01");
            SHA256 mySHA256 = SHA256Managed.Create();
            byte[] key256 = mySHA256.ComputeHash(Encoding.ASCII.GetBytes(getPw()));

            if (ddebug.Equals(1)) log("AES256DecryptString 02");
            // Instantiate a new Aes object to perform string symmetric encryption
            Aes encryptor = Aes.Create();

            encryptor.Mode = CipherMode.CBC;

            if (ddebug.Equals(1)) log("AES256DecryptString 03");
            // Set key256 and IV
            byte[] aesKey = new byte[32];
            Array.Copy(key256, 0, aesKey, 0, 32);
            encryptor.Key = aesKey;
            encryptor.IV = IV;

            if (ddebug.Equals(1)) log("AES256DecryptString 04");
            // Instantiate a new MemoryStream object to contain the encrypted bytes
            MemoryStream memoryStream = new MemoryStream();

            if (ddebug.Equals(1)) log("AES256DecryptString 05");
            // Instantiate a new encryptor from our Aes object
            ICryptoTransform aesDecryptor = encryptor.CreateDecryptor();

            if (ddebug.Equals(1)) log("AES256DecryptString 06");
            // Instantiate a new CryptoStream object to process the data and write it to the 
            // memory stream
            CryptoStream cryptoStream = new CryptoStream(memoryStream, aesDecryptor, CryptoStreamMode.Write);

            if (ddebug.Equals(1)) log("AES256DecryptString 07");
            // Will contain decrypted plaintext
            string plainText = String.Empty;
            bool bSuccess = true;
            if (ddebug.Equals(1)) log("AES256DecryptString 08");
            try
            {
                if (ddebug.Equals(1)) log("AES256DecryptString 09");
                // Convert the ciphertext string into a byte array
                byte[] cipherBytes = Convert.FromBase64String(cipherText);

                if (ddebug.Equals(1)) log("AES256DecryptString 10");
                // Decrypt the input ciphertext string
                cryptoStream.Write(cipherBytes, 0, cipherBytes.Length);

                try
                {
                    if (ddebug.Equals(1)) log("AES256DecryptString 11");
                    // Complete the decryption process
                    cryptoStream.FlushFinalBlock();
                }
                catch (Exception ex)
                {
                    bSuccess = false;
                    if (ddebug.Equals(1)) log("ERROR: AES256DecryptString 12");
                    if (ddebug.Equals(1)) log(ex.Message);
                }

                if (bSuccess.Equals(true))
                {
                    if (ddebug.Equals(1)) log("ERROR: AES256DecryptString 13");
                    // Convert the decrypted data from a MemoryStream to a byte array
                    byte[] plainBytes = memoryStream.ToArray();

                    if (ddebug.Equals(1)) log("ERROR: AES256DecryptString 14");
                    // Convert the decrypted byte array to string
                    plainText = Encoding.ASCII.GetString(plainBytes, 0, plainBytes.Length);
                }
            }
            finally
            {
                if (ddebug.Equals(1)) log("ERROR: AES256DecryptString 15");
                // Close both the MemoryStream and the CryptoStream
                memoryStream.Close();
                cryptoStream.Close();
            }

            if (ddebug.Equals(1)) log("ERROR: AES256DecryptString 16");
            // Return the decrypted data as a string
            return plainText;
        }

        public string SHA3Encrypt(string str)
        {
            return SHA3.Encrypt(str, getPw());
        }
        public string SHA3Decrypt(string str)
        {
            return SHA3.Decrypt(str, getPw());
        }

        public string aesEncrypt(string original)
        {
            string str = aes.Encrypt(original);
            return str;
        }
        public string aesDecrypt(string encstr)
        {
            string str = aes.Decrypt(encstr);
            return str;
        }
        byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");
            byte[] encrypted;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for encryption. 
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt =
                            new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }
            // Return the encrypted bytes from the memory stream. 
            return encrypted;
        }
        string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");
            // Declare the string used to hold 
            // the decrypted text. 
            string plaintext = null;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for decryption. 
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt =
                            new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            // Read the decrypted bytes from the decrypting stream 
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            return plaintext;
        }
        //public string AES.(string str)
        //{
        //    byte[] byt = System.Text.Encoding.UTF8.GetBytes(str);
        //    string strModified = Convert.ToBase64String(byt);
        //    return strModified;
        //}

        public string ToBase64(string str)
        {
            byte[] byt = System.Text.Encoding.UTF8.GetBytes(str);
            string strModified = Convert.ToBase64String(byt);
            return strModified;
        }
        public string FromBase64(string str)
        {
            byte[] b = Convert.FromBase64String(str);
            string strOriginal = System.Text.Encoding.UTF8.GetString(b);
            return strOriginal;
        }

        public string EncryptTripleDES(string TextToEncrypt)
        {
            try
            {
                string mysecurityKey = getPw();

                byte[] MyEncryptedArray = UTF8Encoding.UTF8
                   .GetBytes(TextToEncrypt);

                MD5CryptoServiceProvider MyMD5CryptoService = new
                   MD5CryptoServiceProvider();

                byte[] MysecurityKeyArray = MyMD5CryptoService.ComputeHash
                   (UTF8Encoding.UTF8.GetBytes(mysecurityKey));

                MyMD5CryptoService.Clear();

                var MyTripleDESCryptoService = new
                   TripleDESCryptoServiceProvider();

                MyTripleDESCryptoService.Key = MysecurityKeyArray;

                MyTripleDESCryptoService.Mode = CipherMode.ECB;

                MyTripleDESCryptoService.Padding = PaddingMode.PKCS7;

                var MyCrytpoTransform = MyTripleDESCryptoService
                   .CreateEncryptor();

                byte[] MyresultArray = MyCrytpoTransform
                   .TransformFinalBlock(MyEncryptedArray, 0,
                   MyEncryptedArray.Length);

                MyTripleDESCryptoService.Clear();

                return Convert.ToBase64String(MyresultArray, 0,
                   MyresultArray.Length);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

        public string DecryptTripleDES(string TextToDecrypt)
        {
            try
            {
                string mysecurityKey = getPw();

                byte[] MyDecryptArray = Convert.FromBase64String
                   (TextToDecrypt);

                MD5CryptoServiceProvider MyMD5CryptoService = new
                   MD5CryptoServiceProvider();

                byte[] MysecurityKeyArray = MyMD5CryptoService.ComputeHash
                   (UTF8Encoding.UTF8.GetBytes(mysecurityKey));

                MyMD5CryptoService.Clear();

                var MyTripleDESCryptoService = new
                   TripleDESCryptoServiceProvider();

                MyTripleDESCryptoService.Key = MysecurityKeyArray;

                MyTripleDESCryptoService.Mode = CipherMode.ECB;

                MyTripleDESCryptoService.Padding = PaddingMode.PKCS7;

                var MyCrytpoTransform = MyTripleDESCryptoService
                   .CreateDecryptor();

                byte[] MyresultArray = MyCrytpoTransform
                   .TransformFinalBlock(MyDecryptArray, 0,
                   MyDecryptArray.Length);

                MyTripleDESCryptoService.Clear();

                return UTF8Encoding.UTF8.GetString(MyresultArray);

            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        public string AESDecryptPhrase(string Phrase, string pw)
        {
            if (pw.Length.Equals(0))
                pw = getPw();

            if (Phrase.Equals("")) return "";
            //Decrypt

            byte[] bytes = Convert.FromBase64String(Phrase);
            SymmetricAlgorithm crypt = Aes.Create();
            HashAlgorithm hash = MD5.Create();
            crypt.Key = hash.ComputeHash(Encoding.Unicode.GetBytes(pw));
            crypt.IV = IV;

            using (MemoryStream memoryStream = new MemoryStream(bytes))
            {
                using (CryptoStream cryptoStream =
                   new CryptoStream(memoryStream, crypt.CreateDecryptor(), CryptoStreamMode.Read))
                {
                    byte[] decryptedBytes = new byte[bytes.Length];
                    cryptoStream.Read(decryptedBytes, 0, decryptedBytes.Length);
                    Phrase = Encoding.Unicode.GetString(decryptedBytes);
                }
            }
            return Phrase.Substring(0, Phrase.Length - 1);
        }
        public string AESEncryptPhrase(string Phrase, string pw)
        {
            if (pw.Length.Equals(0))
                pw = getPw();

            string S = "";
            byte[] bytes = Encoding.Unicode.GetBytes(Phrase);
            //Encrypt
            SymmetricAlgorithm crypt = Aes.Create();
            HashAlgorithm hash = MD5.Create();
            crypt.BlockSize = BlockSize;
            crypt.Key = hash.ComputeHash(Encoding.Unicode.GetBytes(pw));
            crypt.IV = IV;

            using (MemoryStream memoryStream = new MemoryStream())
            {
                using (CryptoStream cryptoStream =
                   new CryptoStream(memoryStream, crypt.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cryptoStream.Write(bytes, 0, bytes.Length);
                }

                S = Convert.ToBase64String(memoryStream.ToArray());
            }
            return S;
        }
        public string EncryptPhrase(string Phrase)
        {
            if (Phrase.Equals(null))
            {
                return "";
            }

            if (Phrase.Trim().Equals(""))
            {
                return "";
            }

            string S = "";
            int I = 0;
            string CH = "";
            string SIC = "";
            int IC = 0;
            try
            {
                for (I = 0; I <= Phrase.Length - 1; I++)
                {
                    IC = 0;
                    CH = Phrase.Substring(I, 1);
                    IC = Convert.ToInt32(Convert.ToChar(CH));
                    IC = IC + 88;
                    SIC = IC.ToString();
                    if (SIC.Length < 2)
                    {
                        SIC = "00" + SIC;
                    }
                    if (SIC.Length < 3)
                    {
                        SIC = "0" + SIC;
                    }
                    S += SIC;
                }
            }
            catch (Exception ex)
            {
                S = ("ERROR 100xx01: " + ex.Message);
            }

            return S;
        }
        public string Reverse(string value)
        {
            // Convert to char array.
            char[] arr = value.ToCharArray();
            // Use Array.Reverse function.
            Array.Reverse(arr);
            // Construct new string.
            return new string(arr);
        }

        public string EncryptPhraseShift(string Phrase, string shiftKey)
        {
            string S = "";
            int I = 0;
            int K = 0;
            string CH = "";
            string WCH = "";
            string KCH = "";
            string SIC = "";
            int IC = 0;
            int KIC = 0;

            if (shiftKey.Length.Equals(0))
            {
                shiftKey = this.getPw();
            }

            string RevshiftKey = Reverse(shiftKey);

            string sKey = shiftKey + RevshiftKey;
            try
            {
                for (I = 0; I <= Phrase.Length - 1; I++)
                {
                    if (K >= sKey.Length - 1)
                    {
                        K = 0;
                    }
                    IC = 0;
                    CH = Phrase.Substring(I, 1);
                    KCH = sKey.Substring(K, 1);
                    IC = Convert.ToInt32(Convert.ToChar(CH));
                    KIC = Convert.ToInt32(Convert.ToChar(KCH));
                    IC = IC + 88 + KIC;
                    SIC = IC.ToString();
                    WCH += System.Convert.ToString(System.Convert.ToInt32(SIC));
                    S += SIC;
                    K++;
                }
            }
            catch (Exception ex)
            {
                return ("ERROR 100xx02: " + ex.Message);
            }

            return WCH;
        }
        public string EncryptPhraseV1(string Phrase, string shiftKey)
        {
            string S = "";
            int I = 0;
            int K = 0;
            string CH = "";
            string KCH = "";
            string SIC = "";
            int IC = 0;
            int KIC = 0;
            string RevshiftKey = Reverse(shiftKey);
            shiftKey = shiftKey + RevshiftKey;
            try
            {
                for (I = 0; I <= Phrase.Length - 1; I++)
                {
                    if (K >= shiftKey.Length)
                    {
                        K = 0;
                    }
                    IC = 0;
                    CH = Phrase.Substring(I, 1);
                    KCH = shiftKey.Substring(K, 1);
                    IC = Convert.ToInt32(Convert.ToChar(CH));
                    KIC = Convert.ToInt32(Convert.ToChar(KCH));
                    IC = IC + 88 + KIC;
                    SIC = IC.ToString();
                    if (SIC.Length < 2)
                    {
                        SIC = "00" + SIC;
                    }
                    if (SIC.Length < 3)
                    {
                        SIC = "0" + SIC;
                    }
                    S += SIC;
                    K++;
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + SIC);
                return ("ERROR 100xx03: " + ex.Message);
            }

            return S;
        }
        public string DecryptPhrase(string Phrase, string shiftKey)
        {
            string S = "";
            int I = 0;
            int K = 0;
            string CH = "";
            string KCH = "";
            int IC = 0;
            int IC2 = 0;
            string CHX = "";
            //int KIC = 0;

            if (shiftKey.Length.Equals(0))
            {
                shiftKey = getPw();
            }

            string RevshiftKey = Reverse(shiftKey);

            shiftKey = shiftKey + RevshiftKey;
            try
            {
                for (I = 0; I <= Phrase.Length - 1; I++)
                {
                    if (K >= shiftKey.Length)
                    {
                        K = 0;
                    }
                    CH = Phrase.Substring(I, 1);
                    KCH = shiftKey.Substring(K, 1);
                    IC = Convert.ToInt32(Convert.ToChar(CH));
                    IC2 = Convert.ToInt32(Convert.ToChar(KCH));
                    IC = IC - 88 - IC2;
                    CHX = System.Convert.ToString(Convert.ToChar(IC));
                    S += CHX;
                    K++;
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                return ("ERROR 100xx04: " + ex.Message);
            }

            return S;
        }
        public string DecryptPhrase(string Phrase)
        {
            string S = "";
            int I = 0;
            string CH = "";
            int IC = 0;
            char CHX;

            try
            {
                for (I = 0; I <= Phrase.Length - 1; I += 3)
                {
                    CH = Phrase.Substring(I, 3);
                    IC = Convert.ToInt32(CH);
                    //IC = Convert.ToInt32 (Convert.ToChar (CH));
                    IC = IC - 88;
                    //CHX = System.Convert.ToString (Convert.ToChar (IC));
                    CHX = Convert.ToChar(IC);
                    S += CHX;
                    //I += 2
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                return ("ERROR 100ZZ2: " + ex.Message);
            }

            return S;
        }
        public string DecryptPhrase2(string Phrase)
        {
            string S = "";
            int I = 0;
            string CH = "";
            int IC = 0;
            string CHX = "";

            try
            {
                for (I = 0; I <= Phrase.Length - 1; I += 3)
                {
                    CH = Phrase.Substring(I, 3);
                    IC = Convert.ToInt32(Convert.ToChar(CH));
                    IC = IC - 88;
                    CHX = System.Convert.ToString(Convert.ToChar(IC));
                    S += CHX;
                    //I += 2
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show (I + System.Convert.ToString ("\t") + CH + System.Convert.ToString ("\t") + Phrase + System.Convert.ToString ("\t") + CHX);
                return ("ERROR 100X02: " + ex.Message);
            }

            return S;
        }
        private static string ScrambleKey(string v_strKey)
        {
            System.Text.StringBuilder sbKey = new System.Text.StringBuilder();
            int intPtr = 0;
            for (intPtr = 1; intPtr <= v_strKey.Length; intPtr++)
            {
                int intIn = v_strKey.Length - intPtr + 1;
                sbKey.Append(v_strKey.Substring(intIn - 1, 1));
            }
            string strKey = System.Convert.ToString(sbKey.ToString());
            return sbKey.ToString();
        }

        public string EncryptPhrase(string sOut, ref bool RC, ref string RetMsg)
        {
            if (sOut.Length == 0)
            {
                return "";
            }
            string sKey = getPw();
            TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
            MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();

            RC = true;
            sKey = System.Convert.ToString(ScrambleKey(sKey));
            DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
            DES.Mode = System.Security.Cryptography.CipherMode.ECB;
            ICryptoTransform DESDecrypt = DES.CreateDecryptor();
            byte[] Buffer = Convert.FromBase64String(sOut);
            string S = "";
            try
            {
                S = System.Convert.ToString(System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)));
            }
            catch (Exception)
            {
                RetMsg = "EncryptPhrase - Error in decrypting string.";
                RC = false;
                S = "";
            }
            return S;
        }

        //public string EncryptPhrase (string sOut)
        //{
        //    string pw = getPw ();
        //    return EncryptPhrase (sOut, pw);
        //}

        public string EncryptPhrase(string sOut, string pw)
        {
            if (sOut.Length == 0)
            {
                return "";
            }
            if (pw.Length.Equals(0))
                getPw();

            TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
            MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();

            RC = 0;
            string sKey = System.Convert.ToString(ScrambleKey(pw));
            DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
            DES.Mode = System.Security.Cryptography.CipherMode.ECB;
            ICryptoTransform DESDecrypt = DES.CreateDecryptor();
            byte[] Buffer = Convert.FromBase64String(sOut);
            string S = "";
            try
            {
                S = System.Convert.ToString(System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length)));
            }
            catch (Exception)
            {
                RetMsg = "EncryptPhrase - Error in decrypting string.";
                RC = -1;
                S = "";
            }
            return S;
        }

        public String EncryptPhraseB64(String sIn)
        {
            string sKey = getPw();
            TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
            MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();
            sKey = System.Convert.ToString(ScrambleKey(sKey));
            DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
            DES.Mode = System.Security.Cryptography.CipherMode.ECB;
            ICryptoTransform DESEncrypt = DES.CreateEncryptor();
            Byte[] Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn);
            return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
        }

        //public String EncryptPhrase(String sIn, String sKey)
        //{
        //    if (sIn.Length == 0)
        //    {
        //        return "";
        //    }
        //    TripleDESCryptoServiceProvider DES = new TripleDESCryptoServiceProvider();
        //    MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();
        //    sKey = System.Convert.ToString(ScrambleKey(sKey));
        //    DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
        //    DES.Mode = System.Security.Cryptography.CipherMode.ECB;
        //    ICryptoTransform DESEncrypt = DES.CreateEncryptor();
        //    Byte[] Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn);
        //    return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
        //}

        public string hashSha1File(string FQN)
        {

            FQN = FQN.Replace("''", "'");

            string hashResult = string.Empty;
            FileInfo FI = new FileInfo(FQN);
            int fSize = System.Convert.ToInt32(FI.Length);
            FI = null;
            GC.Collect();

            int BUF_SIZE = 32;
            byte[] dataArray = new byte[BUF_SIZE];
            byte[] FileBuffer = new byte[fSize + 1];
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();


            System.IO.FileStream f = default(System.IO.FileStream);
            f = new System.IO.FileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            f.Read(FileBuffer, 0, fSize - 1);

            byte[] result = sha.ComputeHash(dataArray);

            f.Close();
            f.Dispose();
            GC.Collect();
            GC.WaitForPendingFinalizers();

            hashResult = System.Convert.ToString(BitConverter.ToString(sha.Hash).Replace("-", "").ToLower());
            //Console.WriteLine("Length: " + hashResult.Length.ToString() + "    : " + hashResult);
            return hashResult;

        }

        public string hashCrc32(string filePath)
        {
            int BUF_SIZE = 32;
            byte[] dataBuffer = new byte[BUF_SIZE];
            byte[] dataBufferDummy = new byte[BUF_SIZE];
            //int dataBytesRead = 0;
            string hashResult = string.Empty;
            //HashAlgorithm hashAlg = null;
            //FileStream fs = null;

            var f = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 8192);
            var sha1 = new SHA1CryptoServiceProvider();
            byte[] Sha1Hash = sha1.ComputeHash(f);

            hashResult = System.Convert.ToString(BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower());
            f.Close();
            f.Dispose();
            GC.Collect();
            return hashResult;

        }

        public string hashSha1FileV2(string filePath)
        {
            int BUF_SIZE = 32;
            byte[] dataBuffer = new byte[BUF_SIZE];
            byte[] dataBufferDummy = new byte[BUF_SIZE];
            int dataBytesRead = 0;
            string hashResult = string.Empty;
            HashAlgorithm hashAlg = null;
            FileStream fs = null;
            try
            {
                hashAlg = new SHA1CryptoServiceProvider();
                fs = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE);
                do
                {
                    dataBytesRead = System.Convert.ToInt32(fs.Read(dataBuffer, 0, BUF_SIZE));
                    hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0);
                } while (!(dataBytesRead == 0));
                hashAlg.TransformFinalBlock(dataBuffer, 0, 0);
                hashResult = System.Convert.ToString(BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower());
            }
            catch (IOException ex)
            {
                return ("ZZ001: " + ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                return ("ZZ002: " + ex.Message);
            }
            finally
            {
                if (!ReferenceEquals(fs, null))
                {
                    fs.Close();
                    fs.Dispose();
                    fs = null;
                }
                if (!ReferenceEquals(hashAlg, null))
                {
                    hashAlg.Clear(); //Dispose()
                    hashAlg = null;
                }
            }
            return hashResult;
        }

        public string hashMd5File(string filePath)
        {
            int BUF_SIZE = 32;
            byte[] dataBuffer = new byte[BUF_SIZE];
            byte[] dataBufferDummy = new byte[BUF_SIZE];
            int dataBytesRead = 0;
            string hashResult = string.Empty;
            HashAlgorithm hashAlg = null;
            FileStream fs = null;
            try
            {
                hashAlg = new MD5CryptoServiceProvider();
                fs = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE);
                do
                {
                    dataBytesRead = System.Convert.ToInt32(fs.Read(dataBuffer, 0, BUF_SIZE));
                    hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0);
                } while (!(dataBytesRead == 0));
                hashAlg.TransformFinalBlock(dataBuffer, 0, 0);
                hashResult = System.Convert.ToString(BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower());
            }
            catch (IOException ex)
            {
                return ("YY001: " + ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                return "UnauthorizedAccessException: " + ex.Message;
            }
            finally
            {
                try
                {
                    fs.Close();
                    fs.Dispose();
                    fs = null;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("XX022: " + ex.Message);
                }
                try
                {
                    hashAlg.Clear(); //Dispose()
                    hashAlg = null;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("XX011: " + ex.Message);
                }

            }
            return hashResult;
        }

        public string DecryptTripleDES128(string sOut, bool B)
        {
            try
            {
                var sKey = xmp2rt21();
                System.Security.Cryptography.TripleDESCryptoServiceProvider DES = new System.Security.Cryptography.TripleDESCryptoServiceProvider();
                System.Security.Cryptography.MD5CryptoServiceProvider hashMD5 = new System.Security.Cryptography.MD5CryptoServiceProvider();


                // scramble the key
                sKey = ScrambleKey(sKey);
                // Compute the MD5 hash.
                DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
                // Set the cipher mode.
                DES.Mode = System.Security.Cryptography.CipherMode.ECB;
                // Create the decryptor.
                System.Security.Cryptography.ICryptoTransform DESDecrypt = DES.CreateDecryptor();
                byte[] Buffer = Convert.FromBase64String(sOut);
                // Transform and return the string.
                return System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
            }
            catch (Exception ex)
            {
                return ("clsEncrypt : EncryptPhrase : 141 : " + ex.Message);
            }
        }

        private string xmp2rt21()
        {
            string S = "";


            S = S + "D";
            S = S + "a";
            S = S + "l";
            S = S + "e";
            S = S + "A";
            S = S + "n";
            S = S + "d";
            S = S + "L";
            S = S + "i";
            S = S + "z";
            S = S + "M";
            S = S + "a";
            S = S + "d";
            S = S + "e";
            S = S + "T";
            S = S + "h";
            S = S + "i";
            S = S + "s";
            S = S + "H";
            S = S + "a";
            S = S + "p";
            S = S + "p";
            S = S + "e";
            S = S + "n";
            S = S + "!";


            return S;
        }

        public SortedList<string, string> xt001trc(string S, int ddebug = 0)
        {
            SortedList<string, string> A = new SortedList<string, string>();
            //bool B = false;
            string SS = "";
            string tKey = "";
            string tVal = "";

            SS = AES256DecryptString(S, ddebug);

            object[] AR = SS.Split('|');

            for (int i = 1; i <= (AR.Length - 1); i++)
            {

                if (i == 0)
                {
                    Console.WriteLine("here");
                }
                else if (i % 2 != 0)
                {
                    tKey = AR[i].ToString().Trim();
                }
                else
                {
                    tVal = AR[i].ToString().Trim();
                }
                if (i % 2 == 0)
                {
                    try
                    {
                        int iDx = System.Convert.ToInt32(A.ContainsKey(tKey));
                        if (iDx <= 0)
                        {
                            A.Add(tKey, tVal);
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("clsEncrypt : xt001trc : 104 : " + ex.Message);
                    }
                }
            }
            return A;
        }

        public void saveString(string action, string s)
        {
            //bool b = true;
            string path = "c:\\temp\\encrypted.txt";

            if (action.Equals("r"))
            {
                // This text is added only once to the file.
                if (File.Exists(path))
                {
                    System.IO.File.Delete(path);
                }
                if (!File.Exists(path))
                {
                    // Create a file to write to.
                    using (StreamWriter sw = File.CreateText(path))
                    {
                        sw.WriteLine(s);
                    }

                }
            }
            if (action.Equals("a"))
            {
                // This text is always added, making the file longer over time if it is not deleted.
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(s);
                }

            }
        }

        private byte[] StrToByteArray(string str)
        {
            System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
            return encoding.GetBytes(str);
        } // StrToByteArray

        public string getSha1HashKey(string strToHash)
        {
            string hashResult = string.Empty;
            int BUF_SIZE = strToHash.Length;
            byte[] dataArray = new byte[BUF_SIZE - 1 + 1];
            byte[] FileBuffer = StrToByteArray(strToHash);
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();

            byte[] result = sha.ComputeHash(dataArray);

            GC.Collect();
            GC.WaitForPendingFinalizers();

            hashResult = BitConverter.ToString(sha.Hash).Replace("-", "").ToLower();
            // Console.WriteLine("Length: " + hashResult.Length.ToString + "    : " + hashResult)
            return hashResult;
        }

        public string getSha1HashFromFile(string FileFQN)
        {
            int BUF_SIZE = 32;
            byte[] dataBuffer = new byte[BUF_SIZE - 1 + 1];
            byte[] dataBufferDummy = new byte[BUF_SIZE - 1 + 1];
            //int dataBytesRead = 0;
            string hashResult = string.Empty;
            //HashAlgorithm hashAlg = null/* TODO Change to default(_) if this is not a reference type */;
            //FileStream fs = null;

            var f = new FileStream(FileFQN, FileMode.Open, FileAccess.Read, FileShare.Read, 8192);
            var sha1 = new SHA1CryptoServiceProvider();
            byte[] Sha1Hash = sha1.ComputeHash(f);

            hashResult = BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower();
            f.Close();
            f.Dispose();
            GC.Collect();

            return hashResult;
        }

        public string GenerateSHA256String(string inputString)
        {
            SHA256 sha512 = SHA256Managed.Create();
            byte[] bytes = Encoding.UTF8.GetBytes(inputString);
            byte[] hash = sha512.ComputeHash(bytes);
            return GetHexStringFromHash(hash);
        }
        public string GenerateSHA256HashFromFile(string FQN)
        {
            FQN = @"C:\temp\Channels.txt";
            int BUF_SIZE = 32;
            byte[] dataBuffer = new byte[BUF_SIZE - 1 + 1];
            byte[] dataBufferDummy = new byte[BUF_SIZE - 1 + 1];
            string hashResult = string.Empty;
            var f = new FileStream(FQN, FileMode.Open, FileAccess.Read, FileShare.Read, 8192);
            SHA256 sha256 = SHA256.Create(); // SHA256Managed.Create();

            //byte[] bytes = Encoding.UTF8.GetBytes(inputString);
            byte[] hash = sha256.ComputeHash(f);
            string s = GetHexStringFromHash(hash);
            return s;
        }

        public string GenerateSHA256HashFromFileV2(string FQN)
        {
            SHA256 sha256 = SHA256Managed.Create();
            FileInfo fi = new FileInfo(FQN);
            long fl = fi.Length;
            fi = null;
            fl = fl - 1;    //SQL Server stores all but the last EOF byte in the FileStream store.
            byte[] buffer = new byte[fl];

            using (var fs = new FileStream(FQN, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                fs.Read(buffer, 0, (int)fl);
            }

            byte[] filehash = sha256.ComputeHash(buffer);

            sha256.Dispose();
            string shash = GetHexStringFromHash(filehash);
            shash = "0x" + shash;
            return shash;
        }

        public string GenerateSHA512StringV2(string inputString)
        {
            SHA512 sha512 = new SHA512Managed();
            byte[] bytes = Encoding.Unicode.GetBytes(inputString);
            byte[] hash = sha512.ComputeHash(bytes);
            string s = GetHexStringFromHash(hash);
            return s;
        }

        public string SHA512String(string inputString)
        {
            string hex = "";
            int DATA_SIZE = 125;
            byte[] data = new byte[DATA_SIZE];
            byte[] result;
            SHA512 shaM = new SHA512Managed();
            result = shaM.ComputeHash(data);
            hex = GetHexStringFromHash(result);
            return hex;
        }

        public string SHA512SqlServerHash(string s)
        {
            byte[] bytes = Encoding1252.GetBytes(s);
            SHA512 MgtSha = new SHA512Managed();
            byte[] hashBytes = MgtSha.ComputeHash(bytes);
            string HashStr = GetHexStringFromHash(hashBytes);
            return HashStr;
        }
    

        public string GenerateSHA512HashFromFile(string FQN)
        {
            int LL = 0;
            long fl = 0;
            try
            {
                string shash = ComputeFileHash(FQN);
                return shash;
            }
            catch (Exception ex)
            {
                Console.WriteLine( ex.Message + ":" + LL.ToString() + " : " + fl.ToString());
                string shash = ComputeFileHash(FQN);
                return shash;
            }
        }

        //private string Bytes_To_String2(byte[] bytes_Input)
        //{
        //    StringBuilder strTemp = new StringBuilder(bytes_Input.Length * 2);
        //    foreach (byte b in bytes_Input)
        //        strTemp.Append(Conversion.Hex(b));
        //    return strTemp.ToString();
        //}

        private string ComputeFileHash(string fileName)
        {
            string S = "";
            byte[] ourHash = new byte[1];
            // If file exists, create a HashAlgorithm instance based off of MD5 encryption
            // You could use a variant of SHA or RIPEMD160 if you like with larger hash bit sizes.
            if (File.Exists(fileName))
            {
                try
                {
                    HashAlgorithm ourHashAlg = HashAlgorithm.Create("SHA512");
                    FileStream fileToHash = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    // Compute the hash to return using the Stream we created.
                    ourHash = ourHashAlg.ComputeHash(fileToHash);
                    fileToHash.Close();

                    S = GetHexStringFromHash(ourHash);
                    //if (!S.Substring(1, 2).Equals("0x"))
                    //{
                    //    S += "0x" + S;
                    //}
                }
                catch (IOException ex)
                {
                    Console.WriteLine("There was an error opening the file: " + ex.Message);
                }
            }
            //if  (! S.Substring(1,2).Equals("0x")){
            //    S += "0x" + S;
            //}
            int x = S.Length;
            return S;
        }

        private string GetHexStringFromHash(byte[] hash)
        {
            StringBuilder result = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                result.Append(hash[i].ToString("X2"));
            }
            string hexstr2 = BitConverter.ToString(hash);
            hexstr2 = "0x" + hexstr2.Replace("-", "");
            string hexstr = "0x" + result.ToString(); ;

            int i2 = hexstr2.Length;
            int i1 = hexstr.Length;

            return hexstr;
        }

    }
}


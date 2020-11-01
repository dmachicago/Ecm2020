
using System;
using System.IO;
using System.Security.Cryptography;

namespace ECMEncryption
{
    class AES
    {
        private byte[] IV = { 21, 0, 121, 212, 61, 50, 4, 79, 13, 156, 200, 213, 79, 155, 201, 16 };
        private byte[] KEY = { 21, 0, 121, 212, 61, 50, 4, 79, 13, 156, 200, 213, 79, 155, 201, 16, 21, 0, 121, 212, 61, 50, 4, 79, 13, 156, 200, 213, 79, 155, 201, 16 };
        public  string Encrypt(string original)
        {
            string str = "";
            try
            {
                // Create a new instance of the AesCryptoServiceProvider 
                // class.  This generates a new key and initialization  
                // vector (IV). 
                using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
                {
                    myAes.Key = KEY;
                    myAes.IV = IV;
                    // Encrypt the string to an array of bytes. 
                    //byte[] encrypted = EncryptStringToBytes_Aes(original, myAes.Key, myAes.IV);
                    byte[] encrypted = EncryptStringToBytes_Aes(original, myAes.Key, myAes.IV);
                    Console.WriteLine(myAes.Key);
                    Console.WriteLine(myAes.IV);
                    str = System.Text.Encoding.Unicode.GetString(encrypted, 0, encrypted.Length);
                    // Decrypt the bytes to a string. 
                    string roundtrip = DecryptStringFromBytes_Aes(encrypted, myAes.Key, myAes.IV);
                    //Display the original data and the decrypted data.
                    Console.WriteLine("Original:   {0}", original);
                    Console.WriteLine("Round Trip: {0}", roundtrip);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e.Message);
            }
            return str;
        }
        public  string Decrypt(string EncrytpedString)
        {
            string str = "";
            byte[] encrypted = System.Text.Encoding.Unicode.GetBytes(EncrytpedString);
            try
            {
                // Create a new instance of the AesCryptoServiceProvider 
                // class.  This generates a new key and initialization  
                // vector (IV). 
                using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
                {
                    myAes.Key = KEY;
                    myAes.IV = IV;
                    str = DecryptStringFromBytes_Aes(encrypted, myAes.Key, myAes.IV);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e.Message);
            }
            return str;
        }
        private byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
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
        private string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
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
    }
}
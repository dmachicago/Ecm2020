//VER 3.2.1 6.4.2013
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace jQueryToWCF
{
    class clsEncryptV2
    {
        //string plainText = "Hello, World!";    // original plaintext

        private string passPhrase = "Pas5pr@se";        // can be any string
        private string saltValue = "s@1tValue";        // can be any string
        //private string hashAlgorithm = "SHA1";             // can be "MD5"
        private string hashAlgorithm = "MD5";             // can be "MD5"
        private int passwordIterations = 2;                  // can be any number
        private string initVector = "@1B2c3D4e5F6g7H8"; // must be 16 bytes
        private int keySize = 128;                // can be 192 or 128      

        public Dictionary<string, string> genRandomKeys()
        {
            Dictionary<string, string> keys = new Dictionary<string, string>();
            string k1 = Guid.NewGuid().ToString();
            string k2 = Guid.NewGuid().ToString();
            string k3 = Guid.NewGuid().ToString();
            string k4 = Guid.NewGuid().ToString();
            keys.Add("k1", k1);
            keys.Add("k2", k2);
            keys.Add("k3", k3);
            keys.Add("k4", k4);
            return keys;
        }

        public string encryptPassword(string password)
        {
            passPhrase = genPP();
            saltValue = genSalt();
            initVector = genVector();
            string epw = "";
            epw = Encrypt(password,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector,
                        keySize);
            return epw;
        }

        public string encryptPassword(string password, string passPhrase)
        {
            saltValue = genSalt();
            initVector = genVector();
            string epw = "";
            epw = Encrypt(password,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector,
                        keySize);
            return epw;
        }

        /// <summary>
        /// Encrypts the password.
        /// </summary>
        /// <param name="password">The password.</param>
        /// <param name="passPhrase">The pass phrase.</param>
        /// <param name="saltValue">The salt value - can be any length.</param>
        /// <param name="initVector16">The initialize vector16 - must be 16 bytes by definition.</param>
        /// <returns></returns>
        public string encryptPassword(string password, string passPhrase, string saltValue, string initVector16)
        {
            string epw = "";
            epw = Encrypt(password,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector16,
                        keySize);
            return epw;
        }

        public string decryptPassword(string encryptedPassword, string passPhrase, string saltValue, string initVector16)
        {
            string dpw = "";
            dpw = Decrypt(encryptedPassword,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector16,
                        keySize);
            return dpw;
        }

        public string decryptPassword(string encryptedPassword, string passPhrase)
        {
            saltValue = genSalt();
            initVector = genVector();
            string dpw = "";
            dpw = Decrypt(encryptedPassword,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector,
                        keySize);
            return dpw;
        }

        public string decryptPassword(string encryptedPassword)
        {
            passPhrase = genPP();
            saltValue = genSalt();
            initVector = genVector();
            string dpw = "";
            dpw = Decrypt(encryptedPassword,
                        passPhrase,
                        saltValue,
                        hashAlgorithm,
                        passwordIterations,
                        initVector,
                        keySize);
            return dpw;
        }

        private string genVector()
        {
            string s = "";
            s += "@";
            s += "1";
            s += "B";
            s += "2";
            s += "c";
            s += "3";
            s += "D";
            s += "A";
            s += "L";
            s += "e";
            s += "F";
            s += "6";
            s += "$";
            s += "7";
            s += "H";
            s += "8";
            return s;
        }

        private string genSalt()
        {
            string s = "";
            s += "G";
            s += "3";
            s += "N";
            s += "S";
            s += "@";
            s += "L";
            s += "T";
            s += "V";
            s += "@";
            s += "L";
            s += "U";
            s += "3";
            return s;
        }

        private string genPP()
        {
            string s = "";
            s += "N";
            s += "o";
            s += "w";
            s += "!";
            s += "I";
            s += "s";
            s += "T";
            s += "h";
            s += "e";
            s += "T";
            s += "i";
            s += "m";
            s += "e";
            s += "F";
            s += "o";
            s += "r";
            s += "A";
            s += "l";
            s += "l";
            s += "G";
            s += "o";
            s += "o";
            s += "d";
            s += "M";
            s += "e";
            s += " n ";
            s += "@";
            s += "T";
            s += "o";
            s += "C";
            s += "o";
            s += "m";
            s += " e ";
            s += "$";
            s += "T";
            s += "o";
            s += "T";
            s += "h";
            s += "e";
            s += "A";
            s += "i";
            s += "d";
            s += "O";
            s += "f";
            s += "T";
            s += "h";
            s += "e";
            s += "i";
            s += "r";
            s += "C";
            s += "o";
            s += "u";
            s += "n";
            s += "t";
            s += "r";
            s += " y ";
            s += "@";
            return s;
        }

        /// <summary>
        /// Encrypts specified plaintext using Rijndael symmetric key algorithm
        /// and returns a base64-encoded result.
        /// </summary>
        /// <param name="plainText">
        /// Plaintext value to be encrypted.
        /// </param>
        /// <param name="passPhrase">
        /// Passphrase from which a pseudo-random password will be derived. The
        /// derived password will be used to generate the encryption key.
        /// Passphrase can be any string. In this example we assume that this
        /// passphrase is an ASCII string.
        /// </param>
        /// <param name="saltValue">
        /// Salt value used along with passphrase to generate password. Salt can
        /// be any string. In this example we assume that salt is an ASCII string.
        /// </param>
        /// <param name="hashAlgorithm">
        /// Hash algorithm used to generate password. Allowed values are: "MD5" and
        /// "SHA1". SHA1 hashes are a bit slower, but more secure than MD5 hashes.
        /// </param>
        /// <param name="passwordIterations">
        /// Number of iterations used to generate password. One or two iterations
        /// should be enough.
        /// </param>
        /// <param name="initVector">
        /// Initialization vector (or IV). This value is required to encrypt the
        /// first block of plaintext data. For RijndaelManaged class IV must be
        /// exactly 16 ASCII characters long.
        /// </param>
        /// <param name="keySize">
        /// Size of encryption key in bits. Allowed values are: 128, 192, and 256.
        /// Longer keys are more secure than shorter keys.
        /// </param>
        /// <returns>
        /// Encrypted value formatted as a base64-encoded string.
        /// </returns>
        private string Encrypt(string plainText,
                                     string passPhrase,
                                     string saltValue,
                                     string hashAlgorithm,
                                     int passwordIterations,
                                     string initVector,
                                     int keySize)
        {
            // Convert strings into byte arrays.
            // Let us assume that strings only contain ASCII codes.
            // If strings include Unicode characters, use Unicode, UTF7, or UTF8
            // encoding.
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

            // Convert our plaintext into a byte array.
            // Let us assume that plaintext contains UTF8-encoded characters.
            byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

            // First, we must create a password, from which the key will be derived.
            // This password will be generated from the specified passphrase and
            // salt value. The password will be created using the specified hash
            // algorithm. Password creation can be done in several iterations.
            PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);

            // Use the password to generate pseudo-random bytes for the encryption
            // key. Specify the size of the key in bytes (instead of bits).
            byte[] keyBytes = password.GetBytes(keySize / 8);

            // Create uninitialized Rijndael encryption object.
            RijndaelManaged symmetricKey = new RijndaelManaged();

            // It is reasonable to set encryption mode to Cipher Block Chaining
            // (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC;

            // Generate encryptor from the existing key bytes and initialization
            // vector. Key size will be defined based on the number of the key
            // bytes.
            ICryptoTransform encryptor = symmetricKey.CreateEncryptor(
                                                             keyBytes,
                                                             initVectorBytes);

            // Define memory stream which will be used to hold encrypted data.
            MemoryStream memoryStream = new MemoryStream();

            // Define cryptographic stream (always use Write mode for encryption).
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                         encryptor,
                                                         CryptoStreamMode.Write);
            // Start encrypting.
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);

            // Finish encrypting.
            cryptoStream.FlushFinalBlock();

            // Convert our encrypted data from a memory stream into a byte array.
            byte[] cipherTextBytes = memoryStream.ToArray();

            // Close both streams.
            memoryStream.Close();
            cryptoStream.Close();

            // Convert encrypted data into a base64-encoded string.
            string cipherText = Convert.ToBase64String(cipherTextBytes);

            // Return encrypted string.
            return cipherText;
        }

        /// <summary>
        /// Decrypts specified ciphertext using Rijndael symmetric key algorithm.
        /// </summary>
        /// <param name="cipherText">
        /// Base64-formatted ciphertext value.
        /// </param>
        /// <param name="passPhrase">
        /// Passphrase from which a pseudo-random password will be derived. The
        /// derived password will be used to generate the encryption key.
        /// Passphrase can be any string. In this example we assume that this
        /// passphrase is an ASCII string.
        /// </param>
        /// <param name="saltValue">
        /// Salt value used along with passphrase to generate password. Salt can
        /// be any string. In this example we assume that salt is an ASCII string.
        /// </param>
        /// <param name="hashAlgorithm">
        /// Hash algorithm used to generate password. Allowed values are: "MD5" and
        /// "SHA1". SHA1 hashes are a bit slower, but more secure than MD5 hashes.
        /// </param>
        /// <param name="passwordIterations">
        /// Number of iterations used to generate password. One or two iterations
        /// should be enough.
        /// </param>
        /// <param name="initVector">
        /// Initialization vector (or IV). This value is required to encrypt the
        /// first block of plaintext data. For RijndaelManaged class IV must be
        /// exactly 16 ASCII characters long.
        /// </param>
        /// <param name="keySize">
        /// Size of encryption key in bits. Allowed values are: 128, 192, and 256.
        /// Longer keys are more secure than shorter keys.
        /// </param>
        /// <returns>
        /// Decrypted string value.
        /// </returns>
        /// <remarks>
        /// Most of the logic in this function is similar to the Encrypt
        /// logic. In order for decryption to work, all parameters of this function
        /// - except cipherText value - must match the corresponding parameters of
        /// the Encrypt function which was called to generate the
        /// ciphertext.
        /// </remarks>
        private string Decrypt(string cipherText,
                                     string passPhrase,
                                     string saltValue,
                                     string hashAlgorithm,
                                     int passwordIterations,
                                     string initVector,
                                     int keySize)
        {
            // Convert strings defining encryption key characteristics into byte
            // arrays. Let us assume that strings only contain ASCII codes.
            // If strings include Unicode characters, use Unicode, UTF7, or UTF8
            // encoding.
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

            // Convert our ciphertext into a byte array.
            byte[] cipherTextBytes = Convert.FromBase64String(cipherText);

            // First, we must create a password, from which the key will be
            // derived. This password will be generated from the specified
            // passphrase and salt value. The password will be created using
            // the specified hash algorithm. Password creation can be done in
            // several iterations.
            PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                            passPhrase,
                                                            saltValueBytes,
                                                            hashAlgorithm,
                                                            passwordIterations);

            // Use the password to generate pseudo-random bytes for the encryption
            // key. Specify the size of the key in bytes (instead of bits).
            byte[] keyBytes = password.GetBytes(keySize / 8);

            // Create uninitialized Rijndael encryption object.
            RijndaelManaged symmetricKey = new RijndaelManaged();

            // It is reasonable to set encryption mode to Cipher Block Chaining
            // (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC;

            // Generate decryptor from the existing key bytes and initialization
            // vector. Key size will be defined based on the number of the key
            // bytes.
            ICryptoTransform decryptor = symmetricKey.CreateDecryptor(
                                                             keyBytes,
                                                             initVectorBytes);

            // Define memory stream which will be used to hold encrypted data.
            MemoryStream memoryStream = new MemoryStream(cipherTextBytes);

            // Define cryptographic stream (always use Read mode for encryption).
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                          decryptor,
                                                          CryptoStreamMode.Read);

            // Since at this point we don't know what the size of decrypted data
            // will be, allocate the buffer long enough to hold ciphertext;
            // plaintext is never longer than ciphertext.
            byte[] plainTextBytes = new byte[cipherTextBytes.Length];

            // Start decrypting.
            int decryptedByteCount = cryptoStream.Read(plainTextBytes,
                                                       0,
                                                       plainTextBytes.Length);

            // Close both streams.
            memoryStream.Close();
            cryptoStream.Close();

            // Convert decrypted data into a string.
            // Let us assume that the original plaintext string was UTF8-encoded.
            string plainText = Encoding.UTF8.GetString(plainTextBytes,
                                                       0,
                                                       decryptedByteCount);

            // Return decrypted string.
            return plainText;
        }

        public static string HashCode(string str)
        {
            string rethash = "";
            try
            {
                System.Security.Cryptography.SHA1 hash = System.Security.Cryptography.SHA1.Create();
                System.Text.ASCIIEncoding encoder = new System.Text.ASCIIEncoding();
                byte[] combined = encoder.GetBytes(str);
                hash.ComputeHash(combined);
                rethash = Convert.ToBase64String(hash.Hash);
            }
            catch (Exception ex)
            {
                string strerr = "Error in HashCode : " + ex.Message;
            }
            return rethash;
        }

        /*
            Call it like this (for MD5):
            string hPassword = ComputeHash(password, new MD5CryptoServiceProvider());
            Or for SHA256:
            string hPassword = ComputeHash(password, new SHA256CryptoServiceProvider());
         */
        public string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);

            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);

            return BitConverter.ToString(hashedBytes);
        }
    }
}

using System;
using global::System.IO;
using global::System.Security.Cryptography;
using global::System.Text;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsKeyGen
    {
        private clsLogging LOG = new clsLogging();
        private ECMEncrypt ENC = new ECMEncrypt();
        public string FileName = "";
        public string DirName = "";
        public int FileLength = 0;
        public string FileNameHash = "";
        public DateTime CreateDate = default;
        public DateTime LastWriteDate = default;
        public string FileExt = "";
        public decimal CRC = 0m;
        public decimal FileNameCrc = 0m;
        public decimal DirNameCrc = 0m;
        public string FileHash = "";
        public string GroupKey = "";
        public string KeyHash = "";
        public string EmailSubject = "";
        public string EmailBody = "";
        public int SubjectLength = 0;
        public int BodyLength = 0;
        public int EmailNbrAttachments = 0;
        public string EmailAuthor = "";
        public DateTime EmailCreateDate = default;
        private FileInfo F;

        public string HashFile(string FileNameOnly, string FileLength, string FileExt, string FileCreationDate, string FileLastUpdate)



        {
            string FullKey = FileNameOnly + FileLength + FileExt + FileCreationDate + FileLastUpdate;
            string HashKey = "";
            HashKey = getMD5HashX(FullKey);
            return HashKey;
        }

        public string genHashContent(string CreateDate, string SourceName, string OriginalFileType, string FileLength, string CRC)
        {
            SourceName = SourceName.Replace("'", "`");
            string FullKey = CreateDate + SourceName + OriginalFileType + FileLength + CRC;
            string HashKey = "";
            HashKey = getMD5HashX(FullKey);
            return HashKey;
        }

        public string genEmailHashCode(string Subject, string body, string SenderEmailAddress, string CreationDate, string NumberOfAttachments, string FileExt)



        {
            body = body.Replace("'", "`");
            Subject = Subject.Replace("'", "`");
            SenderEmailAddress = SenderEmailAddress.Replace("'", "`");
            CreationDate = FileExt.Replace("'", "`");
            FileExt = FileExt.Replace("'", "`");
            string FullKey = Subject + body + SenderEmailAddress + CreationDate + NumberOfAttachments + FileExt;
            string HashKey = "";
            HashKey = ENC.getSha1HashKey(FullKey);
            // HashKey = getSha1Hash(FullKey)
            // HashKey = getMD5HashX(FullKey)

            return HashKey;
        }

        public string genFileKey(string FQN)
        {
            string HashStr = "";
            string FileKey = "";
            F = new FileInfo(FQN);
            if (F.Exists)
            {
                FileKey = ENC.GenerateSHA512HashFromFile(FQN);

                // FileName = F.Name
                // FileExt = F.Extension
                // FileLength = F.Length
                // LastWriteDate = F.LastWriteTime
                // CreateDate = F.CreationTime

                // If FileExt.Length = 0 Then
                // FileExt = ".UKN"
                // End If

                // 'DirNameCrc = HashCalc(DirName)
                // FileNameCrc = HashCalc(FileName)

                // FileKey = GenFileHash(FQN)
                // KeyHash = HashCalc(FileKey)

                // HashStr = FileName + FileLength.ToString() + CreateDate.ToString() + LastWriteDate.ToString()
                // FileKey = getMD5HashX(HashStr)

                // GroupKey = FileHash & ":" & KeyHash.ToString

                // 'FileKey = FileKey + KeyHash.ToString

            }

            F = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            return FileKey;
        }

        public string genEmailKey(string Subject, string EmailBody, string EmailCreateDate, string EmailAuthor, string NbrAttachments, string EmailExt)
        {
            string EmailKey = Subject + EmailBody + EmailCreateDate + EmailAuthor + NbrAttachments + EmailExt;
            string MD5Key = getMD5HashX(EmailKey);

            // EmailKey = EmailKey + KeyHash.ToString

            return MD5Key;
        }

        public string GenFileHash(string FQN)
        {
            string GeneratedHash = "";
            FileHash = CalcFileCRC(FQN);
            DirName = F.DirectoryName.ToUpper();
            FileName = F.Name.ToUpper();
            FileExt = F.Extension.ToUpper();
            FileLength = (int)F.Length;
            LastWriteDate = F.LastWriteTime;
            CreateDate = F.CreationTime;

            // GeneratedHash += DirName + Chr(254)
            // GeneratedHash += DirNameCrc.ToString + Chr(254)
            GeneratedHash += FileName + Conversions.ToString('þ');
            GeneratedHash += FileNameCrc.ToString() + Conversions.ToString('þ');
            GeneratedHash += FileExt + Conversions.ToString('þ');
            GeneratedHash += FileLength.ToString() + Conversions.ToString('þ');
            GeneratedHash += CreateDate.ToString() + Conversions.ToString('þ');
            // GeneratedHash += LastWriteDate.ToString + Chr(254)
            GeneratedHash += FileHash;
            return GeneratedHash;
        }

        public string GenEmailHash(string Subject, string EmailBody, string EmailCreateDate, string EmailAuthor, string NbrAttachments, string EmailExt)
        {
            string GeneratedHash = "";
            GeneratedHash += Subject + Conversions.ToString('þ');
            GeneratedHash += EmailBody + Conversions.ToString('þ');
            GeneratedHash += EmailCreateDate + Conversions.ToString('þ');
            GeneratedHash += EmailAuthor + Conversions.ToString('þ');
            GeneratedHash += NbrAttachments + Conversions.ToString('þ');
            GeneratedHash += EmailExt;
            return GeneratedHash;
        }

        public decimal HashCalc(string tString)
        {
            decimal iHash = 0m;
            for (int i = 1, loopTo = tString.Length; i <= loopTo; i++)
            {
                int iAsc = Strings.Asc(Strings.Mid(tString, i, 1));
                iHash = iHash + iAsc;
                iHash = iHash + i;
                if (i % 5 == 0)
                {
                    iHash = (decimal)((double)iHash + Math.Sqrt((double)iHash));
                    Math.Round(iHash, 6);
                }
            }

            Math.Round(iHash, 6);
            iHash = Truncate(iHash, 6);
            return iHash;
        }

        public string CalcFileCRC(string FQN)
        {
            var zipCrc = new Chilkat.ZipCrc();
            long crc = 0L;
            crc = zipCrc.FileCrc(FQN);
            string hexStr;
            hexStr = zipCrc.ToHex((uint)crc);
            return hexStr;
        }

        public decimal Truncate(decimal value, int decimals)
        {
            return (decimal)Math.Round((double)value - 0.5d / Math.Pow(10d, decimals), decimals);
        }

        /// <summary>
    /// Get the MD5 Hash of a String
    /// </summary>
    /// <param name="strToHash">The String to Hash</param>
    /// <returns></returns>
    /// <remarks></remarks>
        public string getMD5HashX(string strToHash)
        {
            var md5Obj = new MD5CryptoServiceProvider();
            var bytesToHash = Encoding.UTF8.GetBytes(strToHash);
            bytesToHash = md5Obj.ComputeHash(bytesToHash);
            string strResult = Encoding.UTF8.GetString(bytesToHash);
            strResult = "";
            foreach (byte b in bytesToHash)
                strResult += b.ToString("x2");
            return strResult;
        }

        public string getSha1Hash(string strToHash)
        {
            var Sha1Obj = new SHA1CryptoServiceProvider();
            var bytesToHash = Encoding.UTF8.GetBytes(strToHash);
            bytesToHash = Sha1Obj.ComputeHash(bytesToHash);
            string strResult = Encoding.UTF8.GetString(bytesToHash);
            strResult = "";
            foreach (byte b in bytesToHash)
                strResult += b.ToString("x2");
            return strResult;
        }

        private string GenerateHash(string SourceText)
        {
            // Create an encoding object to ensure the encoding standard for the source text
            var Ue = new UnicodeEncoding();
            // Retrieve a byte array based on the source text
            var ByteSourceText = Ue.GetBytes(SourceText);
            // Instantiate an MD5 Provider object
            var Md5 = new MD5CryptoServiceProvider();
            // Compute the hash value from the source
            var ByteHash = Md5.ComputeHash(ByteSourceText);
            // And convert it to String format for return
            return Convert.ToBase64String(ByteHash);
        }
    }
}
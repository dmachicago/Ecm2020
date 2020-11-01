// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.IO;
//using System.Math;
using System.Text;
using System.Security.Cryptography;


namespace EcmArchiveClcSetup
{
	public class clsKeyGen
	{
		
		clsLogging LOG = new clsLogging();
		clsEncrypt ENC = new clsEncrypt();
		
		public string FileName = "";
		public string DirName = "";
		public int FileLength = 0;
		public string FileNameHash = "";
		public DateTime CreateDate = null;
		public DateTime LastWriteDate = null;
		public string FileExt = "";
		public decimal CRC = 0;
		public decimal FileNameCrc = 0;
		public decimal DirNameCrc = 0;
		public string FileCRC = "";
		public string GroupKey = "";
		public string KeyHash = "";
		
		public string EmailSubject = "";
		public string EmailBody = "";
		public int SubjectLength = 0;
		public int BodyLength = 0;
		public int EmailNbrAttachments = 0;
		public string EmailAuthor = "";
		public DateTime EmailCreateDate = null;
		
		System.IO.FileInfo F;
		
		public string HashFile(string FileNameOnly, string FileLength, string FileExt, string FileCreationDate, string FileLastUpdate)
		{
			
			string FullKey = FileNameOnly + FileLength + FileExt + FileCreationDate + FileLastUpdate;
			string HashKey = "";
			
			HashKey = getMD5HashX(FullKey);
			
			return HashKey;
		}
		
		public string genHashContent(string CreateDate, string SourceName, string OriginalFileType, string FileLength, string CRC)
		{
			
			SourceName = SourceName.Replace("\'", "`");
			
			string FullKey = CreateDate + SourceName + OriginalFileType + FileLength + CRC;
			string HashKey = "";
			
			HashKey = getMD5HashX(FullKey);
			
			return HashKey;
		}
		
		public string genEmailHashCode(string Subject, string body, string SenderEmailAddress, string CreationDate, string NumberOfAttachments, string FileExt)
		{
			
			body = body.Replace("\'", "`");
			Subject = Subject.Replace("\'", "`");
			SenderEmailAddress = SenderEmailAddress.Replace("\'", "`");
			CreationDate = FileExt.Replace("\'", "`");
			FileExt = FileExt.Replace("\'", "`");
			
			string FullKey = Subject + body + SenderEmailAddress + CreationDate + NumberOfAttachments + FileExt;
			string HashKey = "";
			
			HashKey = ENC.getSha1HashKey(FullKey);
			//HashKey = getSha1Hash(FullKey)
			//HashKey = getMD5HashX(FullKey)
			
			return HashKey;
		}
		
		public string genFileKey(string FQN)
		{
			
			string HashStr = "";
			string FileKey = "";
			F = new System.IO.FileInfo(FQN);
			
			if (F.Exists)
			{
				
				FileKey = ENC.getSha1HashFromFile(FQN);
				
				//FileName = F.Name
				//FileExt = F.Extension
				//FileLength = F.Length
				//LastWriteDate = F.LastWriteTime
				//CreateDate = F.CreationTime
				
				//If FileExt.Length = 0 Then
				//    FileExt = ".UKN"
				//End If
				
				//'DirNameCrc = HashCalc(DirName)
				//FileNameCrc = HashCalc(FileName)
				
				//FileKey = GenFileHash(FQN)
				//KeyHash = HashCalc(FileKey)
				
				//HashStr = FileName + FileLength.ToString() + CreateDate.ToString() + LastWriteDate.ToString()
				//FileKey = getMD5HashX(HashStr)
				
				//GroupKey = FileCRC & ":" & KeyHash.ToString
				
				//'FileKey = FileKey + KeyHash.ToString
				
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
			
			//EmailKey = EmailKey + KeyHash.ToString
			
			return MD5Key;
			
		}
		
		public string GenFileHash(string FQN)
		{
			string GeneratedHash = "";
			FileCRC = CalcFileCRC(FQN);
			
			DirName = F.DirectoryName.ToUpper();
			FileName = F.Name.ToUpper();
			FileExt = F.Extension.ToUpper();
			FileLength = F.Length;
			LastWriteDate = F.LastWriteTime;
			CreateDate = F.CreationTime;
			
			//GeneratedHash += DirName + Chr(254)
			//GeneratedHash += DirNameCrc.ToString + Chr(254)
			GeneratedHash += FileName + Strings.Chr(254);
			GeneratedHash += FileNameCrc.ToString() + Strings.Chr(254);
			GeneratedHash += FileExt + Strings.Chr(254);
			GeneratedHash += FileLength.ToString() + Strings.Chr(254);
			GeneratedHash += CreateDate.ToString() + Strings.Chr(254);
			//GeneratedHash += LastWriteDate.ToString + Chr(254)
			GeneratedHash += FileCRC;
			
			return GeneratedHash;
		}
		
		public string GenEmailHash(string Subject, string EmailBody, string EmailCreateDate, string EmailAuthor, string NbrAttachments, string EmailExt)
		{
			string GeneratedHash = "";
			
			GeneratedHash += Subject + Strings.Chr(254);
			GeneratedHash += EmailBody + Strings.Chr(254);
			GeneratedHash += EmailCreateDate + Strings.Chr(254);
			GeneratedHash += EmailAuthor + Strings.Chr(254);
			GeneratedHash += NbrAttachments + Strings.Chr(254);
			GeneratedHash += EmailExt;
			
			return GeneratedHash;
		}
		
		
		public decimal HashCalc(string tString)
		{
			decimal iHash = 0;
			
			for (int i = 1; i <= tString.Length; i++)
			{
				int iAsc = Strings.Asc(tString.Substring(i - 1, 1));
				iHash = iHash + iAsc;
				iHash = iHash + i;
				if (i % 5 == 0)
				{
					iHash = iHash + System.Math.Sqrt((double) iHash);
					Math.Round(iHash, 6);
				}
			}
			Math.Round(iHash, 6);
			iHash = Truncate(iHash, 6);
			return iHash;
		}
		
		public string CalcFileCRC(string FQN)
		{
			
			Chilkat.ZipCrc zipCrc = new Chilkat.ZipCrc();
			long crc = 0;
			crc = zipCrc.FileCrc(FQN);
			string hexStr;
			hexStr = (string) (zipCrc.ToHex(crc));
			return hexStr;
			
		}
		
		public decimal Truncate(decimal value, int decimals)
		{
			
			return Math.Round(value - 0.5 / Math.Pow(10, decimals), decimals);
			
		}
		
		/// <summary>
		/// Get the MD5 Hash of a String
		/// </summary>
		/// <param name="strToHash">The String to Hash</param>
		/// <returns></returns>
		/// <remarks></remarks>
		public string getMD5HashX(string strToHash)
		{
			System.Security.Cryptography.MD5CryptoServiceProvider md5Obj = new System.Security.Cryptography.MD5CryptoServiceProvider();
			byte[] bytesToHash = System.Text.Encoding.UTF8.GetBytes(strToHash);
			
			bytesToHash = md5Obj.ComputeHash(bytesToHash);
			string strResult = (string) (System.Text.ASCIIEncoding.UTF8.GetString(bytesToHash));
			strResult = "";
			foreach (byte b in bytesToHash)
			{
				strResult += b.ToString("x2");
			}
			
			return strResult;
		}
		
		public string getSha1Hash(string strToHash)
		{
			
			System.Security.Cryptography.SHA1CryptoServiceProvider Sha1Obj = new System.Security.Cryptography.SHA1CryptoServiceProvider();
			byte[] bytesToHash = System.Text.Encoding.UTF8.GetBytes(strToHash);
			
			bytesToHash = Sha1Obj.ComputeHash(bytesToHash);
			
			string strResult = (string) (System.Text.ASCIIEncoding.UTF8.GetString(bytesToHash));
			strResult = "";
			foreach (byte b in bytesToHash)
			{
				strResult += b.ToString("x2");
			}
			
			return strResult;
		}
		
		private string GenerateHash(string SourceText)
		{
			//Create an encoding object to ensure the encoding standard for the source text
			UnicodeEncoding Ue = new UnicodeEncoding();
			//Retrieve a byte array based on the source text
			byte[] ByteSourceText = Ue.GetBytes(SourceText);
			//Instantiate an MD5 Provider object
			MD5CryptoServiceProvider Md5 = new MD5CryptoServiceProvider();
			//Compute the hash value from the source
			byte[] ByteHash = Md5.ComputeHash(ByteSourceText);
			//And convert it to String format for return
			return Convert.ToBase64String(ByteHash);
		}
		
	}
	
}

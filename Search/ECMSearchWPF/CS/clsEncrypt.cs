// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.Security.Cryptography;
using System.IO;
using System.Text;
using System.Windows.Forms;

/// <summary>
/// Copyright @ DMA, Ltd., January 2009, all rights reserved.
/// Encryption class used to encrypt and decrypt strings of data.
/// </summary>
/// <remarks></remarks>
namespace ECMSearchWPF
{
	public class clsEncrypt
	{
		
		bool ddebug = false;
		//Dim DMA As New clsDma
		//Dim UTIL As New clsUtility
		clsLogging LOG = new clsLogging();
		
		
		public string getCSGateway()
		{
			
			string CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			if (CS == null)
			{
				CS = "";
			}
			else
			{
				CS = CS.Replace("@@PW@@", TS);
			}
			return CS;
			
		}
		
		public string getCSRepo()
		{
			
			string CS = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			return CS;
			
		}
		
		public string XXI()
		{
			bool RC = true;
			string RetMsg = "";
			string XI = System.Configuration.ConfigurationManager.AppSettings["EncPW"];
			
			XI = DecryptTripleDES(XI);
			
			GC.Collect();
			return XI;
		}
		
		public string hashSha1File(object FQN)
		{
			
			FQN = FQN.replace("\'\'", "\'");
			
			string hashResult = string.Empty;
			FileInfo FI = new FileInfo(FQN.ToString());
			int fSize = FI.Length;
			FI = null;
			GC.Collect();
			
			int BUF_SIZE = 32;
			byte[] dataArray = new byte[BUF_SIZE - 1 + 1];
			byte[] FileBuffer = new byte[fSize + 1];
			SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
			
			System.IO.FileStream f;
			f = new System.IO.FileStream(FQN.ToString(), System.IO.FileMode.Open, System.IO.FileAccess.Read);
			f.Read(FileBuffer, 0, fSize - 1);
			
			byte[] result = sha.ComputeHash(dataArray);
			
			f.Close();
			f.Dispose();
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			hashResult = BitConverter.ToString(sha.Hash).Replace("-", "").ToLower();
			Console.WriteLine("Length: " + hashResult.Length.ToString() + "    : " + hashResult);
			return hashResult;
			
		}
		
		public string hashCrc32(string filePath)
		{
			int BUF_SIZE = 32;
			byte[] dataBuffer = new byte[BUF_SIZE - 1 + 1];
			byte[] dataBufferDummy = new byte[BUF_SIZE - 1 + 1];
			int dataBytesRead = 0;
			string hashResult = string.Empty;
			HashAlgorithm hashAlg = null;
			FileStream fs = null;
			
			var f = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 8192);
			var sha1 = new SHA1CryptoServiceProvider();
			byte[] Sha1Hash = sha1.ComputeHash(f);
			
			hashResult = BitConverter.ToString(Sha1Hash).Replace("-", "").ToLower();
			f.Close();
			f.Dispose();
			GC.Collect();
			return hashResult;
			
			//Try
			//    hashAlg = New MD5CryptoServiceProvider ' or New SHA1CryptoServiceProvider
			//    fs = New FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None, BUF_SIZE)
			//    Do
			//        dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE)
			//        hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0)
			//    Loop Until dataBytesRead = 0
			//    hashAlg.TransformFinalBlock(dataBuffer, 0, 0)
			//    hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower
			//Catch ex As IOException
			//    MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
			//Catch ex As UnauthorizedAccessException
			//    MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck")
			//Finally
			//    If Not fs Is Nothing Then
			//        fs.Close()
			//        fs.Dispose()
			//        fs = Nothing
			//    End If
			//    If Not hashAlg Is Nothing Then
			//        hashAlg.Clear() 'Dispose()
			//        hashAlg = Nothing
			//    End If
			//End Try
			//Return hashResult
		}
		
		public string hashSha1(string filePath)
		{
			int BUF_SIZE = 32;
			byte[] dataBuffer = new byte[BUF_SIZE - 1 + 1];
			byte[] dataBufferDummy = new byte[BUF_SIZE - 1 + 1];
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
					dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE);
					hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0);
				} while (!(dataBytesRead == 0));
				hashAlg.TransformFinalBlock(dataBuffer, 0, 0);
				hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower();
			}
			catch (IOException ex)
			{
				Interaction.MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck");
			}
			catch (UnauthorizedAccessException ex)
			{
				Interaction.MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck");
			}
			finally
			{
				if (fs != null)
				{
					fs.Close();
					fs.Dispose();
					fs = null;
				}
				if (hashAlg != null)
				{
					hashAlg.Clear(); //Dispose()
					hashAlg = null;
				}
			}
			return hashResult;
		}
		public string hashMd5(string filePath)
		{
			int BUF_SIZE = 32;
			byte[] dataBuffer = new byte[BUF_SIZE - 1 + 1];
			byte[] dataBufferDummy = new byte[BUF_SIZE - 1 + 1];
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
					dataBytesRead = fs.Read(dataBuffer, 0, BUF_SIZE);
					hashAlg.TransformBlock(dataBuffer, 0, dataBytesRead, dataBufferDummy, 0);
				} while (!(dataBytesRead == 0));
				hashAlg.TransformFinalBlock(dataBuffer, 0, 0);
				hashResult = BitConverter.ToString(hashAlg.Hash).Replace("-", "").ToLower();
			}
			catch (IOException ex)
			{
				Interaction.MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck");
			}
			catch (UnauthorizedAccessException ex)
			{
				Interaction.MsgBox(ex.Message, MsgBoxStyle.Critical, "IntegrityCheck");
			}
			finally
			{
				if (fs != null)
				{
					fs.Close();
					fs.Dispose();
					fs = null;
				}
				if (hashAlg != null)
				{
					hashAlg.Clear(); //Dispose()
					hashAlg = null;
				}
			}
			return hashResult;
		}
		
		public string EncryptString128Bit(string vstrTextToBeEncrypted, string vstrEncryptionKey)
		{
			
			byte[] bytValue = null;
			byte[] bytKey = null;
			byte[] bytEncoded = null;
			byte[] bytIV = new byte[] {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62};
			int intLength;
			int intRemaining;
			MemoryStream objMemoryStream = new MemoryStream();
			CryptoStream objCryptoStream;
			RijndaelManaged objRijndaelManaged;
			
			//   **********************************************************************
			//   ******  Strip any null character from string to be encrypted    ******
			//   **********************************************************************
			
			vstrTextToBeEncrypted = StripNullCharacters(vstrTextToBeEncrypted);
			
			//   **********************************************************************
			//   ******  Value must be within ASCII range (i.e., no DBCS chars)  ******
			//   **********************************************************************
			
			bytValue = Encoding.ASCII.GetBytes(vstrTextToBeEncrypted.ToCharArray());
			
			intLength = vstrEncryptionKey.Length;
			
			//   ********************************************************************
			//   ******   Encryption Key must be 256 bits long (32 bytes)      ******
			//   ******   If it is longer than 32 bytes it will be truncated.  ******
			//   ******   If it is shorter than 32 bytes it will be padded     ******
			//   ******   with upper-case Xs.                                  ******
			//   ********************************************************************
			
			if (intLength >= 32)
			{
				vstrEncryptionKey = Strings.Left(vstrEncryptionKey, 32);
			}
			else
			{
				intLength = vstrEncryptionKey.Length;
				intRemaining = System.Convert.ToInt32(32 - intLength);
				vstrEncryptionKey = vstrEncryptionKey + Strings.StrDup(intRemaining, "X");
			}
			
			bytKey = Encoding.ASCII.GetBytes(vstrEncryptionKey.ToCharArray());
			
			objRijndaelManaged = new RijndaelManaged();
			
			//   ***********************************************************************
			//   ******  Create the encryptor and write value to it after it is   ******
			//   ******  converted into a byte array                              ******
			//   ***********************************************************************
			
			try
			{
				
				objCryptoStream = new CryptoStream(objMemoryStream,
				objRijndaelManaged.CreateEncryptor(bytKey, bytIV),
				CryptoStreamMode.Write);
				objCryptoStream.Write(bytValue, 0, bytValue.Length);
				
				objCryptoStream.FlushFinalBlock();
				
				bytEncoded = objMemoryStream.ToArray();
				objMemoryStream.Close();
				objCryptoStream.Close();
			}
			catch
			{
				
			}
			
			//   ***********************************************************************
			//   ******   Return encryptes value (converted from  byte Array to   ******
			//   ******   a base64 string).  Base64 is MIME encoding)             ******
			//   ***********************************************************************
			
			return Convert.ToBase64String(bytEncoded);
			
		}
		
		public string DecryptString128Bit(string vstrStringToBeDecrypted, string vstrDecryptionKey)
		{
			
			byte[] bytDataToBeDecrypted;
			byte[] bytTemp;
			byte[] bytIV = new byte[] {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62};
			RijndaelManaged objRijndaelManaged = new RijndaelManaged();
			MemoryStream objMemoryStream;
			CryptoStream objCryptoStream;
			byte[] bytDecryptionKey;
			
			int intLength = 0;
			int intRemaining = 0;
			int intCtr = 0;
			string strReturnString = string.Empty;
			//Dim achrCharacterArray() As Char
			int intIndex = 0;
			
			//   *****************************************************************
			//   ******   Convert base64 encrypted value to byte array      ******
			//   *****************************************************************
			
			bytDataToBeDecrypted = Convert.FromBase64String(vstrStringToBeDecrypted);
			
			//   ********************************************************************
			//   ******   Encryption Key must be 256 bits long (32 bytes)      ******
			//   ******   If it is longer than 32 bytes it will be truncated.  ******
			//   ******   If it is shorter than 32 bytes it will be padded     ******
			//   ******   with upper-case Xs.                                  ******
			//   ********************************************************************
			
			intLength = vstrDecryptionKey.Length;
			
			if (intLength >= 32)
			{
				vstrDecryptionKey = Strings.Left(vstrDecryptionKey, 32);
			}
			else
			{
				intLength = vstrDecryptionKey.Length;
				intRemaining = System.Convert.ToInt32(32 - intLength);
				vstrDecryptionKey = vstrDecryptionKey + Strings.StrDup(intRemaining, "X");
			}
			
			bytDecryptionKey = Encoding.ASCII.GetBytes(vstrDecryptionKey.ToCharArray());
			
			bytTemp = new byte[bytDataToBeDecrypted.Length + 1];
			
			objMemoryStream = new MemoryStream(bytDataToBeDecrypted);
			
			//   ***********************************************************************
			//   ******  Create the decryptor and write value to it after it is   ******
			//   ******  converted into a byte array                              ******
			//   ***********************************************************************
			
			try
			{
				
				objCryptoStream = new CryptoStream(objMemoryStream,
				objRijndaelManaged.CreateDecryptor(bytDecryptionKey, bytIV),
				CryptoStreamMode.Read);
				
				objCryptoStream.Read(bytTemp, 0, bytTemp.Length);
				
				objCryptoStream.FlushFinalBlock();
				objMemoryStream.Close();
				objCryptoStream.Close();
				
			}
			catch
			{
				
			}
			
			//   *****************************************
			//   ******   Return decypted value     ******
			//   *****************************************
			
			return StripNullCharacters(Encoding.ASCII.GetString(bytTemp));
			
		}
		
		public string StripNullCharacters(string vstrStringWithNulls)
		{
			
			int intPosition;
			string strStringWithOutNulls;
			
			intPosition = 1;
			strStringWithOutNulls = vstrStringWithNulls;
			
			while (intPosition > 0)
			{
				intPosition = vstrStringWithNulls.IndexOf(Constants.vbNullChar, intPosition - 1) + 1;
				
				if (intPosition > 0)
				{
					strStringWithOutNulls = (string) (strStringWithOutNulls.Substring(0, intPosition - 1) + strStringWithOutNulls.Substring(strStringWithOutNulls.Length - strStringWithOutNulls.Length - intPosition, strStringWithOutNulls.Length - intPosition));
				}
				
				if (intPosition > strStringWithOutNulls.Length)
				{
					break;
				}
			}
			
			return strStringWithOutNulls;
			
		}
		
		public string EncryptTripleDES(string sIn, string sKey)
		{
			System.Security.Cryptography.TripleDESCryptoServiceProvider DES = new System.Security.Cryptography.TripleDESCryptoServiceProvider();
			System.Security.Cryptography.MD5CryptoServiceProvider hashMD5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
			// scramble the key
			sKey = ScrambleKey(sKey);
			// Compute the MD5 hash.
			DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
			// Set the cipher mode.
			DES.Mode = System.Security.Cryptography.CipherMode.ECB;
			// Create the encryptor.
			System.Security.Cryptography.ICryptoTransform DESEncrypt = DES.CreateEncryptor();
			// Get a byte array of the string.
			byte[] Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn);
			// Transform and return the string.
			return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
		}
		public string EncryptTripleDES(string sIn)
		{
			var sKey = bKey();
			System.Security.Cryptography.TripleDESCryptoServiceProvider DES = new System.Security.Cryptography.TripleDESCryptoServiceProvider();
			System.Security.Cryptography.MD5CryptoServiceProvider hashMD5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
			// scramble the key
			sKey = ScrambleKey(sKey.ToString());
			// Compute the MD5 hash.
			DES.Key = hashMD5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(sKey));
			// Set the cipher mode.
			DES.Mode = System.Security.Cryptography.CipherMode.ECB;
			// Create the encryptor.
			System.Security.Cryptography.ICryptoTransform DESEncrypt = DES.CreateEncryptor();
			// Get a byte array of the string.
			byte[] Buffer = System.Text.ASCIIEncoding.ASCII.GetBytes(sIn);
			// Transform and return the string.
			return Convert.ToBase64String(DESEncrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
		}
		
		public static string DecryptTripleDES(string sOut, string sKey)
		{
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
		public string DecryptTripleDES(string sOut)
		{
			
			if (sOut == null)
			{
				return "";
			}
			
			var sKey = bKey();
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
			try
			{
				return System.Text.ASCIIEncoding.ASCII.GetString(DESDecrypt.TransformFinalBlock(Buffer, 0, Buffer.Length));
			}
			catch (Exception)
			{
				MessageBox.Show("DecryptTripleDES - Error in decrypting string.");
				//** MsgBox("Error in decrypting string.")
			}
			return "";
		}
		
		private static string ScrambleKey(string v_strKey)
		{
			System.Text.StringBuilder sbKey = new System.Text.StringBuilder();
			int intPtr;
			for (intPtr = 1; intPtr <= v_strKey.Length; intPtr++)
			{
				int intIn = v_strKey.Length - intPtr + 1;
				sbKey.Append(v_strKey.Substring(intIn - 1, 1));
			}
			string strKey = sbKey.ToString();
			return sbKey.ToString();
		}
		
		private string bKey()
		{
			var S = "";
			
			S = S + "N";
			S = S + "o";
			S = S + "w";
			S = S + "I";
			S = S + "s";
			S = S + "T";
			S = S + "h";
			S = S + "e";
			S = S + "T";
			S = S + "i";
			S = S + "m";
			S = S + "e";
			S = S + "F";
			S = S + "o";
			S = S + "r";
			S = S + "A";
			S = S + "l";
			S = S + "l";
			S = S + "G";
			S = S + "o";
			S = S + "o";
			S = S + "d";
			S = S + "M";
			S = S + "e";
			S = S + "n";
			
			return S;
		}
		
		public SortedList<string, string> xt001trc(string S)
		{
			SortedList<string, string> A = new SortedList<string, string>();
			bool B = false;
			var SS = "";
			var tKey = "";
			var tVal = "";
			
			SS = DecryptTripleDES128(S, B);
			object[] AR = SS.Split('|');
			
			for (int k = 0; k <= (AR.Length - 1); k++)
			{
				if (ddebug)
				{
					Debug.Print(k.ToString() + ": " + AR[k].ToString());
				}
			}
			
			for (int i = 1; i <= (AR.Length - 1); i++)
			{
				
				if (i == 0)
				{
					Debug.Print("here");
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
						int iDx = A.ContainsKey(tKey);
						if (ddebug)
						{
							Debug.Print((string) ("KEY: " + tKey));
						}
						if (iDx <= 0)
						{
							A.Add(tKey, tVal);
							if (ddebug)
							{
								Debug.Print((string) ("Added Pair: " + tKey + ":" + tVal));
							}
						}
						else
						{
							if (ddebug)
							{
								Debug.Print((string) ("key exists: " + tKey + ":" + tVal));
							}
						}
					}
					catch (Exception ex)
					{
						MessageBox.Show((string) ("clsEncrypt : xt001trc : 104 : " + ex.Message));
					}
				}
			}
			return A;
		}
		private string xmp2rt21()
		{
			var S = "";
			
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
				MessageBox.Show((string) ("clsEncrypt : DecryptTripleDES : 141 : " + ex.Message));
				return "";
			}
		}
	}
}

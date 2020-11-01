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
using System.IO.IsolatedStorage;
//using System.IO.IsolatedStorage.IsolatedStorageFile;
//using System.IO.IsolatedStorage.IsolatedStorageFileStream;

//Imports System.Windows.Browser.HtmlPage

namespace EcmArchiveClcSetup
{
	public class clsIsolatedStorage
	{
		
		public string AppDir; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirPersist; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmPersistantData"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirAttachInfo; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmAttachInfo"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirFormData; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmForm"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirTempData; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmTemp"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirLogData; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmLogs"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public string dirSaveData; // VBConversions Note: Initial value of "Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmSavedData"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		//Public bDoNotOverwriteExistingFile As Boolean = True
		//Public bOverwriteExistingFile As Boolean = False
		//Public bRestoreToOriginalDirectory As Boolean = False
		//Public bRestoreToMyDocuments As Boolean = False
		//Public bCreateOriginalDirIfMissing As Boolean = True
		
		public clsIsolatedStorage()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			AppDir = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			dirPersist = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmPersistantData";
			dirAttachInfo = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmAttachInfo";
			dirFormData = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmForm";
			dirTempData = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmTemp";
			dirLogData = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmLogs";
			dirSaveData = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\" + "EcmSavedData";
			
			
			//Dim store = IsolatedStorageFile.GetUserStoreForApplication()
			//isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
			//Try
			//    store.CreateDirectory(dirAttachInfo)
			//Catch ex As Exception
			//    Console.WriteLine(ex.Message)
			//End Try
			
		}
		
		public void PersistDataInit(string tKey, string tData)
		{
			
			string FQN = System.IO.Path.Combine(dirPersist, "Persist.dat");
			byte[] Buffer;
			string tgtLine = tKey + "|" + tData + "\r\n";
			
			try
			{
				if (! Directory.Exists(dirPersist))
				{
					Directory.CreateDirectory(dirPersist);
				}
				
				Buffer = StrToByteArray(tgtLine);
				StreamWriter isoStream2 = new StreamWriter(FQN, false);
				isoStream2.WriteLine(tgtLine);
				isoStream2.Close();
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 700: saving data: " + ex.Message));
			}
		}
		
		public void PersistDataSave(string tKey, string tData)
		{
			
			//Dim dirFormData As String = "EcmTemp"
			string FQN = System.IO.Path.Combine(dirPersist, "Persist.dat");
			//Dim isoStore As IsolatedStorageFile
			//isoStore = IsolatedStorageFile.GetUserStoreForApplication
			byte[] Buffer;
			string tgtLine = tKey + "|" + tData + "\r\n";
			try
			{
				//Using store = IsolatedStorageFile.GetUserStoreForApplication()
				if (! Directory.Exists(dirPersist))
				{
					Directory.CreateDirectory(dirPersist);
				}
				
				Buffer = StrToByteArray(tgtLine);
				StreamWriter isoStream2 = new StreamWriter(FQN, true);
				isoStream2.Write(tgtLine);
				isoStream2.Close();
				
				//End Using
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 657: saving data: " + ex.Message));
			}
		}
		
		public string PersistDataRead(string tKey)
		{
			
			string FQN = System.IO.Path.Combine(dirPersist, "Persist.dat");
			string ValName = "";
			string tgtVal = "";
			string RetVal = "";
			
			//Dim isoStore As IsolatedStorageFile
			//isoStore = IsolatedStorageFile.GetUserStoreForApplication
			//Using isoStore
			if (File.Exists(FQN))
			{
				using (StreamReader sr = new StreamReader(FQN))
				{
					RetVal = "";
					tgtVal = sr.ReadLine();
					while (! sr.EndOfStream)
					{
						string[] A = tgtVal.Split("|".ToCharArray());
						if (A[0].Equals(tKey))
						{
							RetVal = A[1];
							break;
						}
						tgtVal = sr.ReadLine();
					}
					sr.Close();
				}
				
			}
			
			//End Using
			
			return RetVal;
			
		}
		
		public string readIsoFile(string Filename)
		{
			//If Not File.Exists(Filename) Then
			//    Return ""
			//End If
			string InputText = "";
			try
			{
				IsolatedStorageFile isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
				IsolatedStorageFileStream isolatedStream = new IsolatedStorageFileStream(Filename, FileMode.Open, isolatedStore);
				StreamReader reader = new StreamReader(isolatedStream);
				InputText = reader.ReadToEnd();
				reader.Close();
			}
			catch (Exception ex)
			{
				if (! modGlobals.gRunUnattended)
				{
					Console.WriteLine("Notice: Failed to READ data from isolated storage #122." + ex.Message);
				}
			}
			
			return InputText;
		}
		public void saveIsoFile(string FileName, string sLine)
		{
			try
			{
				IsolatedStorageFile isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
				IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FileName, FileMode.Append, FileAccess.Write, isolatedStore);
				
				StreamWriter writer = new StreamWriter(isoStream);
				writer.WriteLine(sLine);
				writer.Close();
			}
			catch (Exception ex)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show((string) ("Notice: Failed to save data to isolated storage #121." + ex.Message));
				}
			}
		}
		public void saveIsoFileZeroize(string FileName, string sLine)
		{
			try
			{
				IsolatedStorageFile isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
				IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FileName, FileMode.Create, FileAccess.Write, isolatedStore);
				
				StreamWriter writer = new StreamWriter(isoStream);
				writer.WriteLine(sLine);
				writer.Close();
				
			}
			catch (Exception ex)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show((string) ("Notice: Failed to save data to isolated storage #121." + ex.Message));
				}
			}
		}
		
		public static byte[] StrToByteArray(string str)
		{
			System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
			return encoding.GetBytes(str);
		} //StrToByteArray
		
		public bool isoDirExist()
		{
			//Using store = IsolatedStorageFile.GetUserStoreForApplication()
			using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly || IsolatedStorageScope.Domain, null, null))
			{
				foreach (string dName in isoStore.GetDirectoryNames(dirAttachInfo))
				{
					if (dName.Equals(dirAttachInfo))
					{
						return true;
					}
				}
			}
			
			return false;
		}
		public bool isoFileExist()
		{
			if (isoDirExist())
			{
				string FormDataFileName = "AttachInfo.dat";
				string FQN = System.IO.Path.Combine(dirAttachInfo, FormDataFileName);
				using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly || IsolatedStorageScope.Domain, null, null))
				{
					foreach (string fName in isoStore.GetFileNames(FQN))
					{
						if (fName.Equals("AttachInfo.dat"))
						{
							return true;
						}
					}
				}
				
			}
			return false;
		}
		
		public void ZeroizeAttachData()
		{
			string FormDataFileName = "AttachInfo.dat";
			string FQN = System.IO.Path.Combine(dirAttachInfo, FormDataFileName);
			
			try
			{
				if (isoDirExist())
				{
					using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly || IsolatedStorageScope.Domain, null, null))
					{
						isoStore.DeleteDirectory(dirAttachInfo);
					}
					
				}
			}
			catch (IsolatedStorageException ex)
			{
				Console.WriteLine("Error SaveFormData 100: saving data: " + ex.Message);
			}
		}
		
		public void SaveAttachData(string CompanyID, string RepoID)
		{
			
			string FormDataFileName = "AttachInfo.dat";
			string FQN = System.IO.Path.Combine(dirAttachInfo, FormDataFileName);
			string tgtLine = CompanyID + "|" + RepoID;
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly || IsolatedStorageScope.Domain, null, null);
			
			if (! isoDirExist())
			{
				isoStore.CreateDirectory(dirAttachInfo);
			}
			
			try
			{
				// Declare a new StreamWriter.
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(tgtLine + "\r\n");
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				Console.WriteLine("Error SaveFormData 200: saving data: " + ex.Message);
			}
			isoStore.Dispose();
			
		}
		
		public bool ReadAttachData(ref string CompanyID, ref string RepoID)
		{
			
			if (! this.isoFileExist())
			{
				return false;
			}
			
			CompanyID = "";
			RepoID = "";
			
			IsolatedStorageFile isoStore;
			bool B = true;
			string FormDataFileName = "AttachInfo.dat";
			string FQN = System.IO.Path.Combine(dirAttachInfo, FormDataFileName);
			string tgtLine = "";
			
			isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly || IsolatedStorageScope.Domain, null, null);
			StreamReader reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
			using (isoStore)
			{
				int fLen = 0;
				using (reader)
				{
					try
					{
						tgtLine = reader.ReadLine();
					}
					catch (Exception)
					{
						return false;
					}
					string[] A = tgtLine.Split("|".ToCharArray());
					CompanyID = A[0];
					RepoID = A[1];
					reader.Close();
					reader.Dispose();
				}
				
			}
			
			isoStore.Dispose();
			return B;
			
		}
		private bool FileExists(string FQN, IsolatedStorageFile storeFile)
		{
			
			string fileString = Path.GetFileName(FQN);
			
			string[] files;
			files = storeFile.GetFileNames(FQN);
			
			ArrayList fileList = new ArrayList(int.Parse(files));
			
			if (fileList.Count > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
			
			
		}
		
		
	}
	
	
	
}

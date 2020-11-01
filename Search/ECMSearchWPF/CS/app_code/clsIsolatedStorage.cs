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

using System.IO;
using System.IO.IsolatedStorage;
//using System.IO.IsolatedStorage.IsolatedStorageFile;
//using System.IO.IsolatedStorage.IsolatedStorageFileStream;

//Imports System.Windows.Browser.HtmlPage

namespace ECMSearchWPF
{
	public class clsIsolatedStorage
	{
		
		
		
		public string dirEcmGrids = "EcmGridParms";
		public string fnAllSearchEmailGrid = "dgEmailAll.grid.dat";
		public string fnAllSearchContentGrid = "dgContentAll.grid.dat";
		public string fnSearchContentGrid = "dgContent.grid.dat";
		public string fnSearchEmailGrid = "dgEmail.grid.dat";
		public string dirFormData = "EcmForm";
		public string dirTempData = "EcmTemp";
		public string dirLogData = "EcmLogs";
		public string dirSaveData = "EcmSavedData";
		
		public string dirRestore = "EcmRestoreFiles";
		string FileRestore = ".RestoreDat";
		
		public string dirPreview = "EcmPreviewFile";
		public string filePreview = "ECM.Preview.dat";
		
		public string dirSearchFilter = "EcmSearchFilter";
		public string dirCLC = "EcmSearchFilter";
		public string dirSearchSave = "EcmSavedSearch";
		public string dirDetailSearchParms = "EcmDetailSearchParm";
		public string dirFiles = "EcmTempFiles";
		public string dirPersist = "EcmPersistantData";
		
		public bool bDoNotOverwriteExistingFile = true;
		public bool bOverwriteExistingFile = false;
		public bool bRestoreToOriginalDirectory = false;
		public bool bRestoreToMyDocuments = false;
		public bool bCreateOriginalDirIfMissing = true;
		
		//Dim LOG As New clsLogging
		private IsolatedStorageFile Root;
		
		public clsIsolatedStorage()
		{
			
			var store = IsolatedStorageFile.GetUserStoreForApplication();
			
			if (! store.DirectoryExists(dirPersist))
			{
				store.CreateDirectory(dirPersist);
			}
			
			if (! store.DirectoryExists(dirFiles))
			{
				store.CreateDirectory(dirFiles);
			}
			
			if (! store.DirectoryExists(dirDetailSearchParms))
			{
				store.CreateDirectory(dirDetailSearchParms);
			}
			
			if (! store.DirectoryExists(dirSearchSave))
			{
				store.CreateDirectory(dirSearchSave);
			}
			
			if (! store.DirectoryExists(dirRestore))
			{
				store.CreateDirectory(dirRestore);
			}
			
			if (! store.DirectoryExists(dirPreview))
			{
				store.CreateDirectory(dirPreview);
			}
			
			if (! store.DirectoryExists(dirLogData))
			{
				store.CreateDirectory(dirLogData);
			}
			
			if (! store.DirectoryExists(dirSaveData))
			{
				store.CreateDirectory(dirSaveData);
			}
			
			if (! store.DirectoryExists(dirFormData))
			{
				store.CreateDirectory(dirFormData);
			}
			
			if (! store.DirectoryExists(dirEcmGrids))
			{
				store.CreateDirectory(dirEcmGrids);
			}
			
			if (! store.DirectoryExists(dirTempData))
			{
				store.CreateDirectory(dirTempData);
			}
			
			if (! store.DirectoryExists(dirSearchFilter))
			{
				store.CreateDirectory(dirSearchFilter);
			}
			
			if (! store.DirectoryExists(dirCLC))
			{
				store.CreateDirectory(dirCLC);
			}
			
		}
		
		public string getGridDir()
		{
			return dirEcmGrids;
		}
		public string getFormsDir()
		{
			return dirEcmGrids;
		}
		public string getTempDir()
		{
			return dirTempData;
		}
		
		//Public Sub SetCookie(ByVal tKey As String, ByVal tValue As String)
		//    Dim Days As Integer = 365 * 3
		//    Dim expireDate As DateTime = DateTime.Now + TimeSpan.FromDays(Days)
		//    Dim newCookie As String = tKey + "=" + tValue + ""
		//    System.Windows.Browser.HtmlPage.Document.SetProperty("cookie", newCookie)
		//End Sub
		
		//Public Function GetCookie(ByVal key As String) As String
		//    Dim cookies() As String = System.Windows.Browser.HtmlPage.Document.Cookies.Split(";")
		//    Dim keyValue() As String
		//    Dim tgtVal As String = ""
		//    For Each cookie As String In cookies
		//        keyValue = cookie.Split("=")
		//        'if (keyValue.Length == 2) then
		//        If (keyValue(0).ToString().Equals(key)) Then
		//            tgtVal = keyValue(1)
		//            Exit For
		//        End If
		//        'End If
		//    Next
		//    Return tgtVal
		//End Function
		
		public static byte[] StrToByteArray(string str)
		{
			System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
			return encoding.GetBytes(str);
		} //StrToByteArray
		
		public void ZeroizeSaveFormData(int IndexKey, string ScreenName, string SaveTypeCode, string UID, string ValName, string ValValue)
		{
			string FormDataFileName = ScreenName + IndexKey.ToString() + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = "@@" + Strings.ChrW(254) + DateTime.Now.ToString() + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					Buffer = StrToByteArray(tgtLine);
					
					if (store.FileExists(FQN))
					{
						IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Truncate, isoStore);
						//isoStream2.Write(Buffer, 0, Buffer.Length)
						isoStream2.Close();
					}
					else
					{
						IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
						isoStream2.Write(Buffer, 0, Buffer.Length);
						isoStream2.Close();
					}
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 100: saving data: " + ex.Message));
			}
		}
		
		public void SaveFormData(Dictionary<string, string> DICT, int IndexKey, string ScreenName, string UID, string ValName, string ValValue)
		{
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FormDataFileName = ScreenName + IndexKey.ToString() + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			
			string tgtLine = ValName + Strings.ChrW(254) + ValValue;
			if (DICT.ContainsKey(ValName))
			{
				DICT.Item(ValName) = ValValue;
			}
			else
			{
				DICT.Add(ValName, ValValue);
			}
			
			try
			{
				// Declare a new StreamWriter.
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
				writer.WriteLine(tgtLine);
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
		
		public bool ReadFormData(Dictionary<string, string> DICT, int IndexKey, string ScreenName, string UID)
		{
			
			IsolatedStorageFile isoStore;
			
			bool B = true;
			string FormDataFileName = ScreenName + IndexKey.ToString() + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			string tgtVal = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			if (! isoStore.FileExists(FQN))
			{
				return false;
			}
			
			//Dim Buffer() As Byte
			string tgtLine = "";
			
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			//ReadFile = New Byte(1023) {}
			//p.Read(Buffer, 0, ReadFile.Length)
			//p.Close()
			//Return ReadFile
			
			using (isoStore)
			{
				//Load form data
				string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
				//Check to see if file exists before proceeding
				int fLen = 0;
				//If isoStore.FileExists(filePath) Then
				//    fLen = isoStore.fil
				//End If
				using (StreamReader sr = new StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read)))
				{
					string formData = "";
					try
					{
						formData = sr.ReadLine();
					}
					catch (Exception)
					{
						return true;
					}
					int II = 0;
					while (! sr.EndOfStream)
					{
						II++;
						if (II > 100)
						{
							break;
						}
						if (formData.Trim().Length > 0)
						{
							string[] A = formData.Split(Strings.ChrW(254).ToString().ToCharArray());
							string tKey = A[0];
							string tValue = A[1];
							if (DICT.ContainsKey(tKey))
							{
								DICT.Item(tKey) = tValue;
							}
							else
							{
								DICT.Add(tKey, tValue);
							}
							formData = sr.ReadLine();
						}
					}
					sr.Close();
					sr.Dispose();
				}
				
			}
			
			isoStore.Dispose();
			return B;
			
		}
		
		//***********************************************************************************
		public void ZeroizeGridSortOrder(string ScreenName, string GridName, string ColName, string SortType, string UID)
		{
			
			string FormDataFileName = ScreenName + "." + GridName + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = "@@" + Strings.ChrW(254) + DateTime.Now.ToString() + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					Buffer = StrToByteArray(tgtLine);
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 300: saving data: " + ex.Message));
			}
			finally
			{
				isoStore = null;
				GC.Collect();
			}
		}
		
		public void saveGridSortCol(string ScreenName, string GridName, string ColName, string SortType, string UID)
		{
			
			ZeroizeGridSortOrder(ScreenName, GridName, ColName, SortType, UID);
			
			//Dim dirFormData As String = "FormData"
			string FormDataFileName = ScreenName + "." + GridName + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = ColName + Strings.ChrW(254) + SortType + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					Buffer = StrToByteArray(tgtLine);
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 400: saving data: " + ex.Message));
			}
			finally
			{
				isoStore = null;
				GC.Collect();
			}
		}
		
		public void getGridSortCol(string ScreenName, string GridName, ref string ColName, ref string SortType, string UID, ref bool RC)
		{
			string FormDataFileName = ScreenName + "." + GridName + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			string tgtVal = "";
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			string tgtLine = ColName + Strings.ChrW(254) + SortType + "\r\n";
			
			try
			{
				RC = true;
				using (isoStore)
				{
					//Load form data
					string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
					//Check to see if file exists before proceeding
					if (! isoStore.FileExists(filePath))
					{
						ColName = "";
						SortType = "";
						RC = false;
						goto endOfTry;
					}
					using (StreamReader sr = new StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read)))
					{
						string formData = "";
						while (formData == sr.ReadLine())
						{
							string[] A = formData.Split(Strings.ChrW(254).ToString().ToCharArray());
							string tKey = A[0];
							string tValue = A[1];
							if (! tValue.Equals("@@"))
							{
								ColName = tKey;
								SortType = tValue;
								break;
							}
						}
						sr.Close();
					}
					
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: ReadGridSortOrder - 100: " + ex.Message));
				RC = false;
			}
			finally
			{
				dirFormData = null;
				FormDataFileName = null;
				FQN = null;
				tgtVal = null;
				isoStore = null;
				tgtLine = null;
				GC.Collect();
			}
endOfTry:
			1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
		}
		
		//********************************************************************************************************************************************************
		public void ZeroizeGridColDisplayOrder(string ScreenName, string GridName, string ColumnName, string UID, string ValName, string ValValue)
		{
			
			//Dim dirFormData As String = "FormData"
			string FormDataFileName = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = "@@" + Strings.ChrW(254) + DateTime.Now.ToString() + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					Buffer = StrToByteArray(tgtLine);
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 500: saving data: " + ex.Message));
			}
		}
		
		public void SaveGridColDisplayOrder(string ScreenName, string GridName, string UID, Dictionary<int, string> DICT)
		{
			
			string FormDataFileName = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = "";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
					string StringOfData = "";
					
					foreach (string tKey in DICT.Keys)
					{
						string tValue = (string) (DICT.Item(tKey));
						tgtLine = tKey + Strings.ChrW(254) + tValue + Strings.ChrW(253);
						StringOfData += tgtLine;
					}
					
					Buffer = StrToByteArray(StringOfData);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 600: saving data: " + ex.Message));
			}
		}
		
		public void ReadGridColDisplayOrder(string ScreenName, string GridName, string UID, Dictionary<int, string> DICT)
		{
			
			string FormDataFileName = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			if (! isoStore.FileExists(FQN))
			{
				return;
			}
			
			//Dim p = New IsolatedStorageFileStream(FQN,System.IO.FileMode.Open,System.IO.FileAccess.Read, isoStore)
			IsolatedStorageFileStream p = new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore);
			
			DICT.Clear();
			
			using (isoStore)
			{
				//Load form data
				string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
				//Check to see if file exists before proceeding
				if (isoStore.FileExists(filePath))
				{
					Console.WriteLine("File Exists: " + filePath);
				}
				//Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
				using (StreamReader sr = new StreamReader(p))
				{
					string AllData = "";
					string lineData = sr.ReadLine();
					while (lineData != null)
					{
						string[] A = lineData.Split(Strings.ChrW(253).ToString().ToCharArray());
						for (int II = 0; II <= A.Length - 1; II++)
						{
							string tempLine = A[II];
							string[] bArray = tempLine.Split(Strings.ChrW(254).ToString().ToCharArray());
							if (bArray[0].Length > 0)
							{
								string ColumnDisplayOrder = bArray[0];
								string ColumnName = bArray[1];
								if (DICT.ContainsKey(ColumnDisplayOrder))
								{
								}
								else
								{
									DICT.Add(ColumnDisplayOrder, ColumnName);
								}
							}
						}
						lineData = sr.ReadLine();
					}
					sr.Close();
				}
				
			}
			
			
		}
		
		public void SaveUserData(string UID)
		{
			
			//Dim dirFormData As String = "EcmTemp"
			string FQN = System.IO.Path.Combine(dirFormData, "UINFO.dat");
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = UID;
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					
					Buffer = StrToByteArray(tgtLine);
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 700: saving data: " + ex.Message));
			}
		}
		
		public string ReadUserData()
		{
			//Dim dirFormData As String = "EcmTemp"
			string FQN = System.IO.Path.Combine(dirFormData, "UINFO.dat");
			string ValName = "";
			string tgtVal = "";
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			//Dim p = New IsolatedStorageFileStream(FQN,System.IO.FileMode.Open,System.IO.FileAccess.Read, isoStore)
			
			using (isoStore)
			{
				if (isoStore.FileExists(FQN))
				{
					using (StreamReader sr = new StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read)))
					{
						tgtVal = sr.ReadLine();
						sr.Close();
					}
					
				}
				
			}
			
			
			return tgtVal;
			
		}
		
		public string DeletedUserData()
		{
			//Dim dirFormData As String = "EcmTemp"
			string FQN = System.IO.Path.Combine(dirFormData, "UINFO.dat");
			string ValName = "";
			string tgtVal = "";
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			
			using (isoStore)
			{
				if (isoStore.FileExists(FQN))
				{
					isoStore.DeleteFile(FQN);
				}
				
			}
			
			
			return tgtVal;
			
		}
		
		
		private void WriteLineToFile(string FileName, string Msg)
		{
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			try
			{
				StreamWriter writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
				// Have the writer write MSG to the store.
				writer.WriteLine(Msg);
				writer.Close();
				writer = null;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: WriteLineToFile - " + ex.Message));
			}
			
		}
		
		private string ReadFromFileLineByLine(string FileName)
		{
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			StreamReader reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
			// Read a line from the file and add it to sb.
			string sb;
			sb = reader.ReadLine();
			while (!reader.EndOfStream)
			{
				
				sb = reader.ReadLine();
			}
			reader.Close();
			reader = null;
			return sb;
		}
		
		private void SaveGridSetup(string ScreenName, string UserID, DataGrid DG, Dictionary<int, string> DICT)
		{
			DICT.Clear();
			
			string ColName = "";
			string FileName = ScreenName + ".Grid." + DG.Name + "." + UserID + ".dat";
			string Msg = "";
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			//Dim W As GridLength
			//Dim V As Boolean = True
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			try
			{
				StreamWriter writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
				// Have the writer write MSG to the store.
				for (int I = 0; I <= DG.Columns.Count - 1; I++)
				{
					ColName = (string) (DG.Columns[I].Header);
					//W = DG.Columns(I).Width
					//V = DG.Columns(I).Visible
					if (DICT.ContainsKey(I))
					{
						DICT.Item(I) = ColName;
					}
					else
					{
						DICT.Add(I, ColName);
					}
				}
				writer.WriteLine(Msg);
				writer.Close();
				writer = null;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: WriteLineToFile - " + ex.Message));
			}
			
		}
		
		private void getGridSetup(string ScreenName, string UserID, DataGrid DG, Dictionary<int, string> DICT)
		{
			
			DICT.Clear();
			
			string[] A;
			string FileName = ScreenName + ".Grid." + DG.Name + "." + UserID + ".dat";
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			StreamReader reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
			// Read a line from the file and add it to sb.
			string sb;
			sb = reader.ReadLine();
			while (!reader.EndOfStream)
			{
				A = sb.Split(Strings.ChrW(254).ToString().ToCharArray());
				int I = int.Parse(A[0]);
				string tCol = A[1];
				if (DICT.ContainsKey(I))
				{
					DICT.Item(I) = tCol;
				}
				else
				{
					DICT.Add(I, tCol);
				}
				sb = reader.ReadLine();
			}
			reader.Close();
			reader = null;
			
		}
		
		
		private void SaveScreenSetup(string ScreenName, string UserID, Dictionary<int, string> DICT)
		{
			DICT.Clear();
			
			string tName = "";
			string tVal = "";
			string FileName = ScreenName + ".Screen." + UserID + ".dat";
			string Msg = "";
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			//Dim W As GridLength
			bool V = true;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			try
			{
				StreamWriter writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				// Have the writer write MSG to the store.
				foreach (string S in DICT.Keys)
				{
					tName = S;
					tVal = (string) (DICT.Item(S));
					writer.WriteLine(S + Strings.ChrW(254) + tVal);
				}
				writer.Close();
				writer = null;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: WriteLineToFile - " + ex.Message));
			}
			
		}
		
		private void getScreenSetup(string ScreenName, string UserID, Dictionary<int, string> DICT)
		{
			
			DICT.Clear();
			
			string[] A;
			string FileName = ScreenName + ".Screen." + UserID + ".dat";
			string FQN = System.IO.Path.Combine(dirSaveData, FileName);
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			StreamReader reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
			// Read a line from the file and add it to sb.
			string sb;
			sb = reader.ReadLine();
			while (!reader.EndOfStream)
			{
				A = sb.Split(Strings.ChrW(254).ToString().ToCharArray());
				int I = int.Parse(A[0]);
				string tCol = A[1];
				if (DICT.ContainsKey(I))
				{
					DICT.Item(I) = tCol;
				}
				else
				{
					DICT.Add(I, tCol);
				}
				sb = reader.ReadLine();
			}
			reader.Close();
			reader = null;
			
		}
		
		public void SaveFileRestoreData(string UID, List<string> listOfGuids)
		{
			
			int RecodsAdded = 0;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string MO = DateTime.Now.Month.ToString();
			string DA = DateTime.Now.Day.ToString();
			string YR = DateTime.Now.Year.ToString();
			string MN = DateTime.Now.Minute.ToString();
			string MS = DateTime.Now.Millisecond.ToString();
			
			string FormDataFileName = (string) ("ECM." + YR + "." + MO + "." + DA + "." + MN + "." + MS + FileRestore);
			string FQN = System.IO.Path.Combine(dirRestore, FormDataFileName);
			
			foreach (string S in listOfGuids)
			{
				try
				{
					RecodsAdded++;
					// Declare a new StreamWriter.
					StreamWriter writer = null;
					// Assign the writer to the store and the file TestStore.
					if (RecodsAdded == 1)
					{
						writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
					}
					else
					{
						writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
					}
					
					writer.WriteLine(S);
					writer.Close();
					writer.Dispose();
					writer = null;
				}
				catch (IsolatedStorageException ex)
				{
					MessageBox.Show((string) ("Error SaveFormData 800: saving data: " + ex.Message));
				}
			}
			
			isoStore.Dispose();
			
		}
		public void initFileRestoreData()
		{
			
			int RecodsAdded = 0;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string MO = DateTime.Now.Month.ToString();
			string DA = DateTime.Now.Day.ToString();
			string YR = DateTime.Now.Year.ToString();
			string MN = DateTime.Now.Minute.ToString();
			string MS = DateTime.Now.Millisecond.ToString();
			
			string FormDataFileName = "ECM.FileRestore.CURR";
			string FQN = System.IO.Path.Combine(dirRestore, FormDataFileName);
			string s = DateTime.Now.ToString();
			try
			{
				StreamWriter writer = null;
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(s);
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 800: saving data: " + ex.Message));
			}
			
			isoStore.Dispose();
			
		}
		public void initFilePreviewData()
		{
			
			int RecodsAdded = 0;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string MO = DateTime.Now.Month.ToString();
			string DA = DateTime.Now.Day.ToString();
			string YR = DateTime.Now.Year.ToString();
			string MN = DateTime.Now.Minute.ToString();
			string MS = DateTime.Now.Millisecond.ToString();
			
			string FormDataFileName = "ECM.Preview.CURR";
			string FQN = System.IO.Path.Combine(dirPreview, FormDataFileName);
			string s = DateTime.Now.ToString();
			try
			{
				StreamWriter writer = null;
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(s);
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 800: saving data: " + ex.Message));
			}
			
			isoStore.Dispose();
			
		}
		public bool ReadFileRestoreData(string UID, System.Windows.Documents.List<string> L)
		{
			
			bool B = true;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FormDataFileName = "Restore" + ".dat";
			string FQN = System.IO.Path.Combine(dirRestore, FormDataFileName);
			
			if (! isoStore.FileExists(FQN))
			{
				return false;
			}
			
			//Dim Buffer() As Byte
			string tgtLine = "";
			
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			
			using (isoStore)
			{
				//Load form data
				string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
				//Check to see if file exists before proceeding
				int fLen = 0;
				//If isoStore.FileExists(filePath) Then
				//    fLen = isoStore.fil
				//End If
				using (StreamReader sr = new StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read)))
				{
					string FileToRestore = "";
					try
					{
						FileToRestore = sr.ReadLine();
					}
					catch (Exception)
					{
						return true;
					}
					int II = 0;
					while (! sr.EndOfStream)
					{
						II++;
						if (II > 100)
						{
							break;
						}
						if (FileToRestore.Trim().Length > 0)
						{
							string[] A = FileToRestore.Split(Strings.ChrW(254).ToString().ToCharArray());
							string tKey = A[0];
							string tValue = A[1];
							if (L.Contains(FileToRestore))
							{
							}
							else
							{
								L.Add(FileToRestore);
							}
							FileToRestore = sr.ReadLine();
						}
					}
					sr.Close();
					sr.Dispose();
				}
				
			}
			
			isoStore.Dispose();
			return B;
		}
		
		public void SaveFilePreviewGuid(string UID, string tgtTable, string tgtGuid, string StoredFQN)
		{
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			int MO = int.Parse(DateAndTime.Today.Month.ToString());
			int DA = int.Parse(DateAndTime.Today.Day.ToString());
			
			string FormDataFileName = filePreview;
			string FQN = System.IO.Path.Combine(dirPreview, FormDataFileName);
			try
			{
				string S = tgtTable + Strings.ChrW(254) + tgtGuid + Strings.ChrW(254) + StoredFQN;
				// Declare a new StreamWriter.
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(S);
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 900: saving data: " + ex.Message));
			}
			
			isoStore.Dispose();
			
		}
		
		public string ReadFilePreviewData(string tgtGuid, string StoredFQN)
		{
			
			string GuidToDownLoad = "";
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			int MO = int.Parse(DateAndTime.Today.Month.ToString());
			int DA = int.Parse(DateAndTime.Today.Day.ToString());
			
			string FormDataFileName = filePreview;
			string FQN = System.IO.Path.Combine(dirPreview, FormDataFileName);
			
			if (! isoStore.FileExists(FQN))
			{
				return false;
			}
			
			//Dim Buffer() As Byte
			string tgtLine = "";
			
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			
			using (isoStore)
			{
				//Load form data
				string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
				//Check to see if file exists before proceeding
				int fLen = 0;
				//If isoStore.FileExists(filePath) Then
				//    fLen = isoStore.fil
				//End If
				using (StreamReader sr = new StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read)))
				{
					try
					{
						GuidToDownLoad = sr.ReadLine();
					}
					catch (Exception)
					{
						return true;
					}
					sr.Close();
					sr.Dispose();
				}
				
			}
			
			isoStore.Dispose();
			return GuidToDownLoad;
		}
		
		public void getSearchFilters(string SearchName, string UserID, Dictionary<string, string> SearchDICT)
		{
			
			SearchDICT.Clear();
			
			string[] A;
			string FileName = SearchName + ".Search." + UserID + ".dat";
			string FQN = System.IO.Path.Combine(dirSearchFilter, FileName);
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			if (! isoStore.FileExists(FQN))
			{
				return;
			}
			
			StreamReader reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
			string sb;
			sb = reader.ReadLine();
			while (!reader.EndOfStream)
			{
				A = sb.Split(Strings.ChrW(254).ToString().ToCharArray());
				for (int X = 0; X <= (A.Length - 1); X++)
				{
					string TempStr = A[X];
					string[] A1 = TempStr.Split(Strings.ChrW(254).ToString().ToCharArray());
					string ParmName = A1[0];
					string ParmVal = A1[1];
					if (SearchDICT.ContainsKey(ParmName))
					{
						SearchDICT.Item(ParmName) = ParmVal;
					}
					else
					{
						SearchDICT.Add(ParmName, ParmVal);
					}
				}
				sb = reader.ReadLine();
			}
			reader.Close();
			reader = null;
			
		}
		
		public void saveSearchFilters(string SearchName, string UID, Dictionary<string, string> SearchDICT)
		{
			
			SearchDICT.Clear();
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FileName = SearchName + ".Search." + ".dat";
			string FQN = System.IO.Path.Combine(dirSearchFilter, FileName);
			
			StreamWriter writer = null;
			// Assign the writer to the store and the file TestStore.
			writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
			
			foreach (string S in SearchDICT.Keys)
			{
				
				string ValName = "";
				string ValValue = "";
				ValName = S;
				ValValue = (string) (SearchDICT.Item(S));
				string tgtLine = ValName + Strings.ChrW(254) + ValValue;
				try
				{
					writer.WriteLine(tgtLine);
				}
				catch (IsolatedStorageException ex)
				{
					MessageBox.Show((string) ("Error SaveSearchParms 200: saving data: " + ex.Message));
				}
				
				writer.Close();
				writer.Dispose();
				
			}
			isoStore.Dispose();
		}
		public void SetCLC_Statex(string UID, string currState, string CompanyID, string RepoID)
		{
			
			//** NO NO NO
			currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper();
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FileName = "CLC.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			
			StreamWriter writer = null;
			writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
			try
			{
				writer.WriteLine(currState);
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SetCLC_Active 200: saving data: " + ex.Message));
			}
			
			writer.Close();
			writer.Dispose();
			isoStore.Dispose();
		}
		public string SetCLC_State2(string UID, string currState, string CompanyID, string RepoID)
		{
			
			string EP = GLOBALS.GatewayEndPoint + "\r\n" + GLOBALS.DownloadEndPoint;
			
			currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper() + "|" + GLOBALS._SecureID.ToString() + "|" + GLOBALS.GatewayEndPoint + "|" + GLOBALS.gENCGWCS + "|" + GLOBALS.DownloadEndPoint + "|" + DateTime.Now.ToString();
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FileName = "SAAS.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			
			if (isoStore.FileExists(FQN))
			{
				try
				{
					isoStore.DeleteFile(FQN);
				}
				catch (Exception)
				{
					Console.WriteLine("Failed to delete ISO Store");
				}
				
				StreamWriter ofile = null;
				try
				{
					ofile = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
					ofile.WriteLine(currState);
				}
				catch (IsolatedStorageException ex)
				{
					MessageBox.Show((string) ("Error SetCLC_Active 201: saving data: " + ex.Message));
				}
				finally
				{
					if (ofile == null)
					{
						Console.WriteLine("Ofile is nothing");
					}
					else
					{
						ofile.Close();
						ofile.Dispose();
					}
				}
				
				
				isoStore.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
				return EP;
			}
			
			StreamWriter writer = null;
			try
			{
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(currState);
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SetCLC_Active 200: saving data: " + ex.Message));
			}
			
			if (writer == null)
			{
				Console.WriteLine("Writer does not exist");
			}
			else
			{
				writer.Close();
				writer.Dispose();
			}
			
			isoStore.Dispose();
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			return EP;
		}
		
		public bool isClcActive(string UID)
		{
			
			//C:\Users\wmiller\AppData\LocalLow\Microsoft\Silverlight\is\42fotd3y.o1g\h3lraamt.gka\1\s\1slx5pjb0uazhq0mvvi1zkh5pl5te3cec1zm1hrdv0jeguazg2aaaaga\f
			
			string FileName = "CLC.RUNNING";
			bool B = false;
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			IsolatedStorageFile isoStore;
			bool bFileExists = false;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			//YES YES
			if (! isoStore.DirectoryExists(dirCLC))
			{
				isoStore.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
				return false;
			}
			else
			{
				string EP = SetCLC_State2(UID, "SEARCH READY", GLOBALS._CompanyID, GLOBALS._RepoID);
				
			}
			
			foreach (string sFile in isoStore.GetFileNames(dirCLC + "\\*.*"))
			{
				Console.WriteLine(sFile);
				if (sFile.ToUpper().Equals("CLC.RUNNING"))
				{
					bFileExists = true;
					B = true;
				}
			}
			
			if (! bFileExists)
			{
				B = false;
			}
			
			isoStore.Dispose();
			return B;
		}
		
		public bool isClcInstalled()
		{
			bool B = false;
			string FileName = "CLC.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			if (! isoStore.FileExists(FQN))
			{
				B = false;
			}
			else
			{
				B = true;
			}
			
			isoStore.Dispose();
			return B;
		}
		
		public string getIsoDirPath(string TgtDir)
		{
			
			bool B = false;
			string FileName = "CLC.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, "*.*");
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			string tDir = "";
			foreach (string S in isoStore.GetDirectoryNames())
			{
				tDir += S + "\r\n";
			}
			MessageBox.Show(tDir);
			isoStore.Dispose();
			return B;
		}
		public string deleteIsoDir(string TgtDir)
		{
			
			bool B = false;
			string FileName = "CLC.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, "*.*");
			IsolatedStorageFile isoStore;
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			if (isoStore.DirectoryExists(TgtDir))
			{
				isoStore.DeleteDirectory(TgtDir);
			}
			isoStore.Dispose();
			return B;
		}
		
		public void SaveSearchByName(string SearchName, Dictionary<string, string> DICT)
		{
			
			bool ErrorShown = false;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				string FormDataFileName = "SEARCH." + SearchName + ".dat";
				string FQN = System.IO.Path.Combine(dirSearchSave, FormDataFileName);
				
				StreamWriter writer = null;
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
				
				foreach (string sKey in DICT.Keys)
				{
					string tVal = (string) (DICT.Item(sKey));
					string tLine = sKey + Strings.ChrW(254) + tVal;
					writer.WriteLine(tLine);
				}
				
				writer.Close();
				writer.Dispose();
				writer = null;
				
			}
			catch (Exception ex)
			{
				if (! ErrorShown)
				{
					MessageBox.Show((string) ("ERROR: SaveSearchByName 100 - " + ex.Message));
					ErrorShown = true;
				}
			}
			finally
			{
				isoStore.Dispose();
			}
		}
		
		public bool ReadSearchDataByName(string SearchName, Dictionary<string, string> DICT)
		{
			
			DICT.Clear();
			
			IsolatedStorageFile isoStore;
			
			bool B = true;
			string FormDataFileName = "SEARCH." + SearchName + ".dat";
			string FQN = System.IO.Path.Combine(dirFormData, FormDataFileName);
			string tgtVal = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			if (! isoStore.FileExists(FQN))
			{
				return false;
			}
			
			//Dim Buffer() As Byte
			string tgtLine = "";
			
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			//ReadFile = New Byte(1023) {}
			//p.Read(Buffer, 0, ReadFile.Length)
			//p.Close()
			//Return ReadFile
			
			using (isoStore)
			{
				//Load form data
				string filePath = System.IO.Path.Combine(dirFormData, FormDataFileName);
				//Check to see if file exists before proceeding
				int fLen = 0;
				//If isoStore.FileExists(filePath) Then
				//    fLen = isoStore.fil
				//End If
				using (StreamReader sr = new StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read)))
				{
					string formData = "";
					try
					{
						formData = sr.ReadLine();
					}
					catch (Exception)
					{
						return true;
					}
					int II = 0;
					while (! sr.EndOfStream)
					{
						II++;
						if (II > 100)
						{
							break;
						}
						if (formData.Trim().Length > 0)
						{
							string[] A = formData.Split(Strings.ChrW(254).ToString().ToCharArray());
							string tKey = A[0];
							string tValue = A[1];
							if (DICT.ContainsKey(tKey))
							{
								DICT.Item(tKey) = tValue;
							}
							else
							{
								DICT.Add(tKey, tValue);
							}
							formData = sr.ReadLine();
						}
					}
					sr.Close();
					sr.Dispose();
				}
				
			}
			
			isoStore.Dispose();
			return B;
			
		}
		
		public void SaveDetailSearchParms(string DetailType, Dictionary<string, string> DICT)
		{
			
			if (! DetailType.Equals("EMAIL") && ! DetailType.Equals("CONTENT"))
			{
				MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.");
				return;
			}
			
			bool ErrorShown = false;
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				string FormDataFileName = "SEARCH." + DetailType + ".dat";
				string FQN = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName);
				
				StreamWriter writer = null;
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				
				foreach (string sKey in DICT.Keys)
				{
					string tVal = (string) (DICT.Item(sKey));
					string tLine = sKey + Strings.ChrW(254) + tVal;
					writer.WriteLine(tLine);
				}
				
				writer.Close();
				writer.Dispose();
				writer = null;
				
			}
			catch (Exception ex)
			{
				if (! ErrorShown)
				{
					MessageBox.Show((string) ("ERROR: SaveSearchByName 100 - " + ex.Message));
					ErrorShown = true;
				}
			}
			finally
			{
				isoStore.Dispose();
			}
		}
		
		public bool ReadDetailSearchParms(string DetailType, Dictionary<string, string> DICT)
		{
			
			if (! DetailType.Equals("EMAIL") && ! DetailType.Equals("CONTENT"))
			{
				MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.");
				return false;
			}
			
			DICT.Clear();
			
			IsolatedStorageFile isoStore;
			
			bool B = true;
			string FormDataFileName = "SEARCH." + DetailType + ".dat";
			string FQN = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName);
			string tgtVal = "";
			
			string Msg = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			if (! isoStore.FileExists(FQN))
			{
				return true;
			}
			
			//Dim Buffer() As Byte
			string tgtLine = "";
			
			var p = new IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore);
			//ReadFile = New Byte(1023) {}
			//p.Read(Buffer, 0, ReadFile.Length)
			//p.Close()
			//Return ReadFile
			
			using (isoStore)
			{
				int fLen = 0;
				//If isoStore.FileExists(filePath) Then
				//    fLen = isoStore.fil
				//End If
				using (StreamReader sr = new StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read)))
				{
					string formData = "";
					try
					{
						formData = sr.ReadLine();
					}
					catch (Exception)
					{
						return true;
					}
					int II = 0;
					while (! sr.EndOfStream)
					{
						II++;
						if (II > 100)
						{
							break;
						}
						if (formData.Trim().Length > 0)
						{
							string[] A = formData.Split(Strings.ChrW(254).ToString().ToCharArray());
							string tKey = A[0];
							string tValue = A[1];
							Msg += tKey + Strings.ChrW(9) + tValue + "\r\n";
							if (DICT.ContainsKey(tKey))
							{
								DICT.Item(tKey) = tValue;
							}
							else
							{
								DICT.Add(tKey, tValue);
							}
							formData = sr.ReadLine();
						}
					}
					sr.Close();
					sr.Dispose();
				}
				
			}
			
			
			isoStore.Dispose();
			return B;
			
		}
		
		public bool DeleteDetailSearchParms(string DetailType)
		{
			
			if (! DetailType.Equals("EMAIL") && ! DetailType.Equals("CONTENT"))
			{
				MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.");
				return false;
			}
			
			IsolatedStorageFile isoStore;
			
			bool B = true;
			string FormDataFileName = "SEARCH." + DetailType + ".dat";
			string FQN = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName);
			string tgtVal = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				if (isoStore.FileExists(FQN))
				{
					isoStore.DeleteFile(FQN);
				}
				B = true;
			}
			catch (Exception)
			{
				B = false;
			}
			
			isoStore.Dispose();
			return B;
			
		}
		public bool DeleteClcReadyStatus()
		{
			
			IsolatedStorageFile isoStore;
			bool B = true;
			string FileName = "SAAS.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			string tgtVal = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			try
			{
				if (isoStore.FileExists(FQN))
				{
					isoStore.DeleteFile(FQN);
				}
				B = true;
			}
			catch (Exception)
			{
				B = false;
			}
			
			isoStore.Dispose();
			
			//B = DeleteSearchRunning()
			
			return B;
			
		}
		
		public bool DeleteSearchRunning()
		{
			
			IsolatedStorageFile isoStore;
			bool B = true;
			string FileName = "CLC.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			string tgtVal = "";
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				if (isoStore.FileExists(FQN))
				{
					isoStore.DeleteFile(FQN);
				}
				B = true;
			}
			catch (Exception)
			{
				B = false;
			}
			
			isoStore.Dispose();
			return B;
			
		}
		
		public bool ZeroizeTempFile(string FileNameOnly)
		{
			
			IsolatedStorageFile isoStore;
			bool B = true;
			string FileName = FileNameOnly;
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				if (isoStore.FileExists(FQN))
				{
					isoStore.DeleteFile(FQN);
				}
				B = true;
			}
			catch (Exception)
			{
				
			}
			return B;
		}
		public bool AppendTempFile(string FileNameOnly, string tgtLine)
		{
			
			IsolatedStorageFile isoStore;
			bool B = true;
			string FileName = FileNameOnly;
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			try
			{
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore));
				writer.WriteLine(tgtLine);
				writer.Close();
				writer.Dispose();
				writer = null;
				B = true;
			}
			catch (Exception)
			{
				B = false;
			}
			return B;
		}
		
		public void PersistDataInit(string tKey, string tData)
		{
			
			//Dim dirFormData As String = "EcmTemp"
			string FQN = System.IO.Path.Combine(dirPersist, "Persist.dat");
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = tKey + "|" + tData + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					Buffer = StrToByteArray(tgtLine);
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
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
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			byte[] Buffer;
			string tgtLine = tKey + "|" + tData + "\r\n";
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					if (! store.DirectoryExists(dirFormData))
					{
						store.CreateDirectory(dirFormData);
					}
					Buffer = StrToByteArray(tgtLine);
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Append, isoStore);
					isoStream2.Write(Buffer, 0, Buffer.Length);
					isoStream2.Close();
					
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 700: saving data: " + ex.Message));
			}
		}
		
		public string PersistDataRead(string tKey)
		{
			
			string FQN = System.IO.Path.Combine(dirPersist, "Persist.dat");
			string ValName = "";
			string tgtVal = "";
			string RetVal = "";
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			using (isoStore)
			{
				if (isoStore.FileExists(FQN))
				{
					using (StreamReader sr = new StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read)))
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
				
			}
			
			
			return RetVal;
			
		}
		
		public void PreviewFileInit(string CompanyID, string RepoID, string UnencryptedCS)
		{
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FormDataFileName = "EcmActiveInstance.DAT";
			string FQN = System.IO.Path.Combine(dirCLC, FormDataFileName);
			try
			{
				string S = CompanyID + "|" + RepoID + "|" + UnencryptedCS;
				// Declare a new StreamWriter.
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(S);
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error initPreviewFIle 900: saving data: " + ex.Message));
			}
			
			isoStore.Dispose();
			
		}
		public void PreviewFileZeroize()
		{
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FormDataFileName = "EcmActiveInstance.DAT";
			string FQN = System.IO.Path.Combine(dirCLC, FormDataFileName);
			try
			{
				string S = "X";
				// Declare a new StreamWriter.
				StreamWriter writer = null;
				// Assign the writer to the store and the file TestStore.
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(S);
				writer.Close();
				writer.Dispose();
				writer = null;
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error initPreviewFIle 900: saving data: " + ex.Message));
			}
			
			isoStore.Dispose();
			
		}
		
		public string SetSAAS_State(string UID, string currState, string CompanyID, string RepoID)
		{
			
			string EP = GLOBALS.GatewayEndPoint + "\r\n" + GLOBALS.DownloadEndPoint;
			currState = currState.ToUpper();
			
			//** NO NO NO
			if (currState.Equals("ACTIVE") || currState.Equals("INACTIVE"))
			{
			}
			else
			{
				MessageBox.Show("The state parameter must be ACTIVE or INACTIVE only - error, returning.");
				return EP;
			}
			
			currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper() + "|" + GLOBALS._SecureID.ToString() + "|" + GLOBALS.GatewayEndPoint + "|" + GLOBALS.gENCGWCS + "|" + GLOBALS.DownloadEndPoint + "|" + DateTime.Now.ToString();
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			
			string FileName = "SAAS.RUNNING";
			string FQN = System.IO.Path.Combine(dirCLC, FileName);
			
			if (File.Exists(FQN))
			{
				return EP;
			}
			
			StreamWriter writer = null;
			try
			{
				writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
				writer.WriteLine(currState);
			}
			catch (IsolatedStorageException ex)
			{
				Console.WriteLine("Error SetSAAS_State 200: saving data: " + ex.Message);
			}
			if (writer == null)
			{
				Console.WriteLine("Writer was not allocated");
			}
			else
			{
				writer.Close();
				writer.Dispose();
			}
			isoStore.Dispose();
			return EP;
		}
		
		public Stream ReadPdfToStream(string ReportName)
		{
			
			bool b = true;
			string FormDataDirectory = "Reports";
			string FormDataFileName = ReportName + ".PDF";
			string FQN = System.IO.Path.Combine(FormDataDirectory, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			//Dim Buffer() As Byte
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(FormDataDirectory))
					{
						store.CreateDirectory(FormDataDirectory);
					}
					
					//Buffer = StrToByteArray(fileStream)
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore);
					
					//isoStream2.re()
					//isoStream2.Close()
					return isoStream2;
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 100: saving data: " + ex.Message));
				b = false;
			}
			
			return null;
			
		}
		
		public Stream ReadHtmlToStream(string ReportName)
		{
			
			bool b = true;
			string FormDataDirectory = "Reports";
			string FormDataFileName = ReportName;
			string FQN = System.IO.Path.Combine(FormDataDirectory, FormDataFileName);
			
			IsolatedStorageFile isoStore;
			isoStore = IsolatedStorageFile.GetUserStoreForApplication();
			//Dim Buffer() As Byte
			try
			{
				using (var store = IsolatedStorageFile.GetUserStoreForApplication())
				{
					int TotalFields = 4;
					if (! store.DirectoryExists(FormDataDirectory))
					{
						store.CreateDirectory(FormDataDirectory);
					}
					
					//Buffer = StrToByteArray(fileStream)
					
					IsolatedStorageFileStream isoStream2 = new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore);
					
					//isoStream2.re()
					//isoStream2.Close()
					return isoStream2;
				}
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show((string) ("Error SaveFormData 100: saving data: " + ex.Message));
				b = false;
			}
			
			return null;
			
		}
		
		public void RequestMoreIso()
		{
			try
			{
				using (IsolatedStorageFile isof = IsolatedStorageFile.GetUserStoreForApplication())
				{
					long freeSpace = isof.AvailableFreeSpace;
					long needSpace = 20971520;
					// 20 MB in bytes
					if (freeSpace < needSpace)
					{
						if (! isof.IncreaseQuotaTo(isof.Quota + needSpace))
						{
							MessageBox.Show("User rejected increase space request");
						}
						else
						{
							MessageBox.Show("Space Increased");
						}
					}
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Request for more storage failed: " + ex.Message));
			}
		}
		
		//Function readIsoFile(ByVal Filename As String) As String
		//    Dim InputText As String = ""
		//    Try
		//        Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
		//        Dim isolatedStream As New IsolatedStorageFileStream(Filename, FileMode.Open, isolatedStore)
		//        Using reader As New StreamReader(isolatedStream)
		//            InputText = reader.ReadToEnd
		//        End Using
		//    Catch ex As Exception
		//        If Not gRunUnattended Then
		//            MessageBox.Show("Notice: Failed to READ data from isolated storage #122." + ex.Message)
		//        End If
		//    End Try
		
		//    Return InputText
		//End Function
		//Public Sub saveIsoFile(ByVal FileName As String, ByVal sLine As String)
		//    Try
		//        Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
		//        Dim isoStream As New IsolatedStorageFileStream(FileName, FileMode.Append, FileAccess.Write, isolatedStore)
		
		//        Using writer As New StreamWriter(isoStream)
		//            writer.WriteLine(sLine)
		//        End Using
		//    Catch ex As Exception
		//        If Not gRunUnattended Then
		//            MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message)
		//        End If
		//    End Try
		//End Sub
	}
	
	
	
}

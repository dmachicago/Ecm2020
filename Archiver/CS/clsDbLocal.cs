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

using System.Configuration;
using System.Data.SqlServerCe;
using System.IO;


namespace EcmArchiveClcSetup
{
	public class clsDbLocal
	{
		
		clsEncrypt ENC = new clsEncrypt();
		clsLogging LOG = new clsLogging();
		
		private string ContactCS = "";
		private string ZipCS = "";
		private string FileCS = "";
		private string DirCS = "";
		private string InvCS = "";
		private string OutlookCS = "";
		private string ExchangeCS = "";
		private string ListenerCS = "";
		
		private SqlCeConnection ConnContact = new SqlCeConnection();
		private SqlCeConnection ConnFile = new SqlCeConnection();
		private SqlCeConnection ConnDir = new SqlCeConnection();
		private SqlCeConnection ConnInv = new SqlCeConnection();
		private SqlCeConnection ConnOutlook = new SqlCeConnection();
		private SqlCeConnection ConnExchange = new SqlCeConnection();
		private SqlCeConnection ConnListener = new SqlCeConnection();
		private SqlCeConnection ConnZip = new SqlCeConnection();
		
		string CePath = "";
		
		public clsDbLocal()
		{
			
			string tPath = System.IO.Path.GetTempPath();
			tPath = tPath + "EcmLibrary\\CE";
			CePath = tPath;
			
			CopyDatabases();
			
			//connectionString = "Data Source=" + (System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase) + "\\ce_db.sdf;Persist Security Info=False;";
			//Dim aName As String = System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase
			//Dim aDir As String = System.IO.Path.GetDirectoryName(aName)
			//aDir = Mid(aDir, 7)
			
			//'FileCS = System.Configuration.ConfigurationManager.ConnectionStrings("FileDB").ToString
			//FileCS = "Data Source=" + aDir + "\data\FileDB.sdf;Persist Security Info=False;"
			//'DirCS = System.Configuration.ConfigurationManager.ConnectionStrings("DirDB").ToString
			//DirCS = "Data Source=" + aDir + "\data\DirDB.sdf;Persist Security Info=False;"
			//'InvCS = System.Configuration.ConfigurationManager.ConnectionStrings("HashDB").ToString
			//InvCS = "Data Source=" + aDir + "\data\EcmFileStore.sdf;Persist Security Info=False;"
			//OutlookCS = "Data Source=" + aDir + "\data\OutlookEmail.sdf;Persist Security Info=False;"
			//ExchangeCS = "Data Source=" + aDir + "\data\ExchangeEmail.sdf;Persist Security Info=False;"
			//ListenerCS = "Data Source=" + aDir + "\data\Listeners.sdf;Persist Security Info=False;"
			
			//Dim SYSPATH As String = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase)
			//'SYSPATH = SYSPATH + "\data"
			//If InStr(SYSPATH, "File:\", CompareMethod.Text) > 0 Then
			//    SYSPATH = SYSPATH.Substring(6)
			//End If
			//SYSPATH = SYSPATH + "\CE"
			
			//FileCS = "Data Source=" + SYSPATH + "\FileDB.sdf;Persist Security Info=False;"
			//DirCS = "Data Source=" + SYSPATH + "\DirDB.sdf;Persist Security Info=False;"
			//InvCS = "Data Source=" + SYSPATH + "\EcmFileStore.sdf;Persist Security Info=False;"
			//OutlookCS = "Data Source=" + SYSPATH + "\OutlookEmail.sdf;Persist Security Info=False;"
			//ExchangeCS = "Data Source=" + SYSPATH + "\ExchangeEmail.sdf;Persist Security Info=False;"
			//ListenerCS = "Data Source=" + SYSPATH + "\Listeners.sdf;Persist Security Info=False;"
			
			if (! File.Exists(CePath + "\\OutlookContacts.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\OutlookContacts.sdf");
			}
			if (! File.Exists(CePath + "\\ZipFiles.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\ZipFiles.sdf");
			}
			if (! File.Exists(CePath + "\\FileDB.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\FileDB.sdf");
			}
			if (! File.Exists(CePath + "\\DirDB.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\DirDB.sdf");
			}
			if (! File.Exists(CePath + "\\EcmFileStore.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\EcmFileStore.sdf");
			}
			if (! File.Exists(CePath + "\\OutlookEmail.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\OutlookEmail.sdf");
			}
			if (! File.Exists(CePath + "\\ExchangeEmail.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\ExchangeEmail.sdf");
			}
			if (! File.Exists(CePath + "\\Listeners.sdf"))
			{
				MessageBox.Show("MISSING: " + CePath + "\\Listeners.sdf");
			}
			
			ContactCS = "Data Source=" + CePath + "\\OutlookContacts.sdf;Persist Security Info=False;";
			ZipCS = "Data Source=" + CePath + "\\ZipFiles.sdf;Persist Security Info=False;";
			FileCS = "Data Source=" + CePath + "\\FileDB.sdf;Persist Security Info=False;";
			DirCS = "Data Source=" + CePath + "\\DirDB.sdf;Persist Security Info=False;";
			InvCS = "Data Source=" + CePath + "\\EcmFileStore.sdf;Persist Security Info=False;";
			OutlookCS = "Data Source=" + CePath + "\\OutlookEmail.sdf;Persist Security Info=False;";
			ExchangeCS = "Data Source=" + CePath + "\\ExchangeEmail.sdf;Persist Security Info=False;";
			ListenerCS = "Data Source=" + CePath + "\\Listeners.sdf;Persist Security Info=False;";
			
			try
			{
				ConnContact.ConnectionString = ContactCS;
				ConnContact.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.92 clsDbLocal/ConnContact - " + ex.Message));
			}
			
			try
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.92 clsDbLocal/ConnZip - " + ex.Message));
			}
			
			try
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.9 clsDbLocal - " + ex.Message));
			}
			
			try
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.4 clsDbLocal - " + ex.Message));
			}
			
			try
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.5 clsDbLocal - " + ex.Message));
			}
			
			try
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.6 clsDbLocal - " + ex.Message));
			}
			
			try
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.1 clsDbLocal - " + ex.Message));
			}
			
			try
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100.2 clsDbLocal - " + ex.Message));
			}
			
		}
		
		public void CopyDatabases()
		{
			
			if (Directory.Exists(CePath))
			{
			}
			else
			{
				Directory.CreateDirectory(CePath);
			}
			
			FindCeDatabase(CePath);
			
		}
		
		public string FindCeDatabase(string NewPath)
		{
			string S = "";
			string SYSPATH = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
			
			if (SYSPATH.IndexOf("File:\\") + 1 > 0)
			{
				SYSPATH = SYSPATH.Substring(6);
			}
			SYSPATH = SYSPATH;
			string PartPath = "";
			for (int i = SYSPATH.Length; i >= 1; i--)
			{
				string CH = SYSPATH.Substring(i - 1, 1);
				if (CH == "\\")
				{
					PartPath = SYSPATH.Substring(0, i - 1);
					break;
				}
			}
			ArrayList listOfFiles = new ArrayList();
			
			RecursiveSearch(PartPath, ref listOfFiles);
			
			string NewCE = "";
			foreach (string fName in listOfFiles)
			{
				Console.WriteLine(fName);
				if (fName.IndexOf("OutlookContacts.sdf") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "OutlookContacts.sdf";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("ZipFiles.sdf") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "ZipFiles.sdf";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("Listeners.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "Listeners.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("ExchangeEmail.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "ExchangeEmail.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("OutlookEmail.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "OutlookEmail.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("EcmFileStore.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "EcmFileStore.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("DIRDB.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "DIRDB.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
				if (fName.IndexOf("FileDB.SDF") + 1 > 0)
				{
					NewCE = NewPath + "\\" + "FileDB.SDF";
					if (File.Exists(NewCE))
					{
					}
					else
					{
						File.Copy(fName, NewCE);
					}
				}
			}
			
			return S;
		}
		
		private void RecursiveSearch(string strDirectory, ref ArrayList array)
		{
			System.IO.DirectoryInfo dirInfo = new System.IO.DirectoryInfo(strDirectory);
			// Try to get the files for this directory
			System.IO.FileInfo[] pFileInfo;
			try
			{
				pFileInfo = dirInfo.GetFiles("*.sdf");
			}
			catch (UnauthorizedAccessException ex)
			{
				MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}
			// Add the file infos to the array
			array.AddRange(pFileInfo);
			if (pFileInfo.Length > 0)
			{
				for (int i = 0; i <= array.Count - 1; i++)
				{
					string S = array[i].ToString();
					if (S.IndexOf(":") + 1 > 0)
					{
					}
					else
					{
						array[i] = strDirectory + "\\" + array[i] .ToString();
					}
				}
			}
			
			// Try to get the subdirectories of this one
			System.IO.DirectoryInfo[] pdirInfo;
			try
			{
				pdirInfo = dirInfo.GetDirectories();
			}
			catch (UnauthorizedAccessException ex)
			{
				MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}
			// Iterate through each directory and recurse!
			System.IO.DirectoryInfo dirIter;
			foreach (System.IO.DirectoryInfo tempLoopVar_dirIter in pdirInfo)
			{
				dirIter = tempLoopVar_dirIter;
				RecursiveSearch(dirIter.FullName, ref array);
			}
		}
		
		
		~clsDbLocal()
		{
			base.Finalize();
			
			if (ConnFile.State == ConnectionState.Open)
			{
				ConnFile.Close();
			}
			ConnFile.Dispose();
			
			if (ConnDir.State == ConnectionState.Open)
			{
				ConnDir.Close();
			}
			ConnDir.Dispose();
			
			if (ConnInv.State == ConnectionState.Open)
			{
				ConnInv.Close();
			}
			ConnInv.Dispose();
			
			if (ConnOutlook.State == ConnectionState.Open)
			{
				ConnOutlook.Close();
			}
			ConnOutlook.Dispose();
			
			if (ConnExchange.State == ConnectionState.Open)
			{
				ConnExchange.Close();
			}
			ConnExchange.Dispose();
			
			if (ConnListener.State == ConnectionState.Open)
			{
				ConnListener.Close();
			}
			ConnListener.Dispose();
			
		} //Finalize
		
		public void InventoryDir(string DirName, bool bUseArchiveBit)
		{
			bool B = true;
			int DirID = GetDirID(DirName);
			if (DirID < 0)
			{
				B = addDir(DirName, bUseArchiveBit);
				if (! B)
				{
					LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory directory \'" + DirName + "\'.");
				}
			}
			
		}
		
		public void InventoryFile(string FileName, string FileHash)
		{
			bool B = true;
			int FileID = GetFileID(FileName, FileHash);
			if (FileID < 0)
			{
				B = addFile(FileName, FileHash);
				if (! B)
				{
					LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory file \'" + FileName + "\'.");
				}
			}
			
		}
		
		public int GetDirID(string DirName)
		{
			
			DirName = DirName.Replace("\'", "\'\'");
			int DirID = -1;
			string S = "Select DirID from Directory where DirName = \'" + DirName + "\' ";
			//Dim cn As New SqlCeConnection(DirCS)
			
			if (ConnDir.State == ConnectionState.Closed)
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			
			SqlCeCommand cmd = ConnDir.CreateCommand();
			try
			{
				
				cmd.CommandText = S;
				
				
				//** if you don’t set the result set to scrollable HasRows does not work
				//Dim rs As SqlCeResultSet = cmd.ExecuteReader()
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				cmd.ExecuteNonQuery();
				
				if (rs.HasRows)
				{
					rs.Read();
					DirID = rs.GetInt32(0);
				}
				else
				{
					DirID = -1;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/GetDirID - " + ex.Message + "\r\n" + S));
				DirID = -1;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return DirID;
			
		}
		
		public int GetDirID(string DirName, ref bool UseArchiveBit)
		{
			
			UseArchiveBit = false;
			int DirID = -1;
			string S = "Select DirID,UseArchiveBit from Directory where DirName = \'" + DirName + "\' ";
			//Dim cn As New SqlCeConnection(DirCS)
			
			try
			{
				if (ConnDir.State == ConnectionState.Closed)
				{
					ConnDir.ConnectionString = DirCS;
					ConnDir.Open();
				}
				
				SqlCeCommand cmd = new SqlCeCommand(S, ConnDir);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					DirID = System.Convert.ToInt32(rs.GetValue(int.Parse("DirID")));
					UseArchiveBit = rs.GetBoolean(int.Parse("UseArchiveBit"));
				}
				else
				{
					UseArchiveBit = false;
					DirID = -1;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/GetDirID - " + ex.Message + "\r\n" + S));
				DirID = -1;
			}
			finally
			{
				
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return DirID;
			
		}
		
		public bool addDir(string FQN, bool bUseArchiveBit)
		{
			
			
			bool B = true;
			int UseArchiveBit = 0;
			if (bUseArchiveBit)
			{
				UseArchiveBit = 1;
			}
			
			string S = "Insert into Directory (DirName,UseArchiveBit) values (\'" + FQN + "\', " + UseArchiveBit.ToString() + ") ";
			//Dim S As String = "Insert into Directory (DirName,UseArchiveBit) values (@DirName, @UseArchiveBit) "
			
			//Dim cn As New SqlCeConnection(DirCS)
			
			if (ConnDir.State == ConnectionState.Closed)
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			
			SqlCeCommand cmd = ConnDir.CreateCommand();
			cmd.CommandText = "Select DirName,UseArchiveBit from directory where 1 = 2";
			SqlCeResultSet RS = cmd.ExecuteResultSet(ResultSetOptions.Updatable);
			
			//Dim cmd As New SqlCeCommand(S, cn)
			try
			{
				//cmd.Parameters.AddWithValue("@DirName", FQN)
				//cmd.Parameters.AddWithValue("@UseArchiveBit", UseArchiveBit)
				//cmd.ExecuteNonQuery()
				
				SqlCeUpdatableRecord Rec = RS.CreateRecord();
				Rec.SetString(0, FQN);
				Rec.SetBoolean(1, bUseArchiveBit);
				RS.Insert(Rec);
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addDir - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				if (! RS.IsClosed)
				{
					RS.Close();
				}
				RS.Dispose();
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool delDir(string DirName)
		{
			
			bool B = true;
			string S = "Delete from Directory where DirName = @DirName ";
			
			//Dim cn As New SqlCeConnection(DirCS)
			if (ConnDir.State == ConnectionState.Closed)
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnDir);
			try
			{
				cmd.Parameters.AddWithValue("@DirName", DirName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delDir - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public int GetFileID(string FileName, string FileHash)
		{
			
			FileName = FileName.Replace("\'", "\'\'");
			int FileID = -1;
			string S = "Select FileID from Files where FileName = \'" + FileName + "\' and Filehash = \'" + FileHash + "\' ";
			
			//Dim cn As New SqlCeConnection(FileCS)
			
			try
			{
				if (ConnFile.State == ConnectionState.Closed)
				{
					ConnFile.ConnectionString = FileCS;
					ConnFile.Open();
				}
				
				SqlCeCommand cmd = new SqlCeCommand(S, ConnFile);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				//Dim rs As SqlCeResultSet = cmd.ExecuteReader()
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					FileID = rs.GetInt32(0);
				}
				else
				{
					FileID = -1;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/GetDirID - " + ex.Message + "\r\n" + S));
				FileID = -1;
			}
			finally
			{
				
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return FileID;
			
		}
		
		public bool addFile(string FileName, string FileHash)
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			string S = "Insert into Files (FileName, FileHash) values (@FileName, @FileHash) ";
			
			if (ConnFile.State == ConnectionState.Closed)
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnFile);
			try
			{
				cmd.Parameters.AddWithValue("@FileName", FileName);
				cmd.Parameters.AddWithValue("@FileHash", FileHash);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addFile - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool addContact(string FullName, string Email1Address)
		{
			
			if (Email1Address == null)
			{
				Email1Address = "NA";
			}
			
			
			
			bool B = true;
			int UseArchiveBit = 0;
			
			string S = "Insert into ContactsArchive (Email1Address, FullName) values (@Email1Address, @FullName) ";
			
			if (ConnContact.State == ConnectionState.Closed)
			{
				ConnContact.ConnectionString = ContactCS;
				ConnContact.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnContact);
			try
			{
				cmd.Parameters.AddWithValue("@Email1Address", Email1Address);
				cmd.Parameters.AddWithValue("@FullName", FullName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addContact - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool fileExists(string FileName)
		{
			
			bool B = false;
			string S = "Select count(*) from Files where FileName = \'" + FileName + "\' ";
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnFile.State == ConnectionState.Closed)
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			
			int iCnt = 0;
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnFile);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					iCnt = rs.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/fileExists - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool contactExists(string FullName, string Email1Address)
		{
			
			bool B = false;
			string S = "Select count(*) from ContactsArchive where Email1Address = \'" + Email1Address + "\' and FullName = \'" + FullName + "\' ";
			
			if (ConnContact.State == ConnectionState.Closed)
			{
				ConnContact.ConnectionString = ContactCS;
				ConnContact.Open();
			}
			
			int iCnt = 0;
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnContact);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					iCnt = rs.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/contactExists - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		public bool delFile(string FileName)
		{
			
			bool B = true;
			string S = "Delete from Files where FileName = @FileName ";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnFile.State == ConnectionState.Closed)
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnFile);
			try
			{
				cmd.Parameters.AddWithValue("@DirName", FileName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delFile - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool addInventoryForce(string FQN, bool bArchiveBit)
		{
			
			int iArchiveFlag = 0;
			int FileExist = 1;
			int NeedsArchive = 1;
			int UseArchiveBit = 0;
			int DirID = 0;
			int FileID = 0;
			int FileSize = 0;
			bool B = true;
			FileInfo FI = new FileInfo(FQN);
			string sDirName = "";
			string sFileName = "";
			DateTime LastUpdate = null;
			int ArchiveBit = 1;
			string FileHash = "";
			
			if (bArchiveBit)
			{
				ArchiveBit = 1;
			}
			else
			{
				ArchiveBit = 0;
			}
			
			FQN = FQN.Replace("\'\'", "\'");
			FileHash = ENC.hashSha1File(FQN);
			sFileName = sFileName.Replace("\'\'", "\'");
			sDirName = sDirName.Replace("\'\'", "\'");
			try
			{
				sDirName = FI.DirectoryName;
				sFileName = FI.Name;
				FileSize = FI.Length;
				LastUpdate = FI.LastWriteTime;
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message));
				return B;
			}
			sFileName = sFileName.Replace("\'\'", "\'");
			sDirName = sDirName.Replace("\'\'", "\'");
			
			DirID = GetDirID(sDirName);
			FileID = GetFileID(sFileName, FileHash);
			
			if (DirID < 0)
			{
				B = addDir(sDirName, false);
				LOG.WriteToArchiveLog("NOTICE: clsDbLocal/setInventoryArchive 01 - Added directory " + sDirName + ".");
				DirID = GetDirID(sDirName);
			}
			if (FileID < 0)
			{
				B = addFile(sFileName, FileHash);
				LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".");
				FileID = GetFileID(sFileName, FileHash);
			}
			
			if (InventoryExists(DirID, FileID, FileHash))
			{
				return true;
			}
			
			
			//Dim S As String = "Insert into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
			string S = "Insert into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
			S += "(@DirID, @FileID, @FileExist, @FileSize,@LastUpdate,@ArchiveBit,@NeedsArchive,@FileHash)";
			
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.Parameters.AddWithValue("@DirID", DirID);
				cmd.Parameters.AddWithValue("@FileID", FileID);
				cmd.Parameters.AddWithValue("@FileExist", FileExist);
				cmd.Parameters.AddWithValue("@FileSize", FileSize);
				cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
				cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
				cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
				cmd.Parameters.AddWithValue("@FileHash", FileHash);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addInventory - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool addInventory(int DirID, int FileID, long FileSize, DateTime LastUpdate, bool ArchiveBit, string FileHash)
		{
			
			bool FileExist = true;
			bool NeedsArchive = true;
			bool B = true;
			int UseArchiveBit = 0;
			
			//Dim S As String = "Insert into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
			string S = "Insert into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values ";
			S += "(@DirID, @FileID, @FileExist, @FileSize,@LastUpdate,@ArchiveBit,@NeedsArchive,@FileHash)";
			
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.Parameters.AddWithValue("@DirID", DirID);
				cmd.Parameters.AddWithValue("@FileID", FileID);
				cmd.Parameters.AddWithValue("@FileExist", FileExist);
				cmd.Parameters.AddWithValue("@FileSize", FileSize);
				cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
				cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
				cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
				cmd.Parameters.AddWithValue("@FileHash", FileHash);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addInventory - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool delInventory(int DirID, int FileID)
		{
			
			int FileExist = 1;
			int NeedsArchive = 1;
			bool B = true;
			int UseArchiveBit = 0;
			
			string S = (string) ("delete from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString());
			
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.Parameters.AddWithValue("@DirID", DirID);
				cmd.Parameters.AddWithValue("@FileID", FileID);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delInventory - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool InventoryExists(int DirID, int FileID, string CRC)
		{
			
			bool B = false;
			string S = (string) ("Select FileHash from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString());
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			int iCnt = 0;
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					CRC = rs.GetString(0);
					B = true;
				}
				else
				{
					CRC = "";
					B = false;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/InventoryExists - " + ex.Message + "\r\n" + S));
				CRC = "";
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool InventoryHashCompare(int DirID, int FileID, string CurrHash)
		{
			
			bool B = false;
			string S = "Select FileHash from Inventory where DirID = X and FileID = X ";
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			string OldHash = "";
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					OldHash = System.Convert.ToString(rs.GetInt32(0));
				}
				else
				{
					OldHash = "";
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (CurrHash.Equals(OldHash))
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/InventoryExists - " + ex.Message + "\r\n" + S));
				FileID = -1;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool setInventoryArchive(string FQN, bool ArchiveFlag, string FileHash)
		{
			
			bool B = true;
			FileInfo FI = new FileInfo(FQN);
			string sDirName = "";
			string sFileName = "";
			try
			{
				sDirName = FI.DirectoryName;
				sFileName = FI.Name;
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message));
				return B;
			}
			
			int iArchiveFlag = 0;
			int FileExist = 1;
			int NeedsArchive = 1;
			int UseArchiveBit = 0;
			int DirID = 0;
			int FileID = 0;
			
			DirID = GetDirID(sDirName);
			FileID = GetFileID(sFileName, FileHash);
			
			if (DirID < 0)
			{
				B = false;
				LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 01 - Could not get the directory id for " + sDirName + ".");
				return B;
			}
			if (FileID < 0)
			{
				B = false;
				LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 02 - Could not get the file id for " + sFileName + ".");
				return B;
			}
			
			if (ArchiveFlag)
			{
				iArchiveFlag = 1;
			}
			else
			{
				iArchiveFlag = 0;
			}
			
			string S = (string) ("Update Inventory set NeedsArchive = " + iArchiveFlag.ToString());
			S += (string) (" where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString());
			
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.Parameters.AddWithValue("@DirID", DirID);
				cmd.Parameters.AddWithValue("@FileID", FileID);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setInventoryArchive 04 - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool setInventoryArchive(int DirID, int FileID, bool ArchiveFlag)
		{
			
			bool B = true;
			
			int iArchiveFlag = 0;
			int FileExist = 1;
			int NeedsArchive = 1;
			int UseArchiveBit = 0;
			
			if (ArchiveFlag)
			{
				iArchiveFlag = 1;
			}
			else
			{
				iArchiveFlag = 0;
			}
			
			string S = (string) ("Update Inventory set NeedsArchive = " + iArchiveFlag.ToString());
			S += (string) (" where DirID = " + DirID.ToString() + " and FileId = " + FileID.ToString());
			
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.Parameters.AddWithValue("@DirID", DirID);
				cmd.Parameters.AddWithValue("@FileID", FileID);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setInventoryArchive 104 - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool ckNeedsArchive(string FQN, bool SkipIfArchiveBitOn, ref string FileHash)
		{
			
			int iArchiveFlag = 0;
			int FileExist = 1;
			int NeedsArchive = 1;
			int UseArchiveBit = 0;
			int DirID = 0;
			int FileID = 0;
			int FileSize = 0;
			bool B = true;
			string sDirName = "";
			string sFileName = "";
			DateTime LastUpdate = null;
			int ArchiveBit = 1;
			
			if (FileHash.Length == 0)
			{
				FileHash = ENC.getSha1HashFromFile(FQN);
			}
			
			
			System.IO.FileAttributes fileAttributes = new System.IO.FileInfo(FQN).Attributes();
			bool ArchBit = fileAttributes && System.IO.FileAttributes.Archive;
			
			fileAttributes = null;
			
			if (! ArchBit && SkipIfArchiveBitOn)
			{
				return false;
			}
			
			FileInfo FI = new FileInfo(FQN);
			
			try
			{
				sDirName = FI.DirectoryName;
				sFileName = FI.Name;
				FileSize = FI.Length;
				LastUpdate = FI.LastWriteTime;
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message));
				return B;
			}
			
			DirID = GetDirID(sDirName);
			FileID = GetFileID(sFileName, FileHash);
			
			if (DirID < 0)
			{
				B = addDir(sDirName, false);
				LOG.WriteToArchiveLog("Notice: clsDbLocal/setInventoryArchive 01 - Added directory " + sDirName + ".");
				DirID = GetDirID(sDirName);
			}
			if (FileID < 0)
			{
				B = addFile(sFileName, FileHash);
				LOG.WriteToArchiveLog("Notice: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".");
				FileID = GetFileID(sFileName, FileHash);
			}
			
			bool bNeedsArchive = true;
			bool NeedsToBeArchived = true;
			bool FileExistsInInventory = true;
			
			FileExistsInInventory = InventoryExists(DirID, FileID, FileHash);
			
			if (! FileExistsInInventory)
			{
				addInventory(DirID, FileID, FileSize, LastUpdate, System.Convert.ToBoolean(ArchiveBit), FileHash);
				NeedsToBeArchived = true;
				return NeedsToBeArchived;
			}
			
			string S = (string) ("Select FileSize, LastUpdate, NeedsArchive from Inventory where DirID = " + DirID.ToString() + " and FileID = " + FileID.ToString());
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			
			int iCnt = 0;
			
			int prevFileSize = 0;
			DateTime prevLastUpdate = null;
			bool prevNeedsArchive = false;
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					prevFileSize = rs.GetInt64(0);
					prevLastUpdate = rs.GetDateTime(1);
					prevNeedsArchive = rs.GetBoolean(2);
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (prevFileSize != FileSize)
				{
					B = true;
				}
				else if (! prevLastUpdate.ToString().Equals(LastUpdate.ToString()))
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/InventoryExists - " + ex.Message + "\r\n" + S));
				FileID = -1;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public void truncateDirs()
		{
			
			string S = "delete from Directory";
			
			//Dim cn As New SqlCeConnection(DirCS)
			if (ConnDir.State == ConnectionState.Closed)
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnDir);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateDirs 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
		}
		public void truncateContacts()
		{
			string S = "delete from ContactsArchive";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ContactCS;
				ConnExchange.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnContact);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		public void truncateExchange()
		{
			string S = "delete from Exchange";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateExchange 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		public void truncateOutlook()
		{
			string S = "delete from Outlook";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateOutlook 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		public void truncateFiles()
		{
			string S = "delete from Files";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnFile.State == ConnectionState.Closed)
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnFile);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateFiles 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void truncateInventory()
		{
			string S = "delete from Inventory";
			
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = FileCS;
				ConnInv.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnInv);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/truncateInventory 104 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void BackupDirTbl()
		{
			
			string Dirname = null;
			int DirID = System.Convert.ToInt32(null);
			bool UseArchiveBit = System.Convert.ToBoolean(null);
			
			SqlCeConnection TempConn = new SqlCeConnection();
			TempConn.ConnectionString = DirCS;
			TempConn.Open();
			
			string S = "Select Dirname,DirID,UseArchiveBit from Directory";
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Directory.dat";
			
			if (! Directory.Exists(SavePath))
			{
				Directory.CreateDirectory(SavePath);
			}
			
			StreamWriter fOut = new StreamWriter(SaveFQN, false);
			string msg = "";
			
			try
			{
				
				SqlCeCommand cmd = new SqlCeCommand(S, TempConn);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						Dirname = rs.GetString(0);
						DirID = rs.GetSqlInt32(1);
						UseArchiveBit = rs.GetBoolean(2);
						
						fOut.WriteLine(Dirname + "|" + DirID.ToString() + "|" + UseArchiveBit.ToString());
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				fOut.Close();
				fOut.Dispose();
				if (TempConn != null)
				{
					if (TempConn.State == ConnectionState.Open)
					{
						TempConn.Close();
					}
					TempConn.Dispose();
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void RestorepDirTbl()
		{
			
			string Dirname = null;
			int DirID = System.Convert.ToInt32(null);
			bool UseArchiveBit = System.Convert.ToBoolean(null);
			
			if (ConnDir.State == ConnectionState.Closed)
			{
				ConnDir.ConnectionString = DirCS;
				ConnDir.Open();
			}
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Directory.dat";
			
			if (! Directory.Exists(SavePath))
			{
				LOG.WriteToArchiveLog("NOTICE:RestorepDirTbl Restore directory " + SaveFQN + " does not exist, returning.");
				return;
			}
			
			StreamReader fOut = new StreamReader(SaveFQN);
			string inStr = "";
			string[] A = null;
			
			SqlCeCommand cmd = new SqlCeCommand();
			cmd.CommandText = "SET IDENTITY_INSERT Directory ON";
			cmd.ExecuteNonQuery();
			
			cmd.CommandText = "delete form Directory";
			cmd.ExecuteNonQuery();
			
			try
			{
				
				cmd.Connection = ConnDir;
				cmd.CommandType = CommandType.Text;
				
				while (inStr == fOut.ReadLine())
				{
					A = inStr.Split("|".ToCharArray());
					Dirname = A[0];
					DirID = int.Parse(A[1]);
					UseArchiveBit = bool.Parse(A[2]);
					
					try
					{
						cmd.CommandText = "Insert into Directory (DirName, DirID, UseArchiveBit) values (@DirName, @DirID, @UseArchiveBit)";
						cmd.Parameters.AddWithValue("@DirName", Dirname);
						cmd.Parameters.AddWithValue("@DirID", DirID);
						cmd.Parameters.AddWithValue("@UseArchiveBit", UseArchiveBit);
						cmd.ExecuteNonQuery();
					}
					catch (Exception)
					{
						LOG.WriteToArchiveLog((string) ("ERROR:RestorepDirTbl Failed insert: " + inStr));
					}
				}
				
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/RestorepDirTbl - " + ex.Message));
			}
			finally
			{
				cmd.CommandText = "SET IDENTITY_INSERT Directory OFF";
				cmd.ExecuteNonQuery();
				cmd.Dispose();
				fOut.Close();
				fOut.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void BackupFileTbl()
		{
			
			string Filename = null;
			int FileID = System.Convert.ToInt32(null);
			
			string S = "Select Filename,FileID from Files";
			
			SqlCeConnection TempConn = new SqlCeConnection();
			TempConn.ConnectionString = FileCS;
			TempConn.Open();
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Files.dat";
			
			if (! Directory.Exists(SavePath))
			{
				Directory.CreateDirectory(SavePath);
			}
			
			StreamWriter fOut = new StreamWriter(SaveFQN, false);
			string msg = "";
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, TempConn);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						Filename = rs.GetString(0);
						FileID = rs.GetSqlInt32(1);
						fOut.WriteLine(Filename + "|" + FileID.ToString());
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupFileTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				fOut.Close();
				fOut.Dispose();
				if (TempConn != null)
				{
					if (TempConn.State == ConnectionState.Open)
					{
						TempConn.Close();
					}
					TempConn.Dispose();
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void RestorepFileTbl()
		{
			
			string Filename = null;
			int FileID = System.Convert.ToInt32(null);
			
			if (ConnFile.State == ConnectionState.Closed)
			{
				ConnFile.ConnectionString = FileCS;
				ConnFile.Open();
			}
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\File.dat";
			
			if (! Directory.Exists(SavePath))
			{
				LOG.WriteToArchiveLog("NOTICE:RestorepFileTbl Restore file " + SaveFQN + " does not exist, returning.");
				return;
			}
			
			StreamReader fOut = new StreamReader(SaveFQN);
			string inStr = "";
			string[] A = null;
			
			SqlCeCommand cmd = new SqlCeCommand();
			cmd.CommandText = "SET IDENTITY_INSERT Files ON";
			cmd.ExecuteNonQuery();
			
			cmd.CommandText = "delete from Files";
			cmd.ExecuteNonQuery();
			
			try
			{
				
				cmd.Connection = ConnFile;
				cmd.CommandType = CommandType.Text;
				
				while (inStr == fOut.ReadLine())
				{
					A = inStr.Split("|".ToCharArray());
					Filename = A[0];
					FileID = int.Parse(A[1]);
					
					try
					{
						cmd.CommandText = "Insert into Files (FileName, FileID) values (@FileName, @FileID)";
						cmd.Parameters.AddWithValue("@Filename", Filename);
						cmd.Parameters.AddWithValue("@FileID", FileID);
						cmd.ExecuteNonQuery();
					}
					catch (Exception)
					{
						LOG.WriteToArchiveLog((string) ("ERROR:RestorepFileTbl Failed insert: " + inStr));
					}
				}
				
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/RestorepFileTbl - " + ex.Message));
			}
			finally
			{
				cmd.CommandText = "SET IDENTITY_INSERT Files OFF";
				cmd.ExecuteNonQuery();
				cmd.Dispose();
				
				fOut.Close();
				fOut.Dispose();
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void BackupInventoryTbl()
		{
			
			int DirID = System.Convert.ToInt32(null);
			int FileID = System.Convert.ToInt32(null);
			int InvID = System.Convert.ToInt32(null);
			bool FileExist = System.Convert.ToBoolean(null);
			long Filesize = null;
			DateTime LastUpdate = null;
			bool ArchiveBit = System.Convert.ToBoolean(null);
			bool NeedsArchive = System.Convert.ToBoolean(null);
			string FileHash = null;
			
			string S = "Select DirID,FileID,InvID,FileExist,Filesize,LastUpdate,ArchiveBit,NeedsArchive,FileHash from Inventory";
			
			SqlCeConnection TempConn = new SqlCeConnection();
			TempConn.ConnectionString = InvCS;
			TempConn.Open();
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Inventory.dat";
			
			if (! Directory.Exists(SavePath))
			{
				Directory.CreateDirectory(SavePath);
			}
			
			StreamWriter fOut = new StreamWriter(SaveFQN, false);
			string msg = "";
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, TempConn);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						DirID = rs.GetSqlInt32(0);
						FileID = rs.GetSqlInt32(1);
						InvID = rs.GetSqlInt32(2);
						FileExist = rs.GetBoolean(3);
						Filesize = rs.GetInt64(4);
						LastUpdate = rs.GetDateTime(5);
						ArchiveBit = rs.GetBoolean(6);
						NeedsArchive = rs.GetBoolean(7);
						FileHash = rs.GetString(8);
						
						fOut.WriteLine(DirID.ToString() + "|" + FileID.ToString() + "|" + InvID.ToString() + "|" + FileExist.ToString() + "|" + LastUpdate.ToString() + "|" + ArchiveBit.ToString() + "|" + NeedsArchive.ToString() + "|" + FileHash.ToString());
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupFileTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				fOut.Close();
				fOut.Dispose();
				if (TempConn != null)
				{
					if (TempConn.State == ConnectionState.Open)
					{
						TempConn.Close();
					}
					TempConn.Dispose();
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		public void RestorepInventoryTbl()
		{
			
			//SET IDENTITY_INSERT dbo.Tool ON
			
			int DirID = System.Convert.ToInt32(null);
			int FileID = System.Convert.ToInt32(null);
			int InvID = System.Convert.ToInt32(null);
			bool FileExist = System.Convert.ToBoolean(null);
			long FileSize = null;
			DateTime LastUpdate = null;
			bool ArchiveBit = System.Convert.ToBoolean(null);
			bool NeedsArchive = System.Convert.ToBoolean(null);
			string FileHash = null;
			
			
			if (ConnInv.State == ConnectionState.Closed)
			{
				ConnInv.ConnectionString = InvCS;
				ConnInv.Open();
			}
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Inventory.dat";
			
			if (! Directory.Exists(SavePath))
			{
				LOG.WriteToArchiveLog("NOTICE:RestorepInventoryTbl Restore file " + SaveFQN + " does not exist, returning.");
				return;
			}
			
			StreamReader fOut = new StreamReader(SaveFQN);
			string inStr = "";
			string[] A = null;
			SqlCeCommand cmd = new SqlCeCommand();
			
			try
			{
				
				cmd.Connection = ConnInv;
				cmd.CommandType = CommandType.Text;
				
				cmd.CommandText = "SET IDENTITY_INSERT Inventory ON";
				cmd.ExecuteNonQuery();
				
				cmd.CommandText = "delete from Inventory";
				cmd.ExecuteNonQuery();
				
				while (inStr == fOut.ReadLine())
				{
					A = inStr.Split("|".ToCharArray());
					
					DirID = int.Parse(A[0]);
					FileID = int.Parse(A[1]);
					InvID = int.Parse(A[2]);
					FileExist = bool.Parse(A[3]);
					FileSize = int.Parse(A[4]);
					LastUpdate = DateTime.Parse(A[5]);
					ArchiveBit = bool.Parse(A[6]);
					NeedsArchive = bool.Parse(A[7]);
					FileHash = A[0];
					
					try
					{
						cmd.CommandText = "Insert into Files (FileName, FileID) values (@FileName, @FileID)";
						cmd.Parameters.AddWithValue("@DirID", DirID);
						cmd.Parameters.AddWithValue("@FileID", FileID);
						cmd.Parameters.AddWithValue("@InvID", InvID);
						cmd.Parameters.AddWithValue("@FileExist", FileExist);
						cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
						cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
						cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
						cmd.Parameters.AddWithValue("@FileHash", FileHash);
						cmd.ExecuteNonQuery();
					}
					catch (Exception)
					{
						LOG.WriteToArchiveLog((string) ("ERROR:RestorepInventoryTbl Failed insert: " + inStr));
					}
				}
				
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/RestorepInventoryTbl - " + ex.Message));
			}
			finally
			{
				cmd.CommandText = "SET IDENTITY_INSERT Inventory OFF";
				cmd.ExecuteNonQuery();
				cmd.Dispose();
				fOut.Close();
				fOut.Dispose();
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void BackupOutlookTbl()
		{
			
			string sKey = null;
			int RowID = System.Convert.ToInt32(null);
			
			string S = "Select sKey,RowID from Outlook";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Outlook.dat";
			
			if (! Directory.Exists(SavePath))
			{
				Directory.CreateDirectory(SavePath);
			}
			
			StreamWriter fOut = new StreamWriter(SaveFQN, false);
			string msg = "";
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						sKey = rs.GetString(0);
						RowID = rs.GetSqlInt32(1);
						fOut.WriteLine(sKey + "|" + RowID.ToString());
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				fOut.Close();
				fOut.Dispose();
				if (ConnOutlook != null)
				{
					if (ConnOutlook.State == ConnectionState.Open)
					{
						ConnOutlook.Close();
					}
					ConnOutlook.Dispose();
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void BackupExchangeTbl()
		{
			
			string sKey = null;
			int RowID = System.Convert.ToInt32(null);
			
			string S = "Select sKey,RowID from Exchange";
			
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = OutlookCS;
				ConnExchange.Open();
			}
			
			string tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			string SavePath = tPath + "\\ECM\\QuickRefData";
			string SaveFQN = SavePath + "\\Exchange.dat";
			
			if (! Directory.Exists(SavePath))
			{
				Directory.CreateDirectory(SavePath);
			}
			
			StreamWriter fOut = new StreamWriter(SaveFQN, false);
			string msg = "";
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						sKey = rs.GetString(0);
						RowID = rs.GetSqlInt32(1);
						fOut.WriteLine(sKey + "|" + RowID.ToString());
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				fOut.Close();
				fOut.Dispose();
				if (ConnExchange != null)
				{
					if (ConnExchange.State == ConnectionState.Open)
					{
						ConnExchange.Close();
					}
					ConnExchange.Dispose();
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public bool addOutlook(string sKey)
		{
			
			bool B = false;
			int UseArchiveBit = 0;
			
			B = OutlookExists(sKey);
			if (B)
			{
				return true;
			}
			
			string S = "Insert into Outlook (sKey) values (@sKey) ";
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addOutlook - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		
		public bool addExchange(string sKey)
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			
			string S = "Insert into Exchange (sKey) values (@sKey) ";
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addExchange - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		public bool OutlookExists(string sKey)
		{
			
			bool B = false;
			string S = "Select count(*) from Outlook where sKey = \'" + sKey + "\'";
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			
			int iCnt = 0;
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					iCnt = rs.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/OutlookExists - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		public bool ExchangeExists(string sKey)
		{
			
			bool B = false;
			string S = "Select count(*) from Exchange where sKey = \'" + sKey + "\'";
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			
			int iCnt = 0;
			try
			{
				
				SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					iCnt = rs.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/OutlookExists - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool MarkExchangeFound(string sKey)
		{
			
			bool B = true;
			string S = "Update exchange set KeyExists = @B where sKey = @sKey ";
			
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.Parameters.AddWithValue("@B", true);
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/MarkExchangeFound - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool MarkOutlookFound(string sKey)
		{
			
			bool B = true;
			string S = "Update Outlook set KeyExists = @B where sKey = @sKey ";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.Parameters.AddWithValue("@B", true);
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/MarkOutlookFound - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool delOutlook(string sKey)
		{
			
			bool B = true;
			string S = "Delete from Outlook where sKey = @sKey ";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delOutlook - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool delExchange(string sKey)
		{
			
			bool B = true;
			string S = "Delete from Exchange where sKey = @sKey ";
			
			//Dim cn As New SqlCeConnection(FileCS)
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delExchange - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool delOutlookMissing(string sKey)
		{
			
			bool B = true;
			string S = "Delete from Outlook where not keyExists  ";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delOutlookMissing - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool delExchangeMissing(string sKey)
		{
			
			bool B = true;
			string S = "Delete from Exchange where not keyExists  ";
			
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/delExchangeMissing - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setOutlookMissing()
		{
			
			bool B = true;
			string S = "Update Outlook set keyExists = 0 ";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setOutlookMissing - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setExchangeMissing(string sKey)
		{
			
			bool B = true;
			string S = "Update Exchange set KeyExists = false ";
			
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setExchangeMissing - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setOutlookKeyFound(string sKey)
		{
			
			bool B = true;
			string S = "Udpate Outlook set keyExists = true where sKey = @sKey  ";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setOutlookKeyFound - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setExchangeKeyFound(string sKey)
		{
			
			bool B = true;
			string S = "Udpate Exchange set keyExists = true where sKey = @sKey  ";
			
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			try
			{
				cmd.Parameters.AddWithValue("@sKey", sKey);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setExchangeKeyFound - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public void LoadExchangeKeys(SortedList<string, string> L)
		{
			
			string S = "Select sKey from Exchange";
			if (ConnExchange.State == ConnectionState.Closed)
			{
				ConnExchange.ConnectionString = ExchangeCS;
				ConnExchange.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnExchange);
			string sKey = "";
			
			try
			{
				
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				int iKey = 0;
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						sKey = rs.GetString(0);
						if (L.IndexOfKey(sKey) < 0)
						{
							try
							{
								L.Add(sKey, iKey.ToString());
							}
							catch (System.Exception ex2)
							{
								Console.WriteLine(ex2.Message);
							}
						}
						iKey++;
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public bool addListener(string FQN)
		{
			bool B = true;
			string S = "Insert into Listener (FQN) values (@FQN) ";
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
			try
			{
				cmd.Parameters.AddWithValue("@FQN", FQN);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addListener - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		
		public bool DelListenersProcessed()
		{
			bool B = true;
			string S = "delete from Listener where Uploaded = 1";
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
			try
			{
				//cmd.Parameters.AddWithValue("@FQN", FQN)
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addListener - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		
		public bool MarkListenersProcessed(string FQN)
		{
			bool B = true;
			string S = "Update Listener set Uploaded = 1 where FQN = @FQN";
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
			try
			{
				cmd.Parameters.AddWithValue("@FQN", FQN);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addListener - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		public bool removeListenerFile(string FQN)
		{
			bool B = true;
			string S = "Delete from Listener where FQN = @FQN";
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
			try
			{
				cmd.Parameters.AddWithValue("@FQN", FQN);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addListener - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
		}
		public void getListenerFiles(SortedList<string, int> L)
		{
			
			string FQN = null;
			SqlCeConnection ConnListener = new SqlCeConnection();
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			string S = "Select FQN from Listener";
			
			try
			{
				
				SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						FQN = rs.GetString(0);
						if (L.ContainsKey(FQN))
						{
						}
						else
						{
							L.Add(FQN, L.Count);
						}
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/getListenerFiles - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				//If ConnListener IsNot Nothing Then
				//    If ConnListener.State = ConnectionState.Open Then
				//        ConnListener.Close()
				//    End If
				//    ConnListener.Dispose()
				//End If
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		public bool ActiveListenerFiles()
		{
			
			bool B = false;
			string S = "Select count(*) from Listener ";
			//Dim cn As New SqlCeConnection(InvCS)
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ListenerCS;
				ConnListener.Open();
			}
			
			int iCnt = 0;
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnListener);
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					rs.Read();
					iCnt = rs.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/ActiveListenerFiles - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				//If cn IsNot Nothing Then
				//    If cn.State = ConnectionState.Open Then
				//        cn.Close()
				//    End If
				//    cn.Dispose()
				//End If
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool addZipFile(string FileName, string ParentGuid, bool bThisIsAnEmail)
		{
			
			int EmailAttachment = 0;
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			if (bThisIsAnEmail)
			{
				EmailAttachment = 1;
			}
			
			FileInfo FI = new FileInfo(FileName);
			fSize = FI.Length;
			FI = null;
			
			string S = "";
			S = S + "Insert into ZipFile (FQN, fSize, EmailAttachment) values (@FileName, @fSize, @EmailAttachment) ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.Parameters.AddWithValue("@FileName", FileName);
				cmd.Parameters.AddWithValue("@fSize", fSize);
				cmd.Parameters.AddWithValue("@ParentGuid", ParentGuid);
				cmd.Parameters.AddWithValue("@EmailAttachment", EmailAttachment);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				if (ex.Message.IndexOf("duplicate value cannot") + 1 > 0)
				{
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/addFile - " + ex.Message + "\r\n" + S));
				}
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool setZipFileProcessed(string FileName)
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			FileInfo FI = new FileInfo(FileName);
			fSize = FI.Length;
			FI = null;
			
			string S = "Update ZipFile set SuccessfullyProcessed = 1 where FQN = @FileName) ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.Parameters.AddWithValue("@FileName", FileName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setZipFileProcessed - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setZipNbrOfFiles(string FileName, int NumberOfZipFiles)
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			string S = "Update ZipFile set NumberOfZipFiles = " + NumberOfZipFiles.ToString() + " where FQN = @FileName) ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.Parameters.AddWithValue("@FileName", FileName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool setZipInWork(string FileName, int NumberOfZipFiles)
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			string S = "Update ZipFile set InWork = 1 where FQN = @FileName) ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.Parameters.AddWithValue("@FileName", FileName);
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setZipInWork - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public bool cleanZipFiles()
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			
			string S = "delete from ZipFile where SuccessfullyProcessed = 1 ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		
		public bool zeroizeZipFiles()
		{
			
			bool B = true;
			int UseArchiveBit = 0;
			double fSize = 0;
			
			
			string S = "delete from ZipFile ";
			
			if (ConnZip.State == ConnectionState.Closed)
			{
				ConnZip.ConnectionString = ZipCS;
				ConnZip.Open();
			}
			
			SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
			try
			{
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + "\r\n" + S));
				B = false;
			}
			finally
			{
				cmd.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			return B;
			
		}
		public void getZipFiles(SortedList<string, int> L)
		{
			
			string FQN = null;
			SqlCeConnection ConnListener = new SqlCeConnection();
			if (ConnListener.State == ConnectionState.Closed)
			{
				ConnListener.ConnectionString = ZipCS;
				ConnListener.Open();
			}
			
			string S = "Select FQN from ZipFile where InWork = 0";
			
			try
			{
				
				SqlCeCommand cmd = new SqlCeCommand(S, ConnZip);
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						FQN = rs.GetString(0);
						if (L.ContainsKey(FQN))
						{
						}
						else
						{
							L.Add(FQN, L.Count);
						}
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/getZipFiles - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				//If ConnListener IsNot Nothing Then
				//    If ConnListener.State = ConnectionState.Open Then
				//        ConnListener.Close()
				//    End If
				//    ConnListener.Dispose()
				//End If
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void getCE_EmailIdentifiers(SortedList L)
		{
			
			string sKey = null;
			int RowID = System.Convert.ToInt32(null);
			
			string S = "Select sKey,RowID from Outlook";
			
			if (ConnOutlook.State == ConnectionState.Closed)
			{
				ConnOutlook.ConnectionString = OutlookCS;
				ConnOutlook.Open();
			}
			
			try
			{
				SqlCeCommand cmd = new SqlCeCommand(S, ConnOutlook);
				cmd.CommandType = CommandType.Text;
				
				//** if you don’t set the result set to scrollable HasRows does not work
				SqlCeResultSet rs = cmd.ExecuteResultSet(ResultSetOptions.Scrollable);
				
				if (rs.HasRows)
				{
					while (rs.Read())
					{
						sKey = rs.GetString(0);
						RowID = rs.GetSqlInt32(1);
						try
						{
							if (! L.ContainsKey(sKey))
							{
								L.Add(sKey, RowID);
							}
						}
						catch (Exception ex)
						{
							Console.WriteLine(ex.Message);
						}
					}
				}
				
				if (! rs.IsClosed)
				{
					rs.Close();
				}
				rs.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				if (ConnOutlook != null)
				{
					if (ConnOutlook.State == ConnectionState.Open)
					{
						ConnOutlook.Close();
					}
				}
			}
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
	}
	
}

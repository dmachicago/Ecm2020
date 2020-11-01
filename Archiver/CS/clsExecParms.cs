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
using Microsoft.VisualBasic.CompilerServices;



/// <summary>
/// This class is used to load and store the application
/// execution parameters.
/// </summary>
/// <remarks></remarks>
namespace EcmArchiveClcSetup
{
	public class clsExecParms
	{
		public clsExecParms()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			fName = DMA.getEnvVarTempDir() + "/ExecParms.txt";
			
		}
		
		
		public string EmailFolderName = "";
		public string ArchiveEmails = "";
		public string RemoveAfterArchive = "";
		public string SetAsDefaultFolder = "";
		public string ArchiveAfterXDays = "";
		public string ArchiveXDays = "";
		public string RemoveAfterXDays = "";
		public string RemoveXDays = "";
		public string UseDefaultDB = "";
		public string DBID = "";
		
		
		public string FolderName = "";
		public string Exts = "";
		public string UseDefaultDBfile = "";
		public string DBIDFile = "";
		public string IncludeFileType = "";
		public string ExcludeFileType = "";
		
		
		public string FileFolderName = "";
		public string CurrUser = "";
		
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		string fName; // VBConversions Note: Initial value of "DMA.getEnvVarTempDir() + "/ExecParms.txt"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		
		public void LoadEmailFolders(ListBox LB)
		{
			try
			{
				LB.Items.Clear();
				string[] LinesToKeep = new string[1];
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("Folder"))
					{
						string tName = A[1];
						LB.Items.Add(S);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.2 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : LoadEmailFolders : 14 : " + ex.Message));
			}
		}
		public void LoadFileFolders(ListBox LB)
		{
			try
			{
				LB.Items.Clear();
				string[] LinesToKeep = new string[1];
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("File"))
					{
						string tName = A[1];
						LB.Items.Add(S);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.2 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : LoadFileFolders : 28 : " + ex.Message));
			}
		}
		public void getEmailFolderAttr(string FolderName, string[] Parms)
		{
			try
			{
				string[] LinesToKeep = new string[1];
				string[] A = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					A = S.Split("|".ToCharArray());
					if (A[0].Equals("Folder"))
					{
						string tName = A[1];
						if (tName.ToUpper().Equals(FolderName.ToUpper()))
						{
							ArchiveEmails = A[2];
							RemoveAfterArchive = A[3];
							SetAsDefaultFolder = A[4];
							ArchiveAfterXDays = A[5];
							ArchiveXDays = A[6];
							RemoveAfterXDays = A[7];
							RemoveXDays = A[8];
							UseDefaultDB = A[9];
							DBID = A[10];
							FolderFound = true;
							break;
						}
					}
				}
				if (FolderFound)
				{
					Parms = new string[(A.Length - 1) + 1];
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						Parms[i] = A[i];
					}
				}
				else
				{
					Parms = new string[1];
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : getEmailFolderAttr : 62 : " + ex.Message));
			}
		}
		public void getFileFolderAttr(string FolderName, string[] Parms)
		{
			try
			{
				string[] LinesToKeep = new string[1];
				string[] A = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					A = S.Split("|".ToCharArray());
					if (A[0].Equals("File"))
					{
						string FileDir = A[1];
						if (FileDir.ToUpper().Equals(FolderName.ToUpper()))
						{
							string FileExts = A[2];
							string SetAsDefault = A[3];
							string DBID = A[4];
							FolderFound = true;
							break;
						}
					}
				}
				if (FolderFound)
				{
					Parms = new string[(A.Length - 1) + 1];
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						Parms[i] = A[i];
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : getFileFolderAttr : 88 : " + ex.Message));
			}
		}
		public void deleteEmailFolder(string FolderName)
		{
			try
			{
				string[] LinesToKeep = new string[1];
				
				
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("Folder"))
					{
						string tName = A[1];
						if (tName.ToUpper().Equals(FolderName.ToUpper()))
						{
							//** Do nothing, this is the one to skip
							//** DO not break out fo the loop, we need the rest of the file.
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
				}
				SR.Close();
				WriteArrayToParmFile(LinesToKeep);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : deleteEmailFolder : 105 : " + ex.Message));
			}
		}
		public void addEmailFolder(string FolderName)
		{
			try
			{
				string ParmStr = "";
				ParmStr = "Folder" + "|" + FolderName + "|";
				ParmStr = ParmStr + ArchiveEmails + "|";
				ParmStr = ParmStr + RemoveAfterArchive + "|";
				ParmStr = ParmStr + SetAsDefaultFolder + "|";
				ParmStr = ParmStr + ArchiveAfterXDays + "|";
				ParmStr = ParmStr + ArchiveXDays + "|";
				ParmStr = ParmStr + RemoveAfterXDays + "|";
				ParmStr = ParmStr + RemoveXDays + "|";
				ParmStr = ParmStr + UseDefaultDB + "|";
				ParmStr = ParmStr + DBID;
				
				
				if (! System.IO.File.Exists(fName))
				{
					this.AppendToParmFile(ParmStr);
					return;
				}
				
				
				string[] LinesToKeep = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("Folder"))
					{
						B = true;
						string tName = A[1];
						if (tName.ToUpper().Equals(FolderName.ToUpper()))
						{
							FolderFound = true;
							AddLine(ref LinesToKeep, ParmStr);
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
					if (! B)
					{
						AddLine(ref LinesToKeep, S);
					}
					
					
				}
				SR.Close();
				if (FolderFound == false)
				{
					if ((LinesToKeep.Length - 1) > 0)
					{
						WriteArrayToParmFile(LinesToKeep);
					}
					this.AppendToParmFile(ParmStr);
				}
				
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : addEmailFolder : 149 : " + ex.Message));
			}
		}
		public void setRunAtStart(string RunAtStart)
		{
			try
			{
				string ParmStr = "";
				ParmStr = "Run@Start" + "|";
				ParmStr = ParmStr + RunAtStart;
				
				
				string[] LinesToKeep = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("Run@Start"))
					{
						AddLine(ref LinesToKeep, ParmStr);
					}
				}
				SR.Close();
				if (FolderFound == false)
				{
					WriteArrayToParmFile(LinesToKeep);
				}
				else
				{
					ParmStr = "Run@Start" + "|N";
					this.AppendToParmFile(ParmStr);
					WriteArrayToParmFile(LinesToKeep);
				}
				
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.11 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : setRunAtStart : 172 : " + ex.Message));
			}
		}
		public void addFileFolder(string FolderName, string Exts, string UseDefaultDB, string DBID)
		{
			try
			{
				string ParmStr = "";
				ParmStr = "File" + "|";
				ParmStr = ParmStr + FolderName + "|";
				ParmStr = ParmStr + Exts + "|";
				ParmStr = ParmStr + UseDefaultDB + "|";
				ParmStr = ParmStr + DBID;
				
				
				if (! System.IO.File.Exists(fName))
				{
					this.AppendToParmFile(ParmStr);
					return;
				}
				
				
				string[] LinesToKeep = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("File"))
					{
						B = true;
						string tName = A[1];
						if (tName.ToUpper().Equals(FolderName.ToUpper()))
						{
							FolderFound = true;
							AddLine(ref LinesToKeep, ParmStr);
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
					if (B == false)
					{
						AddLine(ref LinesToKeep, S);
					}
				}
				SR.Close();
				if (FolderFound == false)
				{
					if ((LinesToKeep.Length - 1) > 0)
					{
						WriteArrayToParmFile(LinesToKeep);
					}
					this.AppendToParmFile(ParmStr);
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : addFileFolder : 211 : " + ex.Message));
			}
		}
		public void addDbConnStr(string DBName, string Connstr)
		{
			try
			{
				string ParmStr = "";
				ParmStr = "DB" + "|";
				ParmStr = ParmStr + DBName + "|";
				ParmStr = ParmStr + Connstr;
				
				
				if (! System.IO.File.Exists(fName))
				{
					this.AppendToParmFile(ParmStr);
					return;
				}
				
				
				string[] LinesToKeep = new string[1];
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("DB"))
					{
						B = true;
						string tName = A[1];
						if (tName.ToUpper().Equals(DBName.ToUpper()))
						{
							AddLine(ref LinesToKeep, ParmStr);
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
					if (B == false)
					{
						AddLine(ref LinesToKeep, S);
					}
				}
				SR.Close();
				if (DbFound == false)
				{
					if ((LinesToKeep.Length - 1) > 0)
					{
						WriteArrayToParmFile(LinesToKeep);
					}
					this.AppendToParmFile(ParmStr);
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : addDbConnStr : 248 : " + ex.Message));
			}
			finally
			{
				
				
				
			}
		}
		public void addFileExt(string FileExt)
		{
			try
			{
				string ParmStr = "";
				ParmStr = (string) ("EXT" + "|" + FileExt);
				
				
				if (! System.IO.File.Exists(fName))
				{
					this.AppendToParmFile(ParmStr);
					return;
				}
				
				
				string[] LinesToKeep = new string[1];
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("EXT"))
					{
						B = true;
						string tName = A[1];
						if (tName.ToUpper().Equals(FileExt.ToUpper()))
						{
							AddLine(ref LinesToKeep, ParmStr);
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
					if (B == false)
					{
						AddLine(ref LinesToKeep, S);
					}
				}
				SR.Close();
				if (DbFound == false)
				{
					if ((LinesToKeep.Length - 1) > 0)
					{
						WriteArrayToParmFile(LinesToKeep);
					}
					this.AppendToParmFile(ParmStr);
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : addFileExt : 283 : " + ex.Message));
			}
			finally
			{
				
				
			}
		}
		public void LoadDatabases(ComboBox LB)
		{
			try
			{
				LB.Items.Clear();
				
				
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("DB"))
					{
						string tName = A[1];
						LB.Items.Add(tName);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.25.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : LoadDatabases : 299 : " + ex.Message));
			}
			finally
			{
				
				
			}
		}
		public void LoadFileExt(ComboBox LB)
		{
			try
			{
				LB.Items.Clear();
				
				
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("EXT"))
					{
						string tName = A[1];
						LB.Items.Add(tName);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.25.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : LoadFileExt : 315 : " + ex.Message));
			}
			finally
			{
				
			}
		}
		public void LoadFileExt(ListBox LB)
		{
			try
			{
				LB.Items.Clear();
				
				
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					bool B = false;
					if (A[0].Equals("EXT"))
					{
						string tName = A[1];
						LB.Items.Add(tName);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.25.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : LoadFileExt : 331 : " + ex.Message));
			}
			finally
			{
				
			}
		}
		public void getActiveEmailFolders(ListBox LB)
		{
			try
			{
				LB.Items.Clear();
				
				
				string[] LinesToKeep = new string[1];
				string[] A = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					A = S.Split("|".ToCharArray());
					if (A[0].Equals("Folder"))
					{
						string tName = A[1];
						LB.Items.Add(tName);
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : getActiveEmailFolders : 347 : " + ex.Message));
			}
		}
		public void deleteDbConnStr(string DBName, string Connstr)
		{
			try
			{
				string[] LinesToKeep = new string[1];
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("DB"))
					{
						string tName = A[1];
						if (tName.ToUpper().Equals(DBName.ToUpper()))
						{
							DbFound = true;
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
				}
				SR.Close();
				if (DbFound == false)
				{
					WriteArrayToParmFile(LinesToKeep);
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : deleteDbConnStr : 368 : " + ex.Message));
			}
		}
		public void deleteFileExt(string FileExt)
		{
			try
			{
				string[] LinesToKeep = new string[1];
				bool DbFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					string[] A = S.Split("|".ToCharArray());
					if (A[0].Equals("EXT"))
					{
						string tName = A[1];
						if (tName.ToUpper().Equals(FileExt.ToUpper()))
						{
							DbFound = true;
						}
						else
						{
							AddLine(ref LinesToKeep, S);
						}
					}
				}
				SR.Close();
				if (DbFound == false)
				{
					WriteArrayToParmFile(LinesToKeep);
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.1 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : deleteFileExt : 389 : " + ex.Message));
			}
		}
		public void getRunAtStart(CheckBox CK)
		{
			try
			{
				CK.Checked = false;
				string[] LinesToKeep = new string[1];
				string[] A = new string[1];
				bool FolderFound = false;
				System.IO.StreamReader SR = new System.IO.StreamReader(fName);
				while (! SR.EndOfStream)
				{
					string S = SR.ReadLine();
					A = S.Split("|".ToCharArray());
					if (A[0].Equals("Run@Start"))
					{
						var RunParm = A[1];
						if (RunParm.ToUpper().Equals("Y"))
						{
							CK.Checked = true;
							break;
						}
						else
						{
							CK.Checked = false;
							break;
						}
					}
				}
				SR.Close();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 123.23.10 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsExecParms : getRunAtStart : 409 : " + ex.Message));
			}
		}
		public void genInitialParmFIle()
		{
			
			
		}
		public void AddLine(ref string[] A, string S)
		{
			int I = 0;
			Array.Resize(ref A, (A.Length - 1) + 1 + 1);
			A[(A.Length - 1)] = S;
		}
		public void WriteArrayToParmFile(string[] a)
		{
			System.IO.StreamWriter SW = new System.IO.StreamWriter(fName);
			for (int i = 0; i <= (a.Length - 1); i++)
			{
				if (a[i] != null)
				{
					string S = a[i].Trim();
					if (S.Length > 0)
					{
						SW.WriteLine(S);
					}
				}
			}
			SW.Close();
		}
		public void DeleteParmFile()
		{
			Kill(fName);
		}
		public void AppendToParmFile(string S)
		{
			System.IO.StreamWriter SW = new System.IO.StreamWriter(fName, true);
			SW.WriteLine(S);
			SW.Close();
		}
	}
	
}

using System;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{


    /// <summary>
/// This class is used to load and store the application
/// execution parameters.
/// </summary>
/// <remarks></remarks>
    public class clsExecParms
    {
        public clsExecParms()
        {
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
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private string fName;

        public void LoadEmailFolders(ListBox LB)
        {
            try
            {
                LB.Items.Clear();
                var LinesToKeep = new string[1];
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
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
                MessageBox.Show("Error 123.23.2 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : LoadEmailFolders : 14 : " + ex.Message);
            }
        }

        public void LoadFileFolders(ListBox LB)
        {
            try
            {
                LB.Items.Clear();
                var LinesToKeep = new string[1];
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
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
                MessageBox.Show("Error 123.23.2 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : LoadFileFolders : 28 : " + ex.Message);
            }
        }

        public void getEmailFolderAttr(string FolderName, string[] Parms)
        {
            try
            {
                var LinesToKeep = new string[1];
                var A = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    A = S.Split('|');
                    if (A[0].Equals("Folder"))
                    {
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FolderName)))
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
                    Parms = new string[Information.UBound(A) + 1];
                    for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                        Parms[i] = A[i];
                }
                else
                {
                    Parms = new string[1];
                }

                SR.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : getEmailFolderAttr : 62 : " + ex.Message);
            }
        }

        public void getFileFolderAttr(string FolderName, string[] Parms)
        {
            try
            {
                var LinesToKeep = new string[1];
                var A = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    A = S.Split('|');
                    if (A[0].Equals("File"))
                    {
                        string FileDir = A[1];
                        if (Strings.UCase(FileDir).Equals(Strings.UCase(FolderName)))
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
                    Parms = new string[Information.UBound(A) + 1];
                    for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                        Parms[i] = A[i];
                }

                SR.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : getFileFolderAttr : 88 : " + ex.Message);
            }
        }

        public void deleteEmailFolder(string FolderName)
        {
            try
            {
                var LinesToKeep = new string[1];
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    if (A[0].Equals("Folder"))
                    {
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FolderName)))
                        {
                        }
                        // ** Do nothing, this is the one to skip
                        // ** DO not break out fo the loop, we need the rest of the file.
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
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : deleteEmailFolder : 105 : " + ex.Message);
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
                if (!File.Exists(fName))
                {
                    AppendToParmFile(ParmStr);
                    return;
                }

                var LinesToKeep = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    bool B = false;
                    if (A[0].Equals("Folder"))
                    {
                        B = true;
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FolderName)))
                        {
                            FolderFound = true;
                            AddLine(ref LinesToKeep, ParmStr);
                        }
                        else
                        {
                            AddLine(ref LinesToKeep, S);
                        }
                    }

                    if (!B)
                    {
                        AddLine(ref LinesToKeep, S);
                    }
                }

                SR.Close();
                if (FolderFound == false)
                {
                    if (Information.UBound(LinesToKeep) > 0)
                    {
                        WriteArrayToParmFile(LinesToKeep);
                    }

                    AppendToParmFile(ParmStr);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : addEmailFolder : 149 : " + ex.Message);
            }
        }

        public void setRunAtStart(string RunAtStart)
        {
            try
            {
                string ParmStr = "";
                ParmStr = "Run@Start" + "|";
                ParmStr = ParmStr + RunAtStart;
                var LinesToKeep = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
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
                    AppendToParmFile(ParmStr);
                    WriteArrayToParmFile(LinesToKeep);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.11 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : setRunAtStart : 172 : " + ex.Message);
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
                if (!File.Exists(fName))
                {
                    AppendToParmFile(ParmStr);
                    return;
                }

                var LinesToKeep = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    bool B = false;
                    if (A[0].Equals("File"))
                    {
                        B = true;
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FolderName)))
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
                    if (Information.UBound(LinesToKeep) > 0)
                    {
                        WriteArrayToParmFile(LinesToKeep);
                    }

                    AppendToParmFile(ParmStr);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : addFileFolder : 211 : " + ex.Message);
            }
        }

        public void addDbConnStr(string DBName, string Connstr)
        {
            try
            {
                string ParmStr = "";
                ParmStr = "DBARCH" + "|";
                ParmStr = ParmStr + DBName + "|";
                ParmStr = ParmStr + Connstr;
                if (!File.Exists(fName))
                {
                    AppendToParmFile(ParmStr);
                    return;
                }

                var LinesToKeep = new string[1];
                bool DbFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    bool B = false;
                    if (A[0].Equals("DBARCH"))
                    {
                        B = true;
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(DBName)))
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
                    if (Information.UBound(LinesToKeep) > 0)
                    {
                        WriteArrayToParmFile(LinesToKeep);
                    }

                    AppendToParmFile(ParmStr);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : addDbConnStr : 248 : " + ex.Message);
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
                ParmStr = "EXT" + "|" + FileExt;
                if (!File.Exists(fName))
                {
                    AppendToParmFile(ParmStr);
                    return;
                }

                var LinesToKeep = new string[1];
                bool DbFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    bool B = false;
                    if (A[0].Equals("EXT"))
                    {
                        B = true;
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FileExt)))
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
                    if (Information.UBound(LinesToKeep) > 0)
                    {
                        WriteArrayToParmFile(LinesToKeep);
                    }

                    AppendToParmFile(ParmStr);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : addFileExt : 283 : " + ex.Message);
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
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    bool B = false;
                    if (A[0].Equals("DBARCH"))
                    {
                        string tName = A[1];
                        LB.Items.Add(tName);
                    }
                }

                SR.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 123.25.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : LoadDatabases : 299 : " + ex.Message);
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
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
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
                MessageBox.Show("Error 123.25.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : LoadFileExt : 315 : " + ex.Message);
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
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
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
                MessageBox.Show("Error 123.25.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : LoadFileExt : 331 : " + ex.Message);
            }
            finally
            {
            }
        }

        public void getActiveEmailFolders(ref ListBox LB)
        {
            try
            {
                LB.Items.Clear();
                var LinesToKeep = new string[1];
                var A = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    A = S.Split('|');
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
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : getActiveEmailFolders : 347 : " + ex.Message);
            }
        }

        public void deleteDbConnStr(string DBName, string Connstr)
        {
            try
            {
                var LinesToKeep = new string[1];
                bool DbFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    if (A[0].Equals("DBARCH"))
                    {
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(DBName)))
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
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : deleteDbConnStr : 368 : " + ex.Message);
            }
        }

        public void deleteFileExt(string FileExt)
        {
            try
            {
                var LinesToKeep = new string[1];
                bool DbFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    var A = S.Split('|');
                    if (A[0].Equals("EXT"))
                    {
                        string tName = A[1];
                        if (Strings.UCase(tName).Equals(Strings.UCase(FileExt)))
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
                MessageBox.Show("Error 123.23.1 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : deleteFileExt : 389 : " + ex.Message);
            }
        }

        public void getRunAtStart(CheckBox CK)
        {
            try
            {
                CK.Checked = false;
                var LinesToKeep = new string[1];
                var A = new string[1];
                bool FolderFound = false;
                var SR = new StreamReader(fName);
                while (!SR.EndOfStream)
                {
                    string S = SR.ReadLine();
                    A = S.Split('|');
                    if (A[0].Equals("Run@Start"))
                    {
                        string RunParm = A[1];
                        if (Strings.UCase(RunParm).Equals("Y"))
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
                MessageBox.Show("Error 123.23.10 - " + ex.Message);
                LOG.WriteToArchiveLog("clsExecParms : getRunAtStart : 409 : " + ex.Message);
            }
        }

        public void genInitialParmFIle()
        {
        }

        public void AddLine(ref string[] A, string S)
        {
            int I = 0;
            Array.Resize(ref A, Information.UBound(A) + 1 + 1);
            A[Information.UBound(A)] = S;
        }

        public void WriteArrayToParmFile(string[] a)
        {
            var SW = new StreamWriter(fName);
            for (int i = 0, loopTo = Information.UBound(a); i <= loopTo; i++)
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
            FileSystem.Kill(fName);
        }

        public void AppendToParmFile(string S)
        {
            var SW = new StreamWriter(fName, true);
            SW.WriteLine(S);
            SW.Close();
        }
    }
}
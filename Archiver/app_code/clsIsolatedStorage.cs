// Imports System.Windows.Browser.HtmlPage
using global::System;
using System.Collections;
using global::System.IO;
using global::System.IO.IsolatedStorage;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsIsolatedStorage
    {

        // Public bDoNotOverwriteExistingFile As Boolean = True
        // Public bOverwriteExistingFile As Boolean = False
        // Public bRestoreToOriginalDirectory As Boolean = False
        // Public bRestoreToMyDocuments As Boolean = False
        // Public bCreateOriginalDirIfMissing As Boolean = True

        public clsIsolatedStorage()
        {
            dirPersist = AppDir + @"\" + "EcmPersistantData";
            dirAttachInfo = AppDir + @"\" + "EcmAttachInfo";
            dirFormData = AppDir + @"\" + "EcmForm";
            dirTempData = AppDir + @"\" + "EcmTemp";
            dirLogData = AppDir + @"\" + "EcmLogs";
            dirSaveData = AppDir + @"\" + "EcmSavedData";

            // Dim store = IsolatedStorageFile.GetUserStoreForApplication()
            // isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
            // Try
            // store.CreateDirectory(dirAttachInfo)
            // Catch ex As Exception
            // Console.WriteLine(ex.Message)
            // End Try

        }

        public string AppDir = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
        public string dirPersist;
        public string dirAttachInfo;
        public string dirFormData;
        public string dirTempData;
        public string dirLogData;
        public string dirSaveData;

        public void PersistDataInit(string tKey, string tData)
        {
            string FQN = Path.Combine(dirPersist, "Persist.dat");
            byte[] Buffer;
            string tgtLine = tKey + "|" + tData + Constants.vbCrLf;
            try
            {
                if (!Directory.Exists(dirPersist))
                {
                    Directory.CreateDirectory(dirPersist);
                }

                Buffer = StrToByteArray(tgtLine);
                var isoStream2 = new StreamWriter(FQN, false);
                isoStream2.WriteLine(tgtLine);
                isoStream2.Close();
            }
            catch (IsolatedStorageException ex)
            {
                MessageBox.Show("Error SaveFormData 700: saving data: " + ex.Message);
            }
        }

        public void PersistDataSave(string tKey, string tData)
        {

            // Dim dirFormData As String = "EcmTemp"
            string FQN = Path.Combine(dirPersist, "Persist.dat");
            // Dim isoStore As IsolatedStorageFile
            // isoStore = IsolatedStorageFile.GetUserStoreForApplication
            byte[] Buffer;
            string tgtLine = tKey + "|" + tData + Constants.vbCrLf;
            try
            {
                // Using store = IsolatedStorageFile.GetUserStoreForApplication()
                if (!Directory.Exists(dirPersist))
                {
                    Directory.CreateDirectory(dirPersist);
                }

                Buffer = StrToByteArray(tgtLine);
                var isoStream2 = new StreamWriter(FQN, true);
                isoStream2.Write(tgtLine);
                isoStream2.Close();
            }

            // End Using
            catch (IsolatedStorageException ex)
            {
                MessageBox.Show("Error SaveFormData 657: saving data: " + ex.Message);
            }
        }

        public string PersistDataRead(string tKey)
        {
            string FQN = Path.Combine(dirPersist, "Persist.dat");
            string ValName = "";
            string tgtVal = "";
            string RetVal = "";

            // Dim isoStore As IsolatedStorageFile
            // isoStore = IsolatedStorageFile.GetUserStoreForApplication
            // Using isoStore
            if (File.Exists(FQN))
            {
                using (var sr = new StreamReader(FQN))
                {
                    RetVal = "";
                    tgtVal = sr.ReadLine();
                    while (!sr.EndOfStream)
                    {
                        var A = tgtVal.Split('|');
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

            // End Using

            return RetVal;
        }

        public string readIsoFile(string Filename)
        {
            // If Not File.Exists(Filename) Then
            // Return ""
            // End If
            string InputText = "";
            try
            {
                var isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly, null, null);
                var isolatedStream = new IsolatedStorageFileStream(Filename, FileMode.Open, isolatedStore);
                var reader = new StreamReader(isolatedStream);
                InputText = reader.ReadToEnd();
                reader.Close();
            }
            catch (Exception ex)
            {
                if (!modGlobals.gRunUnattended)
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
                var isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly, null, null);
                var isoStream = new IsolatedStorageFileStream(FileName, FileMode.Append, FileAccess.Write, isolatedStore);
                var writer = new StreamWriter(isoStream);
                writer.WriteLine(sLine);
                writer.Close();
            }
            catch (Exception ex)
            {
                if (!modGlobals.gRunUnattended)
                {
                    MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message);
                }
            }
        }

        public void saveIsoFileZeroize(string FileName, string sLine)
        {
            try
            {
                var isolatedStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly, null, null);
                var isoStream = new IsolatedStorageFileStream(FileName, FileMode.Create, FileAccess.Write, isolatedStore);
                var writer = new StreamWriter(isoStream);
                writer.WriteLine(sLine);
                writer.Close();
            }
            catch (Exception ex)
            {
                if (!modGlobals.gRunUnattended)
                {
                    MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message);
                }
            }
        }

        public static byte[] StrToByteArray(string str)
        {
            var encoding = new System.Text.UTF8Encoding();
            return encoding.GetBytes(str);
        } // StrToByteArray

        public bool isoDirExist()
        {
            // Using store = IsolatedStorageFile.GetUserStoreForApplication()
            using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null))
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
                string FQN = Path.Combine(dirAttachInfo, FormDataFileName);
                using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null))
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
            string FQN = Path.Combine(dirAttachInfo, FormDataFileName);
            try
            {
                if (isoDirExist())
                {
                    using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null))
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
            string FQN = Path.Combine(dirAttachInfo, FormDataFileName);
            string tgtLine = CompanyID + "|" + RepoID;
            IsolatedStorageFile isoStore;
            isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null);
            if (!isoDirExist())
            {
                isoStore.CreateDirectory(dirAttachInfo);
            }

            try
            {
                // Declare a new StreamWriter.
                StreamWriter writer = null;
                // Assign the writer to the store and the file TestStore.
                writer = new StreamWriter(new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore));
                writer.WriteLine(tgtLine + Constants.vbCrLf);
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
            if (!isoFileExist())
            {
                return false;
            }

            CompanyID = "";
            RepoID = "";
            IsolatedStorageFile isoStore;
            bool B = true;
            string FormDataFileName = "AttachInfo.dat";
            string FQN = Path.Combine(dirAttachInfo, FormDataFileName);
            string tgtLine = "";
            isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null);
            var reader = new StreamReader(new IsolatedStorageFileStream(FQN, FileMode.Open, isoStore));
            using (isoStore)
            {
                int fLen = 0;
                using (reader)
                {
                    try
                    {
                        tgtLine = reader.ReadLine();
                    }
                    catch (Exception ex)
                    {
                        return false;
                    }

                    var A = tgtLine.Split('|');
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
            var fileList = new ArrayList(files);
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
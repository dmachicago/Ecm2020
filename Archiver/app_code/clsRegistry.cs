using System;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic.CompilerServices;
using global::Microsoft.Win32;
using MODI;

namespace EcmArchiver
{
    public class clsRegistry
    {
        // Each key starts with the word HKEY, which stands for Key Handle. We are going 
        // to call these keys, rey roots. Each key root has subkeys. Each key root is related 
        // to one aspect of the configuration data, like the user or computer-dependent settings.

        // HKEY_CLASSES_ROOT.This branch of the Registry contains all the names of the registered 
        // file types and their properties. In other words, the information saved here ensures the 
        // right program opens when you double-click a file in the Windows Explorer. This key is an alias 
        // of HKEY_LOCAL_MACHINE\Software subkey.

        // HKEY_CURRENT_USER. This key contains the configuration information about the user who is 
        // currently logged on. The user profile is stored here: user's folders, screen colors and 
        // Control Panel settings. This branch is an alias of HKEY_USERS key.

        // HKEY_LOCAL_MACHINE. Contains configuration information related to the computer for all users.

        // HKEY_USERS. This branch stores all the user's profiles on the computer.

        // HKEY_CURRENT_CONFIG. This key has information about the hardware profile used by the local 
        // computer at system startup

        // REG_SZ
        // A fixed-length text string. Boolean (True or False) values and other short text values usually have this data type. 

        // REG_EXPAND_SZ
        // A variable-length text string that can include variables that are resolved when an application or service uses the data. 

        // REG_DWORD
        // Data represented by a number that is 4 bytes (32 bits) long. 

        // REG_MULTI_SZ
        // Multiple text strings formatted as an array of null-terminated strings, and terminated by two null characters. 

        // The operations on the registry in .NET can be done using two classes of the Microsoft.Win32 Namespace: Registry 
        // class and the RegistryKey class.The Registry class provides base registry keys 'as shared public (read-only) methods: 

        // ClassesRoot
        // This field reads the Windows registry base key HKEY_CLASSES_ROOT.

        // CurrentConfig
        // Reads the Windows registry base key HKEY_CURRENT_CONFIG.

        // CurrentUser
        // Reads the Windows registry base key HKEY_CURRENT_USER

        // LocalMachine
        // This field reads the Windows registry base key HKEY_LOCAL_MACHINE.

        // Users
        // This field reads the Windows registry base key HKEY_USERS.

        private string KeyName = "ECMLIBRARY";
        private string SubKeyDir = "EcmArchiverDir";
        private string AppDir = Application.ExecutablePath.ToString();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsLogging LOG = new clsLogging();

        public RegistryKey HKeyLocalMachine
        {
            get
            {
                return Registry.LocalMachine;
            }
        }

        public string ReadEcmRegistrySubKey(string KeyName)
        {
            string SubKeyVal = "";
            try
            {
                SubKeyVal = Conversions.ToString(My.MyProject.Computer.Registry.GetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", KeyName, ""));
            }
            catch (Exception ex)
            {
                SubKeyVal = "";
            }

            return SubKeyVal;
        }

        public bool CreateEcmRegistrySubKey(string KeyName, string RegValue)
        {
            bool B = false;
            try
            {
                My.MyProject.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY");
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", KeyName, RegValue);
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool UpdateEcmRegistrySubKey(string KeyName, string RegValue)
        {
            bool B = false;
            try
            {
                My.MyProject.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY");
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", KeyName, RegValue);
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool DeleteEcmRegistrySubKey(string KeyName)
        {
            bool B = false;
            try
            {
                My.MyProject.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY");
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", KeyName, "");
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool CreateEcmSubKey()
        {
            bool B = false;
            try
            {
                My.MyProject.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY");
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", AppDir);
                B = true;
            }

            // Dim regKey As RegistryKey
            // regKey = Registry.Users.OpenSubKey("SOFTWARE\EcmArchiverDir", True)
            // regKey.CreateSubKey(SubKeyDir)
            // regKey.Close()

            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool SetEcmSubKey()
        {
            bool B = false;
            string SubKeyVal = "";
            try
            {
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", AppDir);
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public string ReadEcmSubKey(string KeyName)
        {
            string SubKeyVal = "";
            try
            {
                SubKeyVal = Conversions.ToString(My.MyProject.Computer.Registry.GetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", ""));
            }
            catch (Exception ex)
            {
                SubKeyVal = "";
            }

            return SubKeyVal;
        }

        public bool DeleteEcmSubKey()
        {
            bool B = false;
            try
            {
                RegistryKey regKey;
                regKey = Registry.LocalMachine.OpenSubKey(KeyName, true);
                regKey.DeleteSubKey(SubKeyDir, true);
                regKey.Close();
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        /// Allowed values to date:
    /// RepositoryCS
    /// TheasaurusCS
        public bool SetEcmCurrentConnectionString(string ConnName, string CS)
        {
            if (ConnName.Equals("RepositoryCS"))
            {
            }
            else if (ConnName.Equals("TheasaurusCS"))
            {
            }
            else
            {
                LOG.WriteToArchiveLog("FATAL ERROR: Incorrect Registry connection name supplied, returning NULL.");
                MessageBox.Show("FATAL ERROR: Incorect Registry connection name supplied, returning NULL.");
                return false;
            }

            CS = ENC.AES256EncryptString(CS);
            bool B = false;
            string SubKeyVal = "";
            try
            {
                My.MyProject.Computer.Registry.SetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", ConnName, CS);
                B = true;
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public string ReadEcmCurrentConnectionString(string ConnName)
        {
            if (ConnName.Equals("RepositoryCS"))
            {
            }
            else if (ConnName.Equals("TheasaurusCS"))
            {
            }
            else
            {
                LOG.WriteToArchiveLog("FATAL ERROR: Incorrect Registry connection name supplied, returning NULL.");
                MessageBox.Show("FATAL ERROR: Incorect Registry connection name supplied, returning NULL.");
                return "";
            }

            string SubKeyVal = "";
            try
            {
                SubKeyVal = Conversions.ToString(My.MyProject.Computer.Registry.GetValue(@"HKEY_CURRENT_USER\ECMLIBRARY", ConnName, ""));
            }
            catch (Exception ex)
            {
                SubKeyVal = "";
            }

            SubKeyVal = ENC.AES256DecryptString(SubKeyVal);
            return SubKeyVal;
        }
    }
}
Imports Microsoft.Win32
Imports ECMEncryption

Public Class clsRegistry
    'Each key starts with the word HKEY, which stands for Key Handle. We are going 
    'to call these keys, rey roots. Each key root has subkeys. Each key root is related 
    'to one aspect of the configuration data, like the user or computer-dependent settings.

    'HKEY_CLASSES_ROOT.This branch of the Registry contains all the names of the registered 
    'file types and their properties. In other words, the information saved here ensures the 
    'right program opens when you double-click a file in the Windows Explorer. This key is an alias 
    'of HKEY_LOCAL_MACHINE\Software subkey.

    'HKEY_CURRENT_USER. This key contains the configuration information about the user who is 
    'currently logged on. The user profile is stored here: user's folders, screen colors and 
    'Control Panel settings. This branch is an alias of HKEY_USERS key.

    'HKEY_LOCAL_MACHINE. Contains configuration information related to the computer for all users.

    'HKEY_USERS. This branch stores all the user's profiles on the computer.

    'HKEY_CURRENT_CONFIG. This key has information about the hardware profile used by the local 
    'computer at system startup

    'REG_SZ
    ' A fixed-length text string. Boolean (True or False) values and other short text values usually have this data type. 

    'REG_EXPAND_SZ
    ' A variable-length text string that can include variables that are resolved when an application or service uses the data. 

    'REG_DWORD
    ' Data represented by a number that is 4 bytes (32 bits) long. 

    'REG_MULTI_SZ
    ' Multiple text strings formatted as an array of null-terminated strings, and terminated by two null characters. 

    'The operations on the registry in .NET can be done using two classes of the Microsoft.Win32 Namespace: Registry 
    'class and the RegistryKey class.The Registry class provides base registry keys 'as shared public (read-only) methods: 

    'ClassesRoot
    ' This field reads the Windows registry base key HKEY_CLASSES_ROOT.

    'CurrentConfig
    ' Reads the Windows registry base key HKEY_CURRENT_CONFIG.

    'CurrentUser
    ' Reads the Windows registry base key HKEY_CURRENT_USER

    'LocalMachine
    ' This field reads the Windows registry base key HKEY_LOCAL_MACHINE.

    'Users
    ' This field reads the Windows registry base key HKEY_USERS.

    Dim KeyName As String = "ECMLIBRARY"
    Dim SubKeyDir As String = "EcmArchiverDir"
    Dim AppDir As String = Application.ExecutablePath.ToString
    Dim ENC As new ECMEncrypt
    Dim LOG As New clsLogging

    Public ReadOnly Property HKeyLocalMachine() As RegistryKey
        Get
            Return Registry.LocalMachine
        End Get
    End Property

    Function ReadEcmRegistrySubKey(ByVal KeyName As String) As String

        Dim SubKeyVal As String = ""
        Try
            SubKeyVal = My.Computer.Registry.GetValue("HKEY_CURRENT_USER\ECMLIBRARY", KeyName, "")
        Catch ex As Exception
            SubKeyVal = ""
        End Try
        Return SubKeyVal

    End Function
    Function CreateEcmRegistrySubKey(ByVal KeyName As String, ByVal RegValue As String) As Boolean

        Dim B As Boolean = False
        Try
            My.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY")
            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", KeyName, RegValue)
            B = True
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function

    Function UpdateEcmRegistrySubKey(ByVal KeyName As String, ByVal RegValue As String) As Boolean

        Dim B As Boolean = False
        Try
            My.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY")
            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", KeyName, RegValue)
            B = True
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function

    Function DeleteEcmRegistrySubKey(ByVal KeyName As String) As Boolean

        Dim B As Boolean = False
        Try
            My.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY")
            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", KeyName, "")
            B = True
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function

    Function CreateEcmSubKey() As Boolean

        Dim B As Boolean = False
        Try
            My.Computer.Registry.CurrentUser.CreateSubKey("ECMLIBRARY")

            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", AppDir)
            B = True

            'Dim regKey As RegistryKey
            'regKey = Registry.Users.OpenSubKey("SOFTWARE\EcmArchiverDir", True)
            'regKey.CreateSubKey(SubKeyDir)
            'regKey.Close()

        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function

    Function SetEcmSubKey() As Boolean

        Dim B As Boolean = False
        Dim SubKeyVal As String = ""
        Try
            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", AppDir)
            B = True
        Catch ex As Exception
            B = False
        End Try
        Return B

    End Function

    Function ReadEcmSubKey(ByVal KeyName As String) As String

        Dim SubKeyVal As String = ""
        Try
            SubKeyVal = My.Computer.Registry.GetValue("HKEY_CURRENT_USER\ECMLIBRARY", "EcmArchiverDir", "")
        Catch ex As Exception
            SubKeyVal = ""
        End Try
        Return SubKeyVal

    End Function

    Function DeleteEcmSubKey() As Boolean
        Dim B As Boolean = False
        Try
            Dim regKey As RegistryKey
            regKey = Registry.LocalMachine.OpenSubKey(KeyName, True)
            regKey.DeleteSubKey(SubKeyDir, True)
            regKey.Close()
            B = True
        Catch ex As Exception
            B = False
        End Try

        Return B

    End Function

    '''
    ''' Allowed values to date:
    ''' RepositoryCS
    ''' TheasaurusCS
    '''
    Function SetEcmCurrentConnectionString(ByVal ConnName As String, ByVal CS As String) As Boolean
        If ConnName.Equals("RepositoryCS") Then
        ElseIf ConnName.Equals("TheasaurusCS") Then
        Else
            log.WriteToArchiveLog("FATAL ERROR: Incorrect Registry connection name supplied, returning NULL.")
            messagebox.show("FATAL ERROR: Incorect Registry connection name supplied, returning NULL.")
            Return False
        End If
        CS = ENC.AES256EncryptString(CS)
        Dim B As Boolean = False
        Dim SubKeyVal As String = ""
        Try
            My.Computer.Registry.SetValue("HKEY_CURRENT_USER\ECMLIBRARY", ConnName, CS)
            B = True
        Catch ex As Exception
            B = False
        End Try
        Return B

    End Function

    Function ReadEcmCurrentConnectionString(ByVal ConnName As String) As String

        If ConnName.Equals("RepositoryCS") Then
        ElseIf ConnName.Equals("TheasaurusCS") Then
        Else
            log.WriteToArchiveLog("FATAL ERROR: Incorrect Registry connection name supplied, returning NULL.")
            messagebox.show("FATAL ERROR: Incorect Registry connection name supplied, returning NULL.")
            Return ""
        End If
        Dim SubKeyVal As String = ""
        Try
            SubKeyVal = My.Computer.Registry.GetValue("HKEY_CURRENT_USER\ECMLIBRARY", ConnName, "")
        Catch ex As Exception
            SubKeyVal = ""
        End Try
        SubKeyVal = ENC.AES256DecryptString(SubKeyVal)
        Return SubKeyVal

    End Function

End Class

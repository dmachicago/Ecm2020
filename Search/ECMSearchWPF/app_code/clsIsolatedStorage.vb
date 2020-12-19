' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 12-15-2020
'
' Last Modified By : wdale
' Last Modified On : 12-15-2020
' ***********************************************************************
' <copyright file="clsIsolatedStorage.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.IO.IsolatedStorage
Imports System.IO
Imports System.IO.Directory
Imports System.IO.DirectoryInfo
Imports System.IO.DirectoryNotFoundException
Imports System.IO.IsolatedStorage.IsolatedStorageFile
Imports System.IO.IsolatedStorage.IsolatedStorageFileStream

''' <summary>
''' Class clsIsolatedStorage.
''' </summary>
Public Class clsIsolatedStorage



    ''' <summary>
    ''' The dir ecm grids
    ''' </summary>
    Public dirEcmGrids As String = "EcmGridParms"
    ''' <summary>
    ''' The function all search email grid
    ''' </summary>
    Public fnAllSearchEmailGrid As String = "dgEmailAll.grid.dat"
    ''' <summary>
    ''' The function all search content grid
    ''' </summary>
    Public fnAllSearchContentGrid As String = "dgContentAll.grid.dat"
    ''' <summary>
    ''' The function search content grid
    ''' </summary>
    Public fnSearchContentGrid As String = "dgContent.grid.dat"
    ''' <summary>
    ''' The function search email grid
    ''' </summary>
    Public fnSearchEmailGrid As String = "dgEmail.grid.dat"

    ''' <summary>
    ''' The dir form data
    ''' </summary>
    Public dirFormData As String = "EcmForm."
    ''' <summary>
    ''' The dir temporary data
    ''' </summary>
    Public dirTempData As String = "EcmTemp."
    ''' <summary>
    ''' The dir log data
    ''' </summary>
    Public dirLogData As String = "EcmLogs."
    ''' <summary>
    ''' The dir save data
    ''' </summary>
    Public dirSaveData As String = "EcmSavedData."

    ''' <summary>
    ''' The dir restore
    ''' </summary>
    Public dirRestore As String = "EcmRestoreFiles."
    ''' <summary>
    ''' The file restore
    ''' </summary>
    Dim FileRestore As String = ".RestoreDat"

    ''' <summary>
    ''' The dir preview
    ''' </summary>
    Public dirPreview As String = "EcmPreviewFile."
    ''' <summary>
    ''' The file preview
    ''' </summary>
    Public filePreview As String = "ECM.Preview.dat"

    ''' <summary>
    ''' The dir search filter
    ''' </summary>
    Public dirSearchFilter As String = "EcmSearchFilter."
    ''' <summary>
    ''' The dir CLC
    ''' </summary>
    Public dirCLC As String = "EcmSearchFilter."
    ''' <summary>
    ''' The dir search save
    ''' </summary>
    Public dirSearchSave As String = "EcmSavedSearch."
    ''' <summary>
    ''' The dir detail search parms
    ''' </summary>
    Public dirDetailSearchParms As String = "EcmDetailSearchParm."
    ''' <summary>
    ''' The dir files
    ''' </summary>
    Public dirFiles As String = "EcmTempFiles."
    ''' <summary>
    ''' The dir persist
    ''' </summary>
    Public dirPersist As String = "EcmPersistantData."

    ''' <summary>
    ''' The b do not overwrite existing file
    ''' </summary>
    Public bDoNotOverwriteExistingFile As Boolean = True
    ''' <summary>
    ''' The b overwrite existing file
    ''' </summary>
    Public bOverwriteExistingFile As Boolean = False
    ''' <summary>
    ''' The b restore to original directory
    ''' </summary>
    Public bRestoreToOriginalDirectory As Boolean = False
    ''' <summary>
    ''' The b restore to my documents
    ''' </summary>
    Public bRestoreToMyDocuments As Boolean = False
    ''' <summary>
    ''' The b create original dir if missing
    ''' </summary>
    Public bCreateOriginalDirIfMissing As Boolean = True

    'Dim LOG As New clsLogMain
    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As IsolatedStorageFile = IsolatedStorageFile.GetUserStoreForDomain()

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsIsolatedStorage"/> class.
    ''' </summary>
    Sub New()

        If Not ISO.FileExists(dirPersist) Then
            ISO.CreateFile(dirPersist)
        End If

        If Not ISO.FileExists(dirFiles) Then
            ISO.CreateFile(dirFiles)
        End If

        If Not ISO.FileExists(dirDetailSearchParms) Then
            ISO.CreateFile(dirDetailSearchParms)
        End If

        If Not ISO.FileExists(dirSearchSave) Then
            ISO.CreateFile(dirSearchSave)
        End If

        If Not ISO.FileExists(dirRestore) Then
            ISO.CreateFile(dirRestore)
        End If

        If Not ISO.FileExists(dirPreview) Then
            ISO.CreateFile(dirPreview)
        End If

        If Not ISO.FileExists(dirLogData) Then
            ISO.CreateFile(dirLogData)
        End If

        If Not ISO.FileExists(dirSaveData) Then
            ISO.CreateFile(dirSaveData)
        End If

        If Not ISO.FileExists(dirFormData) Then
            ISO.CreateFile(dirFormData)
        End If

        If Not ISO.FileExists(dirEcmGrids) Then
            ISO.CreateFile(dirEcmGrids)
        End If

        If Not ISO.FileExists(dirTempData) Then
            ISO.CreateFile(dirTempData)
        End If

        If Not ISO.FileExists(dirSearchFilter) Then
            ISO.CreateFile(dirSearchFilter)
        End If

        If Not ISO.FileExists(dirCLC) Then
            ISO.CreateFile(dirCLC)
        End If

    End Sub

    ''' <summary>
    ''' Gets the grid dir.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function getGridDir() As String
        Return dirEcmGrids
    End Function
    ''' <summary>
    ''' Gets the forms dir.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function getFormsDir() As String
        Return dirEcmGrids
    End Function
    ''' <summary>
    ''' Gets the temporary dir.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function getTempDir() As String
        Return dirTempData
    End Function

    'Public Sub SetCookie(ByVal tKey As String, ByVal tValue As String)
    '    Dim Days As Integer = 365 * 3
    '    Dim expireDate As DateTime = DateTime.Now + TimeSpan.FromDays(Days)
    '    Dim newCookie As String = tKey + "=" + tValue + ""
    '    System.Windows.Browser.HtmlPage.Document.SetProperty("cookie", newCookie)
    'End Sub

    'Public Function GetCookie(ByVal key As String) As String
    '    Dim cookies() As String = System.Windows.Browser.HtmlPage.Document.Cookies.Split(";")
    '    Dim keyValue() As String
    '    Dim tgtVal As String = ""
    '    For Each cookie As String In cookies
    '        keyValue = cookie.Split("=")
    '        'if (keyValue.Length == 2) then 
    '        If (keyValue(0).ToString().Equals(key)) Then
    '            tgtVal = keyValue(1)
    '            Exit For
    '        End If
    '        'End If
    '    Next
    '    Return tgtVal
    'End Function

    ''' <summary>
    ''' Strings to byte array.
    ''' </summary>
    ''' <param name="str">The string.</param>
    ''' <returns>System.Byte().</returns>
    Public Shared Function StrToByteArray(ByVal str As String) As Byte()
        Dim encoding As New System.Text.UTF8Encoding()
        Return encoding.GetBytes(str)
    End Function 'StrToByteArray

    ''' <summary>
    ''' Fixes the FQN.
    ''' </summary>
    ''' <param name="fqn">The FQN.</param>
    Sub fixFqn(ByRef fqn As String)
        Dim i As Integer = 0
        i = fqn.IndexOf("\")
        If i >= 0 Then
            Dim s1 As String = fqn.Substring(0, i)
            Dim s2 As String = fqn.Substring(i + 1)
            fqn = s1 + s2
        End If

    End Sub

    ''' <summary>
    ''' Zeroizes the save form data.
    ''' </summary>
    ''' <param name="IndexKey">The index key.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="SaveTypeCode">The save type code.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ValName">Name of the value.</param>
    ''' <param name="ValValue">The value value.</param>
    Public Sub ZeroizeSaveFormData(ByVal IndexKey As Integer, ByVal ScreenName As String, ByVal SaveTypeCode As String, ByVal UID As String, ByVal ValName As String, ByVal ValValue As String)
        Dim FormDataFileName As String = ScreenName + IndexKey.ToString + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = "@@" + ChrW(254) + Now.ToString + vbCrLf
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Buffer = StrToByteArray(tgtLine)

                If File.Exists(FQN) Then
                    Dim isoStream2 As New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Truncate, isoStore))
                    isoStream2.Close()
                Else
                    Dim isoStream2 As New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
                    isoStream2.Write(tgtLine)
                    isoStream2.Close()
                End If

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 100: saving Data:  " + ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Saves the form data.
    ''' </summary>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="IndexKey">The index key.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ValName">Name of the value.</param>
    ''' <param name="ValValue">The value value.</param>
    Public Sub SaveFormData(ByRef DICT As Dictionary(Of String, String), ByVal IndexKey As Integer, ByVal ScreenName As String, ByVal UID As String, ByVal ValName As String, ByVal ValValue As String)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim FormDataFileName As String = ScreenName + IndexKey.ToString + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim tgtLine As String = ValName + ChrW(254) + ValValue
        If DICT.ContainsKey(ValName) Then
            DICT.Item(ValName) = ValValue
        Else
            DICT.Add(ValName, ValValue)
        End If

        Try
            ' Declare a new StreamWriter.
            Dim writer As StreamWriter = Nothing
            ' Assign the writer to the store and the file TestStore.
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
            writer.WriteLine(tgtLine)
            writer.Close()
            writer.Dispose()
            writer = Nothing
        Catch ex As IsolatedStorageException
            Console.WriteLine("Error SaveFormData 200 saving Data:  " + ex.Message)
        End Try
        isoStore.Dispose()

    End Sub

    ''' <summary>
    ''' Reads the form data.
    ''' </summary>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="IndexKey">The index key.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UID">The uid.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ReadFormData(ByRef DICT As Dictionary(Of String, String), ByVal IndexKey As Integer, ByVal ScreenName As String, ByVal UID As String) As Boolean

        Dim isoStore As IsolatedStorageFile

        Dim B As Boolean = True
        Dim FormDataFileName As String = ScreenName + IndexKey.ToString + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)
        Dim tgtVal As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)
        'ReadFile = New Byte(1023) {}
        'p.Read(Buffer, 0, ReadFile.Length)
        'p.Close()
        'Return ReadFile

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Dim formData As String = ""
                Try
                    formData = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                Dim II As Integer = 0
                Do While Not sr.EndOfStream
                    II += 1
                    If II > 100 Then
                        Exit Do
                    End If
                    If formData.Trim.Length > 0 Then
                        Dim A() As String = formData.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        If DICT.ContainsKey(tKey) Then
                            DICT.Item(tKey) = tValue
                        Else
                            DICT.Add(tKey, tValue)
                        End If
                        formData = sr.ReadLine()
                    End If
                Loop
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return B

    End Function

    '***********************************************************************************
    ''' <summary>
    ''' Zeroizes the grid sort order.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="SortType">Type of the sort.</param>
    ''' <param name="UID">The uid.</param>
    Public Sub ZeroizeGridSortOrder(ByVal ScreenName As String, ByVal GridName As String, ByVal ColName As String, ByVal SortType As String, ByVal UID As String)

        Dim FormDataFileName As String = ScreenName + "." + GridName + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = "@@" + ChrW(254) + Now.ToString + vbCrLf
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Buffer = StrToByteArray(tgtLine)

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                isoStream2.Write(Buffer, 0, Buffer.Length)
                isoStream2.Close()

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 300: saving data: " + ex.Message)
        Finally
            isoStore = Nothing
            GC.Collect()
        End Try
    End Sub

    ''' <summary>
    ''' Saves the grid sort col.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="SortType">Type of the sort.</param>
    ''' <param name="UID">The uid.</param>
    Public Sub saveGridSortCol(ByVal ScreenName As String, ByVal GridName As String, ByVal ColName As String, ByVal SortType As String, ByVal UID As String)

        ZeroizeGridSortOrder(ScreenName, GridName, ColName, SortType, UID)

        'Dim dirFormData As String = "FormData"
        Dim FormDataFileName As String = ScreenName + "." + GridName + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = ColName + ChrW(254) + SortType + vbCrLf
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Buffer = StrToByteArray(tgtLine)

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore)
                isoStream2.Write(Buffer, 0, Buffer.Length)
                isoStream2.Close()

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 400: saving Data:   " + ex.Message)
        Finally
            isoStore = Nothing
            GC.Collect()
        End Try
    End Sub

    ''' <summary>
    ''' Gets the grid sort col.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="SortType">Type of the sort.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Public Sub getGridSortCol(ByVal ScreenName As String, ByVal GridName As String, ByRef ColName As String, ByRef SortType As String, ByVal UID As String, ByRef RC As Boolean)
        Dim FormDataFileName As String = ScreenName + "." + GridName + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)
        Dim tgtVal As String = ""
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim tgtLine As String = ColName + ChrW(254) + SortType + vbCrLf

        Try
            RC = True
            Using isoStore
                'Load form data
                Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
                'Check to see if file exists before proceeding
                If Not isoStore.FileExists(filePath) Then
                    ColName = ""
                    SortType = ""
                    RC = False
                    Exit Try
                End If
                Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                    Dim formData As String = ""
                    Do While formData = sr.ReadLine()
                        Dim A() As String = formData.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        If Not tValue.Equals("@@") Then
                            ColName = tKey
                            SortType = tValue
                            Exit Do
                        End If
                    Loop
                    sr.Close()
                End Using
            End Using
        Catch ex As Exception
            MessageBox.Show("ERROR ReadGridSortOrder -100  " + ex.Message)
            RC = False
        Finally
            dirFormData = Nothing
            FormDataFileName = Nothing
            FQN = Nothing
            tgtVal = Nothing
            isoStore = Nothing
            tgtLine = Nothing
            GC.Collect()
        End Try
    End Sub

    '********************************************************************************************************************************************************
    ''' <summary>
    ''' Zeroizes the grid col display order.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="ColumnName">Name of the column.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ValName">Name of the value.</param>
    ''' <param name="ValValue">The value value.</param>
    Public Sub ZeroizeGridColDisplayOrder(ByVal ScreenName As String, ByVal GridName As String, ByVal ColumnName As String, ByVal UID As String, ByVal ValName As String, ByVal ValValue As String)

        'Dim dirFormData As String = "FormData"
        Dim FormDataFileName As String = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = "@@" + ChrW(254) + Now.ToString + vbCrLf
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Buffer = StrToByteArray(tgtLine)

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                isoStream2.Write(Buffer, 0, Buffer.Length)
                isoStream2.Close()

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 500: saving data: " + ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Saves the grid col display order.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="DICT">The dictionary.</param>
    Public Sub SaveGridColDisplayOrder(ByVal ScreenName As String, ByVal GridName As String, ByVal UID As String, ByVal DICT As Dictionary(Of Integer, String))

        Dim FormDataFileName As String = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = ""
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                Dim StringOfData As String = ""

                For Each tKey As String In DICT.Keys
                    Dim tValue As String = DICT.Item(tKey)
                    tgtLine = tKey + ChrW(254) + tValue + ChrW(253)
                    StringOfData += tgtLine
                Next

                Buffer = StrToByteArray(StringOfData)
                isoStream2.Write(Buffer, 0, Buffer.Length)

                isoStream2.Close()

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 600: saving Data:   " + ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Reads the grid col display order.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="DICT">The dictionary.</param>
    Public Sub ReadGridColDisplayOrder(ByVal ScreenName As String, ByVal GridName As String, ByVal UID As String, ByRef DICT As Dictionary(Of Integer, String))

        Dim FormDataFileName As String = ScreenName + "." + GridName + ".ColDisplayOrder" + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        If Not isoStore.FileExists(FQN) Then
            Return
        End If

        'Dim p = New IsolatedStorageFileStream(FQN,System.IO.FileMode.Open,System.IO.FileAccess.Read, isoStore)
        Dim p As New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore)

        DICT.Clear()

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            If isoStore.FileExists(filePath) Then
                Console.WriteLine("File Exists " + filePath)
            End If
            'Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
            Using sr As StreamReader = New StreamReader(p)
                Dim AllData As String = ""
                Dim lineData As String = sr.ReadLine()
                While lineData IsNot Nothing
                    Dim A() As String = lineData.Split(ChrW(253))
                    For II As Integer = 0 To A.Length - 1
                        Dim tempLine As String = A(II)
                        Dim bArray() As String = tempLine.Split(ChrW(254))
                        If bArray(0).Length > 0 Then
                            Dim ColumnDisplayOrder As String = bArray(0)
                            Dim ColumnName As String = bArray(1)
                            If DICT.ContainsKey(ColumnDisplayOrder) Then
                            Else
                                DICT.Add(ColumnDisplayOrder, ColumnName)
                            End If
                        End If
                    Next
                    lineData = sr.ReadLine()
                End While
                sr.Close()
            End Using
        End Using

    End Sub

    ''' <summary>
    ''' Saves the user data.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    Public Sub SaveUserData(ByVal UID As String)

        'Dim dirFormData As String = "EcmTemp"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, "UINFO.dat")
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim Buffer() As Byte
        Dim tgtLine As String = UID
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                Buffer = StrToByteArray(tgtLine)

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore)
                isoStream2.Write(Buffer, 0, Buffer.Length)
                isoStream2.Close()

            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 700: saving data: " + ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Reads the user data.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function ReadUserData() As String
        'Dim dirFormData As String = "EcmTemp"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, "UINFO.dat")
        fixFqn(FQN)

        Dim ValName As String = ""
        Dim tgtVal As String = ""

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        'Dim p = New IsolatedStorageFileStream(FQN,System.IO.FileMode.Open,System.IO.FileAccess.Read, isoStore)

        Using isoStore
            If isoStore.FileExists(FQN) Then
                Using sr As StreamReader = New StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read))
                    tgtVal = sr.ReadLine()
                    sr.Close()
                End Using
            End If

        End Using

        Return tgtVal

    End Function

    ''' <summary>
    ''' Deleteds the user data.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function DeletedUserData() As String
        'Dim dirFormData As String = "EcmTemp"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, "UINFO.dat")
        fixFqn(FQN)

        Dim ValName As String = ""
        Dim tgtVal As String = ""

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)

        Using isoStore
            If isoStore.FileExists(FQN) Then
                isoStore.DeleteFile(FQN)
            End If

        End Using

        Return tgtVal

    End Function


    ''' <summary>
    ''' Writes the line to file.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="Msg">The MSG.</param>
    Private Sub WriteLineToFile(ByVal FileName As String, ByVal Msg As String)
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Try
            Dim writer As New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
            ' Have the writer write MSG to the Directory.
            writer.WriteLine(Msg)
            writer.Close()
            writer = Nothing
        Catch ex As Exception
            MessageBox.Show("ERROR: WriteLineToFile - " + ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' Reads from file line by line.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <returns>System.String.</returns>
    Private Function ReadFromFileLineByLine(ByVal FileName As String) As String
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim reader As New StreamReader(New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore))
        ' Read a line from the file and add it to sb.
        Dim sb As String
        sb = reader.ReadLine
        Do Until reader.EndOfStream

            sb = reader.ReadLine
        Loop
        reader.Close()
        reader = Nothing
        Return sb
    End Function

    ''' <summary>
    ''' Saves the grid setup.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DG">The dg.</param>
    ''' <param name="DICT">The dictionary.</param>
    Private Sub SaveGridSetup(ByVal ScreenName As String, ByVal UserID As String, ByVal DG As DataGrid, ByVal DICT As Dictionary(Of Integer, String))
        DICT.Clear()

        Dim ColName As String = ""
        Dim FileName As String = ScreenName + ".Grid." + DG.Name + "." + UserID + ".dat"
        Dim Msg As String = ""
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        'Dim W As GridLength
        'Dim V As Boolean = True
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Try
            Dim writer As New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
            ' Have the writer write MSG to the Directory.
            For I As Integer = 0 To DG.Columns.Count - 1
                ColName = DG.Columns(I).Header
                'W = DG.Columns(I).Width
                'V = DG.Columns(I).Visible
                If DICT.ContainsKey(I) Then
                    DICT.Item(I) = ColName
                Else
                    DICT.Add(I, ColName)
                End If
            Next
            writer.WriteLine(Msg)
            writer.Close()
            writer = Nothing
        Catch ex As Exception
            MessageBox.Show("ERROR: WriteLineToFile - " + ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' Gets the grid setup.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DG">The dg.</param>
    ''' <param name="DICT">The dictionary.</param>
    Private Sub getGridSetup(ByVal ScreenName As String, ByVal UserID As String, ByVal DG As DataGrid, ByVal DICT As Dictionary(Of Integer, String))

        DICT.Clear()

        Dim A() As String
        Dim FileName As String = ScreenName + ".Grid." + DG.Name + "." + UserID + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim reader As New StreamReader(New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore))
        ' Read a line from the file and add it to sb.
        Dim sb As String
        sb = reader.ReadLine
        Do Until reader.EndOfStream
            A = sb.Split(ChrW(254))
            Dim I As Integer = CInt(A(0))
            Dim tCol As String = A(1)
            If DICT.ContainsKey(I) Then
                DICT.Item(I) = tCol
            Else
                DICT.Add(I, tCol)
            End If
            sb = reader.ReadLine
        Loop
        reader.Close()
        reader = Nothing

    End Sub


    ''' <summary>
    ''' Saves the screen setup.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DICT">The dictionary.</param>
    Private Sub SaveScreenSetup(ByVal ScreenName As String, ByVal UserID As String, ByVal DICT As Dictionary(Of Integer, String))
        DICT.Clear()

        Dim tName As String = ""
        Dim tVal As String = ""
        Dim FileName As String = ScreenName + ".Screen." + UserID + ".dat"
        Dim Msg As String = ""
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        'Dim W As GridLength
        Dim V As Boolean = True
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Try
            Dim writer As New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
            ' Have the writer write MSG to the Directory.
            For Each S As String In DICT.Keys
                tName = S
                tVal = DICT.Item(S)
                writer.WriteLine(S + ChrW(254) + tVal)
            Next
            writer.Close()
            writer = Nothing
        Catch ex As Exception
            MessageBox.Show("ERROR: WriteLineToFile - " + ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' Gets the screen setup.
    ''' </summary>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DICT">The dictionary.</param>
    Private Sub getScreenSetup(ByVal ScreenName As String, ByVal UserID As String, ByVal DICT As Dictionary(Of Integer, String))

        DICT.Clear()

        Dim A() As String
        Dim FileName As String = ScreenName + ".Screen." + UserID + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirSaveData, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim reader As New StreamReader(New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore))
        ' Read a line from the file and add it to sb.
        Dim sb As String
        sb = reader.ReadLine
        Do Until reader.EndOfStream
            A = sb.Split(ChrW(254))
            Dim I As Integer = CInt(A(0))
            Dim tCol As String = A(1)
            If DICT.ContainsKey(I) Then
                DICT.Item(I) = tCol
            Else
                DICT.Add(I, tCol)
            End If
            sb = reader.ReadLine
        Loop
        reader.Close()
        reader = Nothing

    End Sub

    ''' <summary>
    ''' Saves the file restore data.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="listOfGuids">The list of guids.</param>
    Public Sub SaveFileRestoreData(ByVal UID As String, ByVal listOfGuids As List(Of String))

        Dim RecodsAdded As Integer = 0
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim MO As String = Now.Month.ToString
        Dim DA As String = Now.Day.ToString
        Dim YR As String = Now.Year.ToString
        Dim MN As String = Now.Minute.ToString
        Dim MS As String = Now.Millisecond.ToString

        Dim FormDataFileName As String = "ECM." + YR + "." + MO + "." + DA + "." + MN + "." + MS + FileRestore
        Dim FQN As String = System.IO.Path.Combine(dirRestore, FormDataFileName)
        fixFqn(FQN)

        For Each S As String In listOfGuids
            Try
                RecodsAdded += 1
                ' Declare a new StreamWriter.
                Dim writer As StreamWriter = Nothing
                ' Assign the writer to the store and the file TestStore.
                If RecodsAdded = 1 Then
                    writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
                Else
                    writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
                End If

                writer.WriteLine(S)
                writer.Close()
                writer.Dispose()
                writer = Nothing
            Catch ex As IsolatedStorageException
                MessageBox.Show("Error SaveFormData 800: saving data: " + ex.Message)
            End Try
        Next

        isoStore.Dispose()

    End Sub
    ''' <summary>
    ''' Initializes the file restore data.
    ''' </summary>
    Public Sub initFileRestoreData()

        Dim RecodsAdded As Integer = 0
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim MO As String = Now.Month.ToString
        Dim DA As String = Now.Day.ToString
        Dim YR As String = Now.Year.ToString
        Dim MN As String = Now.Minute.ToString
        Dim MS As String = Now.Millisecond.ToString

        Dim FileName As String = dirRestore + "." + "ECM.FileRestore.CURR"
        Dim s As String = Now.ToString
        Try
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))
            stmWriter.Write(s)

            stmWriter.Close()
            isoStorage.Close()
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 800: saving data: " + ex.Message)
        End Try


    End Sub
    ''' <summary>
    ''' Initializes the file preview data.
    ''' </summary>
    Public Sub initFilePreviewData()

        Dim RecodsAdded As Integer = 0
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim MO As String = Now.Month.ToString
        Dim DA As String = Now.Day.ToString
        Dim YR As String = Now.Year.ToString
        Dim MN As String = Now.Minute.ToString
        Dim MS As String = Now.Millisecond.ToString

        Dim FileName As String = dirPreview + "." + "ECM.Preview.CURR"
        Dim s As String = Now.ToString
        Try
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))
            stmWriter.Write(s)

            stmWriter.Close()
            isoStorage.Close()
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 800: saving data: " + ex.Message)
        End Try

    End Sub
    ''' <summary>
    ''' Reads the file restore data.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="L">The l.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ReadFileRestoreData(ByVal UID As String, ByRef L As List(Of String)) As Boolean

        Dim B As Boolean = True
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim FormDataFileName As String = "Restore.dat"
        Dim FQN As String = System.IO.Path.Combine(dirRestore, FormDataFileName)
        fixFqn(FQN)

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Dim FileToRestore As String = ""
                Try
                    FileToRestore = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                Dim II As Integer = 0
                Do While Not sr.EndOfStream
                    II += 1
                    If II > 100 Then
                        Exit Do
                    End If
                    If FileToRestore.Trim.Length > 0 Then
                        Dim A() As String = FileToRestore.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        If L.Contains(FileToRestore) Then
                        Else
                            L.Add(FileToRestore)
                        End If
                        FileToRestore = sr.ReadLine()
                    End If
                Loop
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return B
    End Function

    ''' <summary>
    ''' Saves the file preview unique identifier.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="tgtTable">The TGT table.</param>
    ''' <param name="tgtGuid">The TGT unique identifier.</param>
    ''' <param name="StoredFQN">The stored FQN.</param>
    Public Sub SaveFilePreviewGuid(ByVal UID As String, ByVal tgtTable As String, ByVal tgtGuid As String, ByVal StoredFQN As String)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim MO As Integer = Today.Month.ToString
        Dim DA As Integer = Today.Day.ToString

        Dim FormDataFileName As String = filePreview
        Dim FQN As String = System.IO.Path.Combine(dirPreview, FormDataFileName)
        fixFqn(FQN)

        Try
            Dim S As String = tgtTable + ChrW(254) + tgtGuid + ChrW(254) + StoredFQN
            ' Declare a new StreamWriter.
            Dim writer As StreamWriter = Nothing
            ' Assign the writer to the store and the file TestStore.
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
            writer.WriteLine(S)
            writer.Close()
            writer.Dispose()
            writer = Nothing
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 900: saving data: " + ex.Message)
        End Try

        isoStore.Dispose()

    End Sub

    ''' <summary>
    ''' Reads the file preview data.
    ''' </summary>
    ''' <param name="tgtGuid">The TGT unique identifier.</param>
    ''' <param name="StoredFQN">The stored FQN.</param>
    ''' <returns>System.String.</returns>
    Public Function ReadFilePreviewData(ByVal tgtGuid As String, ByVal StoredFQN As String) As String

        Dim GuidToDownLoad As String = ""
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim MO As Integer = Today.Month.ToString
        Dim DA As Integer = Today.Day.ToString

        Dim FormDataFileName As String = filePreview
        Dim FQN As String = System.IO.Path.Combine(dirPreview, FormDataFileName)
        fixFqn(FQN)

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Try
                    GuidToDownLoad = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return GuidToDownLoad
    End Function

    ''' <summary>
    ''' Gets the search filters.
    ''' </summary>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="SearchDICT">The search dictionary.</param>
    Public Sub getSearchFilters(ByVal SearchName As String, ByVal UserID As String, ByVal SearchDICT As Dictionary(Of String, String))

        SearchDICT.Clear()

        Dim A() As String
        Dim FileName As String = SearchName + ".Search." + UserID + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirSearchFilter, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        If Not isoStore.FileExists(FQN) Then
            Return
        End If

        Dim reader As New StreamReader(New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore))
        Dim sb As String
        sb = reader.ReadLine
        Do Until reader.EndOfStream
            A = sb.Split(ChrW(254))
            For X As Integer = 0 To UBound(A)
                Dim TempStr As String = A(X)
                Dim A1() As String = TempStr.Split(ChrW(254))
                Dim ParmName As String = A1(0)
                Dim ParmVal As String = A1(1)
                If SearchDICT.ContainsKey(ParmName) Then
                    SearchDICT.Item(ParmName) = ParmVal
                Else
                    SearchDICT.Add(ParmName, ParmVal)
                End If
            Next
            sb = reader.ReadLine
        Loop
        reader.Close()
        reader = Nothing

    End Sub

    ''' <summary>
    ''' Saves the search filters.
    ''' </summary>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="SearchDICT">The search dictionary.</param>
    Public Sub saveSearchFilters(ByVal SearchName As String, ByVal UID As String, ByVal SearchDICT As Dictionary(Of String, String))

        SearchDICT.Clear()
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim FileName As String = SearchName + ".Search." + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirSearchFilter, FileName)
        fixFqn(FQN)

        Dim writer As StreamWriter = Nothing
        ' Assign the writer to the store and the file TestStore.
        writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))

        For Each S As String In SearchDICT.Keys

            Dim ValName As String = ""
            Dim ValValue As String = ""
            ValName = S
            ValValue = SearchDICT.Item(S)
            Dim tgtLine As String = ValName + ChrW(254) + ValValue
            Try
                writer.WriteLine(tgtLine)
            Catch ex As IsolatedStorageException
                MessageBox.Show("Error SaveSearchParms 200: saving data: " + ex.Message)
            End Try

            writer.Close()
            writer.Dispose()

        Next
        isoStore.Dispose()
    End Sub
    ''' <summary>
    ''' Sets the CLC statex.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="currState">State of the curr.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    Sub SetCLC_Statex(ByVal UID As String, ByVal currState As String, ByVal CompanyID As String, ByVal RepoID As String)

        '** NO NO NO
        currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Dim writer As StreamWriter = Nothing
        writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
        Try
            writer.WriteLine(currState)
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SetCLC_Active 200: saving data: " + ex.Message)
        End Try

        writer.Close()
        writer.Dispose()
        isoStore.Dispose()
    End Sub
    ''' <summary>
    ''' Sets the CLC state2.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="currState">State of the curr.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    ''' <returns>System.String.</returns>
    Function SetCLC_State2(ByVal UID As String, ByVal currState As String, ByVal CompanyID As String, ByVal RepoID As String) As String

        Dim EP As String = GatewayEndPoint + vbCrLf + DownloadEndPoint

        Try
            currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper + "|" + _SecureID.ToString + "|" + GatewayEndPoint + "|" + gENCGWCS + "|" + DownloadEndPoint + "|" + DateTime.Now.ToString

            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain

            Dim FileName As String = dirCLC + "." + "SAAS.RUNNING"
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))

            stmWriter.Write(currState)
            stmWriter.Close()
            isoStorage.Close()
        Catch ex As Exception
            MessageBox.Show("Error SaveFormData 700B: SetCLC_State2 Data:   " + ex.Message)
        End Try


        'If isoStorage.FileExists(FQN) Then
        '    Try
        '        isoStorage.DeleteFile(FQN)
        '    Catch ex As Exception
        '        Console.WriteLine("Failed to delete ISO Store")
        '    End Try

        '    Dim ofile As StreamWriter = Nothing
        '    Try
        '        ofile = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
        '        ofile.WriteLine(currState)
        '    Catch ex As IsolatedStorageException
        '        MessageBox.Show("Error SetCLC_Active 201: saving data: " + ex.Message)
        '    Finally
        '        If ofile Is Nothing Then
        '            Console.WriteLine("Ofile is nothing")
        '        Else
        '            ofile.Close()
        '            ofile.Dispose()
        '        End If
        '    End Try


        '    isoStore.Dispose()
        '    GC.Collect()
        '    GC.WaitForPendingFinalizers()
        '    Return EP
        'End If

        'Dim writer As StreamWriter = Nothing
        'Try
        '    writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
        '    writer.WriteLine(currState)
        'Catch ex As IsolatedStorageException
        '    MessageBox.Show("Error SetCLC_Active 200: saving data: " + ex.Message)
        'End Try

        'If writer Is Nothing Then
        '    Console.WriteLine("Writer does not exist")
        'Else
        '    writer.Close()
        '    writer.Dispose()
        'End If

        'isoStore.Dispose()

        GC.Collect()
        GC.WaitForPendingFinalizers()
        Return EP
    End Function

    ''' <summary>
    ''' Determines whether [is CLC active] [the specified uid].
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <returns><c>true</c> if [is CLC active] [the specified uid]; otherwise, <c>false</c>.</returns>
    Function isClcActive(ByVal UID As String) As Boolean

        'C:\Users\wmiller\AppData\LocalLow\Microsoft\Silverlight\is\42fotd3y.o1g\h3lraamt.gka\1\s\1slx5pjb0uazhq0mvvi1zkh5pl5te3cec1zm1hrdv0jeguazg2aaaaga\f

        Dim FileName As String = "CLC.RUNNING"
        Dim B As Boolean = False
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        Dim bFileExists As Boolean = False
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        'YES YES
        If Not isoStore.DirectoryExists(dirCLC) Then
            isoStore.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
            Return False
        Else
            Dim EP As String = SetCLC_State2(UID, "SEARCH READY", _CompanyID, _RepoID)

        End If

        For Each sFile As String In isoStore.GetFileNames(dirCLC + "\*.*")
            Console.WriteLine(sFile)
            If sFile.ToUpper.Equals("CLC.RUNNING") Then
                bFileExists = True
                B = True
            End If
        Next

        If Not bFileExists Then
            B = False
        End If

        isoStore.Dispose()
        Return B
    End Function

    ''' <summary>
    ''' Determines whether [is CLC installed].
    ''' </summary>
    ''' <returns><c>true</c> if [is CLC installed]; otherwise, <c>false</c>.</returns>
    Function isClcInstalled() As Boolean
        Dim B As Boolean = False
        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        If Not isoStore.FileExists(FQN) Then
            B = False
        Else
            B = True
        End If

        isoStore.Dispose()
        Return B
    End Function

    ''' <summary>
    ''' Gets the iso dir path.
    ''' </summary>
    ''' <param name="TgtDir">The TGT dir.</param>
    ''' <returns>System.String.</returns>
    Function getIsoDirPath(ByVal TgtDir As String) As String

        Dim B As Boolean = False
        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, "*.*")
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Dim tDir As String = ""
        For Each S As String In isoStore.GetDirectoryNames
            tDir += S + vbCrLf
        Next
        MessageBox.Show(tDir)
        isoStore.Dispose()
        Return B
    End Function
    ''' <summary>
    ''' Deletes the iso dir.
    ''' </summary>
    ''' <param name="TgtDir">The TGT dir.</param>
    ''' <returns>System.String.</returns>
    Function deleteIsoDir(ByVal TgtDir As String) As String

        Dim B As Boolean = False
        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, "*.*")
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile

        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        If isoStore.DirectoryExists(TgtDir) Then
            isoStore.DeleteDirectory(TgtDir)
        End If
        isoStore.Dispose()
        Return B
    End Function

    ''' <summary>
    ''' Saves the name of the search by.
    ''' </summary>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="DICT">The dictionary.</param>
    Public Sub SaveSearchByName(ByVal SearchName As String, ByRef DICT As Dictionary(Of String, String))

        Dim ErrorShown As Boolean = False
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            Dim FormDataFileName As String = "SEARCH." + SearchName + ".dat"
            Dim FQN As String = System.IO.Path.Combine(dirSearchSave, FormDataFileName)
            fixFqn(FQN)

            Dim writer As StreamWriter = Nothing
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))

            For Each sKey As String In DICT.Keys
                Dim tVal As String = DICT.Item(sKey)
                Dim tLine As String = sKey + ChrW(254) + tVal
                writer.WriteLine(tLine)
            Next

            writer.Close()
            writer.Dispose()
            writer = Nothing

        Catch ex As Exception
            If Not ErrorShown Then
                MessageBox.Show("ERROR: SaveSearchByName 100 - " + ex.Message)
                ErrorShown = True
            End If
        Finally
            isoStore.Dispose()
        End Try
    End Sub

    ''' <summary>
    ''' Reads the name of the search data by.
    ''' </summary>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ReadSearchDataByName(ByVal SearchName As String, ByRef DICT As Dictionary(Of String, String)) As Boolean

        DICT.Clear()

        Dim isoStore As IsolatedStorageFile

        Dim B As Boolean = True
        Dim FormDataFileName As String = "SEARCH." + SearchName + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
        fixFqn(FQN)

        Dim tgtVal As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)
        'ReadFile = New Byte(1023) {}
        'p.Read(Buffer, 0, ReadFile.Length)
        'p.Close()
        'Return ReadFile

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Dim formData As String = ""
                Try
                    formData = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                Dim II As Integer = 0
                Do While Not sr.EndOfStream
                    II += 1
                    If II > 100 Then
                        Exit Do
                    End If
                    If formData.Trim.Length > 0 Then
                        Dim A() As String = formData.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        If DICT.ContainsKey(tKey) Then
                            DICT.Item(tKey) = tValue
                        Else
                            DICT.Add(tKey, tValue)
                        End If
                        formData = sr.ReadLine()
                    End If
                Loop
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return B

    End Function

    ''' <summary>
    ''' Saves the detail search parms.
    ''' </summary>
    ''' <param name="DetailType">Type of the detail.</param>
    ''' <param name="DICT">The dictionary.</param>
    Public Sub SaveDetailSearchParms(ByVal DetailType As String, ByRef DICT As Dictionary(Of String, String))

        If Not DetailType.Equals("EMAIL") And Not DetailType.Equals("CONTENT") Then
            MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.")
            Return
        End If

        Dim ErrorShown As Boolean = False
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            Dim FormDataFileName As String = "SEARCH." + DetailType + ".dat"
            Dim FQN As String = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName)
            fixFqn(FQN)


            Dim writer As StreamWriter = Nothing
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))

            For Each sKey As String In DICT.Keys
                Dim tVal As String = DICT.Item(sKey)
                Dim tLine As String = sKey + ChrW(254) + tVal
                writer.WriteLine(tLine)
            Next

            writer.Close()
            writer.Dispose()
            writer = Nothing

        Catch ex As Exception
            If Not ErrorShown Then
                MessageBox.Show("ERROR: SaveSearchByName 100 - " + ex.Message)
                ErrorShown = True
            End If
        Finally
            isoStore.Dispose()
        End Try
    End Sub

    ''' <summary>
    ''' Reads the detail search parms.
    ''' </summary>
    ''' <param name="DetailType">Type of the detail.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ReadDetailSearchParms(ByVal DetailType As String, ByRef DICT As Dictionary(Of String, String)) As Boolean

        If Not DetailType.Equals("EMAIL") And Not DetailType.Equals("CONTENT") Then
            MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.")
            Return False
        End If

        DICT.Clear()

        Dim isoStore As IsolatedStorageFile

        Dim B As Boolean = True
        Dim FormDataFileName As String = "SEARCH." + DetailType + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName)
        fixFqn(FQN)

        Dim tgtVal As String = ""

        Dim Msg As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        If Not isoStore.FileExists(FQN) Then
            Return True
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, System.IO.FileMode.Open, System.IO.FileAccess.Read, isoStore)
        'ReadFile = New Byte(1023) {}
        'p.Read(Buffer, 0, ReadFile.Length)
        'p.Close()
        'Return ReadFile

        Using isoStore
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read))
                Dim formData As String = ""
                Try
                    formData = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                Dim II As Integer = 0
                Do While Not sr.EndOfStream
                    II += 1
                    If II > 100 Then
                        Exit Do
                    End If
                    If formData.Trim.Length > 0 Then
                        Dim A() As String = formData.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        Msg += tKey + ChrW(9) + tValue + vbCrLf
                        If DICT.ContainsKey(tKey) Then
                            DICT.Item(tKey) = tValue
                        Else
                            DICT.Add(tKey, tValue)
                        End If
                        formData = sr.ReadLine()
                    End If
                Loop
                sr.Close()
                sr.Dispose()
            End Using
        End Using

        isoStore.Dispose()
        Return B

    End Function

    ''' <summary>
    ''' Deletes the detail search parms.
    ''' </summary>
    ''' <param name="DetailType">Type of the detail.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DeleteDetailSearchParms(ByVal DetailType As String) As Boolean

        If Not DetailType.Equals("EMAIL") And Not DetailType.Equals("CONTENT") Then
            MessageBox.Show("ERROR SaveDetailSearchParms - the Detail Type Code must be EMAIL or CONTENT - returning.")
            Return False
        End If

        Dim isoStore As IsolatedStorageFile

        Dim B As Boolean = True
        Dim FormDataFileName As String = "SEARCH." + DetailType + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirDetailSearchParms, FormDataFileName)
        fixFqn(FQN)

        Dim tgtVal As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            If isoStore.FileExists(FQN) Then
                isoStore.DeleteFile(FQN)
            End If
            B = True
        Catch ex As Exception
            B = False
        End Try

        isoStore.Dispose()
        Return B

    End Function
    ''' <summary>
    ''' Deletes the CLC ready status.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DeleteClcReadyStatus() As Boolean

        Dim isoStore As IsolatedStorageFile
        Dim B As Boolean = True
        Dim FileName As String = "SAAS.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Dim tgtVal As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        Try
            If isoStore.FileExists(FQN) Then
                isoStore.DeleteFile(FQN)
            End If
            B = True
        Catch ex As Exception
            B = False
        End Try

        isoStore.Dispose()

        'B = DeleteSearchRunning()

        Return B

    End Function

    ''' <summary>
    ''' Deletes the search running.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DeleteSearchRunning() As Boolean

        Dim isoStore As IsolatedStorageFile
        Dim B As Boolean = True
        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Dim tgtVal As String = ""

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            If isoStore.FileExists(FQN) Then
                isoStore.DeleteFile(FQN)
            End If
            B = True
        Catch ex As Exception
            B = False
        End Try

        isoStore.Dispose()
        Return B

    End Function

    ''' <summary>
    ''' Zeroizes the temporary file.
    ''' </summary>
    ''' <param name="FileNameOnly">The file name only.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ZeroizeTempFile(ByVal FileNameOnly As String) As Boolean

        Dim isoStore As IsolatedStorageFile
        Dim B As Boolean = True
        Dim FileName As String = FileNameOnly
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)


        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            If isoStore.FileExists(FQN) Then
                isoStore.DeleteFile(FQN)
            End If
            B = True
        Catch ex As Exception

        End Try
        Return B
    End Function
    ''' <summary>
    ''' Appends the temporary file.
    ''' </summary>
    ''' <param name="FileNameOnly">The file name only.</param>
    ''' <param name="tgtLine">The TGT line.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function AppendTempFile(ByVal FileNameOnly As String, ByVal tgtLine As String) As Boolean

        Dim isoStore As IsolatedStorageFile
        Dim B As Boolean = True
        Dim FileName As String = FileNameOnly
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Try
            Dim writer As StreamWriter = Nothing
            ' Assign the writer to the store and the file TestStore.
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Append, isoStore))
            writer.WriteLine(tgtLine)
            writer.Close()
            writer.Dispose()
            writer = Nothing
            B = True
        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function

    ''' <summary>
    ''' Persists the data initialize.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tData">The t data.</param>
    Public Sub PersistDataInit(ByVal tKey As String, ByVal tData As String)

        Try
            Dim tgtLine As String = tKey + "|" + tData + vbCrLf
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream("Persist.dat", FileMode.Create, isoStorage))
            stmWriter.Write(tgtLine)

            stmWriter.Close()
            isoStorage.Close()
        Catch ex As Exception
            MessageBox.Show("Error SaveFormData 700: saving Data:   " + ex.Message)
        End Try

    End Sub
    ''' <summary>
    ''' Persists the data save.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tData">The t data.</param>
    Public Sub PersistDataSave(ByVal tKey As String, ByVal tData As String)

        Try
            Dim tgtLine As String = tKey + "|" + tData + vbCrLf
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream("Persist.dat", FileMode.Append, isoStorage))
            stmWriter.Write(tgtLine)

            stmWriter.Close()
            isoStorage.Close()
        Catch ex As Exception
            MessageBox.Show("Error SaveFormData 700A: saving Data:   " + ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' Persists the data read.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <returns>System.String.</returns>
    Public Function PersistDataRead(ByVal tKey As String) As String

        Dim FQN As String = System.IO.Path.Combine(dirPersist, "Persist.dat")
        fixFqn(FQN)

        Dim ValName As String = ""
        Dim tgtVal As String = ""
        Dim RetVal As String = ""
        Dim isoStorage As IsolatedStorageFile

        Try
            'Dim tgtLine As String = tKey + "|" + tData + vbCrLf

            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim sr As StreamReader = New StreamReader(isoStorage.OpenFile("Persist.dat", FileMode.Open, FileAccess.Read))
            RetVal = ""
            tgtVal = sr.ReadLine()
            Do While Not sr.EndOfStream
                Dim A() As String = tgtVal.Split("|")
                If A(0).Equals(tKey) Then
                    RetVal = A(1)
                    Exit Do
                End If
                tgtVal = sr.ReadLine()
            Loop
            sr.Close()
            isoStorage.Close()
        Catch ex As Exception
            MessageBox.Show("Error SaveFormData 700A1: saving Data:   " + ex.Message)
        End Try

        'Try
        '    isoStore = IsolatedStorageFile.GetUserStoreForDomain
        '    'isoStore = IsolatedStorageFile.GetUserStoreForDomain
        '    Using isoStore
        '        If isoStore.FileExists(FQN) Then
        '            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(FQN, FileMode.Open, FileAccess.Read))
        '                RetVal = ""
        '                tgtVal = sr.ReadLine()
        '                Do While Not sr.EndOfStream
        '                    Dim A() As String = tgtVal.Split("|")
        '                    If A(0).Equals(tKey) Then
        '                        RetVal = A(1)
        '                        Exit Do
        '                    End If
        '                    tgtVal = sr.ReadLine()
        '                Loop
        '                sr.Close()
        '            End Using
        '        End If

        '    End Using
        'Catch ex As Exception
        '    MessageBox.Show("ERROR 6221: " + ex.Message)
        'End Try


        Return RetVal

    End Function

    ''' <summary>
    ''' Previews the file initialize.
    ''' </summary>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    ''' <param name="UnencryptedCS">The unencrypted cs.</param>
    Public Sub PreviewFileInit(ByVal CompanyID As String, ByVal RepoID As String, ByVal UnencryptedCS As String)

        Dim FileName As String = dirCLC + "." + "EcmActiveInstance.DAT"
        Dim S As String = CompanyID + "|" + RepoID + "|" + UnencryptedCS

        Try
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))
            stmWriter.Write(S)
            stmWriter.Close()
            isoStorage.Close()
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error initPreviewFIle 900: saving data: " + ex.Message)
        End Try


    End Sub
    ''' <summary>
    ''' Previews the file zeroize.
    ''' </summary>
    Public Sub PreviewFileZeroize()


        Dim FileName As String = dirCLC + "." + "EcmActiveInstance.DAT"
        Dim S As String = "X"

        Try
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))
            stmWriter.Write(S)
            stmWriter.Close()
            isoStorage.Close()
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error initPreviewFIle 900: saving data: " + ex.Message)
        End Try



    End Sub

    ''' <summary>
    ''' Sets the state of the saas.
    ''' </summary>
    ''' <param name="UID">The uid.</param>
    ''' <param name="currState">State of the curr.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    ''' <returns>System.String.</returns>
    Function SetSAAS_State(ByVal UID As String, ByVal currState As String, ByVal CompanyID As String, ByVal RepoID As String) As String

        Dim EP As String = GatewayEndPoint + vbCrLf + DownloadEndPoint
        currState = currState.ToUpper

        If currState.Equals("ACTIVE") Or currState.Equals("INACTIVE") Then
        Else
            MessageBox.Show("The state parameter must be ACTIVE or INACTIVE only - error, returning.")
            Return EP
        End If

        currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper + "|" + _SecureID.ToString + "|" + GatewayEndPoint + "|" + gENCGWCS + "|" + DownloadEndPoint + "|" + DateTime.Now.ToString

        'Dim isoStore As IsolatedStorageFile
        'isoStore = IsolatedStorageFile.GetUserStoreForDomain

        Dim FileName As String = dirCLC + ".SAAS.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, FileName)
        fixFqn(FQN)

        Try
            Dim isoStorage As IsolatedStorageFile
            isoStorage = IsolatedStorageFile.GetUserStoreForDomain
            Dim stmWriter As New StreamWriter(New IsolatedStorageFileStream(FileName, FileMode.Create, isoStorage))
            stmWriter.Write(currState)

            stmWriter.Close()
            isoStorage.Close()
        Catch ex As Exception
            MessageBox.Show("Error SetSAAS_State 200: saving data: " + ex.Message)
            Console.WriteLine("Error SetSAAS_State 200: saving data: " + ex.Message)
        End Try

        Return EP
    End Function

    ''' <summary>
    ''' Reads the PDF to stream.
    ''' </summary>
    ''' <param name="ReportName">Name of the report.</param>
    ''' <returns>Stream.</returns>
    Public Function ReadPdfToStream(ByVal ReportName As String) As Stream

        Dim b As Boolean = True
        Dim FormDataDirectory As String = "Reports"
        Dim FileName As String = FormDataDirectory + "." + ReportName + ".PDF"

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        'Dim Buffer() As Byte
        Try
            Using isoStore
                Dim TotalFields As Integer = 4

                Dim isoStream2 As New IsolatedStorageFileStream(FileName, FileMode.Open, isoStore)

                Return isoStream2
            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 100: saving Data:   " + ex.Message)
            b = False
        End Try

        Return Nothing

    End Function

    ''' <summary>
    ''' Reads the HTML to stream.
    ''' </summary>
    ''' <param name="ReportName">Name of the report.</param>
    ''' <returns>Stream.</returns>
    Public Function ReadHtmlToStream(ByVal ReportName As String) As Stream

        Dim b As Boolean = True
        Dim FormDataDirectory As String = "Reports"
        Dim FormDataFileName As String = ReportName
        Dim FQN As String = System.IO.Path.Combine(FormDataDirectory, FormDataFileName)
        fixFqn(FQN)

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForDomain
        'Dim Buffer() As Byte
        Try
            Using store = IsolatedStorageFile.GetUserStoreForDomain()
                Dim TotalFields As Integer = 4

                'Buffer = StrToByteArray(fileStream)

                Dim isoStream2 As New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore)

                'isoStream2.re()
                'isoStream2.Close()
                Return isoStream2
            End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 100: saving data: " + ex.Message)
            b = False
        End Try

        Return Nothing

    End Function

    ''' <summary>
    ''' Requests the more iso.
    ''' </summary>
    Public Sub RequestMoreIso()
        Try
            Using isof As IsolatedStorageFile = IsolatedStorageFile.GetUserStoreForDomain()
                Dim freeSpace As Int64 = isof.AvailableFreeSpace
                Dim needSpace As Int64 = 20971520
                ' 20 MB in bytes
                If freeSpace < needSpace Then
                    If Not isof.IncreaseQuotaTo(isof.Quota + needSpace) Then
                        MessageBox.Show("User rejected increase space request")
                    Else
                        MessageBox.Show("Space Increased")
                    End If
                End If
            End Using
        Catch ex As Exception
            MessageBox.Show("Request for more storage failed: " + ex.Message)
        End Try
    End Sub

    'Function readIsoFile(ByVal Filename As String) As String
    '    Dim InputText As String = ""
    '    Try
    '        Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
    '        Dim isolatedStream As New IsolatedStorageFileStream(Filename, FileMode.Open, isolatedStore)
    '        Using reader As New StreamReader(isolatedStream)
    '            InputText = reader.ReadToEnd
    '        End Using
    '    Catch ex As Exception
    '        If Not gRunUnattended Then
    '            MessageBox.Show("Notice: Failed to READ data from isolated storage #122." + ex.Message)
    '        End If
    '    End Try

    '    Return InputText
    'End Function
    'Public Sub saveIsoFile(ByVal FileName As String, ByVal sLine As String)
    '    Try
    '        Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
    '        Dim isoStream As New IsolatedStorageFileStream(FileName, FileMode.Append, FileAccess.Write, isolatedStore)

    '        Using writer As New StreamWriter(isoStream)
    '            writer.WriteLine(sLine)
    '        End Using
    '    Catch ex As Exception
    '        If Not gRunUnattended Then
    '            MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message)
    '        End If
    '    End Try
    'End Sub
End Class



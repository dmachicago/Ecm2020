Imports System.Data.SQLite

Public Class clsSqliteDB

    Public FQNDb As String = ""
    Dim CS As String = ""

    Public Function create_sqlite_database(DBFqn As String) As Boolean
        Dim b As Boolean = True
        If Not My.Computer.FileSystem.FileExists(DBFqn) Then
            Try
                ' Create the SQLite database
                SQLiteConnection.CreateFile(DBFqn)

                MessageBox.Show("Database Created: " + DBFqn)

            Catch ex As Exception
                b = False
                MessageBox.Show("Database Created Failed: " + DBFqn)
            End Try
        Else
            MessageBox.Show("Database ALREADY EXISTS: " + DBFqn)
            b = False
        End If


        If b Then
            create_ContactsArchive(DBFqn)
            create_Directory(DBFqn)
            create_Inventory(DBFqn)
            create_Exchange(DBFqn)
            create_Files(DBFqn)
            create_Listener(DBFqn)
            create_MultiLocationFiles(DBFqn)
            create_Outlook(DBFqn)
            create_Zipfile(DBFqn)
        End If

    End Function

    Public Sub create_Zipfile(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CCREATE TABLE [ZipFile] (
  [RowNbr] integer primary key autoincrement  
, [DirID] int NULL
, [FileID] int NULL
, [FQN] nvarchar(1000) NOT NULL COLLATE NOCASE UNIQUE
, [EmailAttachment] bit DEFAULT (0) NULL
, [SuccessfullyProcessed] bit DEFAULT (0) NULL
, [fSize] bigint NULL
, [CreateDate] datetime NOT NULL
, [LastAccessDate] datetime NULL
, [NumberOfZipFiles] int NULL
, [ParentGuid] nvarchar(50) NULL COLLATE NOCASE
, [InWork] bit DEFAULT (0) NULL
, [FileHash] nvarchar(512) NULL COLLATE NOCASE
)"

        CreateTable(MySql)

    End Sub


    Public Sub create_Outlook(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Outlook] ( 
  [RowID] integer primary key autoincrement  
, [sKey] nvarchar(500) NOT NULL COLLATE NOCASE UNIQUE
, [KeyExists] bit DEFAULT 1 NULL 
)"

        CreateTable(MySql)

    End Sub

    Public Sub create_MultiLocationFiles(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [MultiLocationFiles] (
  [LocID] integer primary key autoincrement  
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileHash] nvarchar(512) NOT NULL COLLATE NOCASE
)"

        CreateTable(MySql)

    End Sub

    Public Sub create_Listener(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Listener] ( 
  [FQN] nvarchar(2000) NOT NULL 
, [Uploaded] int DEFAULT 0 NOT NULL 
, CONSTRAINT Listener_pk PRIMARY KEY (FQN) 
)"

        CreateTable(MySql)

    End Sub

    Public Sub create_Files(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Files] (
  [FileID] integer primary key autoincrement  
, [FileName] nvarchar(254) NOT NULL COLLATE NOCASE
, [FileHash] nvarchar(512) NULL COLLATE NOCASE
)"

        CreateTable(MySql)

    End Sub


    Public Sub create_Exchange(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Exchange] ( 
  [sKey] nvarchar(200) NOT NULL 
, [RowID] integer primary key autoincrement  
, [KeyExists] bit DEFAULT 1 NULL 
)"

        CreateTable(MySql)

    End Sub

    Public Sub create_Directory(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Directory] (
  [DirName] nvarchar(1000) NOT NULL COLLATE NOCASE UNIQUE
, [DirID] integer primary key autoincrement  
, [UseArchiveBit] bit NOT NULL
, [DirHash] nvarchar(512) NULL COLLATE NOCASE
)"

        CreateTable(MySql)


    End Sub


    Public Sub create_ContactsArchive(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [ContactsArchive] ( 
	[RowID] integer primary key autoincrement  
	, [Email1Address] nvarchar(100) NOT NULL COLLATE NOCASE 
	, [FullName] nvarchar(100) NOT NULL COLLATE NOCASE )"

        CreateTable(MySql)


    End Sub

    Public Sub create_Inventory(DBFqn)
        Dim MySql As String = String.Empty

        MySql = "CREATE TABLE [Inventory] (
  [InvID] integer primary key autoincrement  
, [DirID] int NOT NULL
, [FileID] int NOT NULL
, [FileExist] bit DEFAULT (1) NULL
, [FileSize] bigint NULL
, [CreateDate] datetime NULL
, [LastUpdate] datetime NULL
, [LastArchiveUpdate] datetime NULL
, [ArchiveBit] bit NULL
, [NeedsArchive] bit NULL
, [FileHash] nvarchar(512) NULL COLLATE NOCASE
)"

        CreateTable(MySql)


    End Sub

    Sub CreateTable(SQL As String)
        Try
            Using con As New SQLiteConnection(CS)
                con.Open()
                Using cmd As New SQLiteCommand(SQL, con)
                    cmd.ExecuteNonQuery()
                End Using
            End Using
            MessageBox.Show("Table created successfully")
        Catch ex As Exception
            MessageBox.Show("CLIPBOARD: create table failed:" + vbCrLf + SQL)
            Clipboard.Clear()
            Clipboard.SetText(SQL)
        End Try
    End Sub

End Class


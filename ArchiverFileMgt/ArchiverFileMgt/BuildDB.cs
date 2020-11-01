using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;
using System.IO;

namespace ArchiverFileMgt
{
    public class BuildDB
    {

        public string cs = "";
        public SQLiteConnection conn;
        public string dbpath = "";
        public bool NewDB = false;

        /// <summary>Verifies the database.</summary>
        /// <returns>Connection stirng to the local SQL Lite DB</returns>
        public string VerifyDB()
        {
            
            string tPath = System.IO.Path.GetTempPath();
            tPath = tPath + @"EcmLibrary\SqlLiteDB";
            string LiteDBPath = tPath;
            LiteDBPath += @"\EcmArchive.db";

            if (!Directory.Exists(tPath))
            {
                Directory.CreateDirectory(tPath);
            }

            if (!System.IO.File.Exists(LiteDBPath))
            {
                Console.WriteLine("Just entered to create Your DB");
                SQLiteConnection.CreateFile(LiteDBPath);
                NewDB = true;
            }
            else
            {
                NewDB = false;
            }

            dbpath = LiteDBPath;

            if (NewDB.Equals(true))
            {
                CreateTables();
            }

            return "Data Source=" + dbpath;
        }

        /// <summary>
        /// Executes the SQL.
        /// </summary>
        /// <param name="sql">The SQL.</param>
        /// <returns>true if successful, false if files</returns>
        public bool ExecSql(string sql)
        {
            bool b = true;

             try
            {
                using (var sqlite2 = new SQLiteConnection("Data Source=" + dbpath))
                {
                    sqlite2.Open();
                    SQLiteCommand command = new SQLiteCommand(sql, sqlite2);
                    command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR Sql04: " + ex.Message);
                b = false;
            }

            return b;
        }

        /// <summary>
        /// Zeroizes the tables.
        /// </summary>
        public void ZeroizeTables()
        {
            string sql = "delete from[ContactsArchive]; ";
            ExecSql(sql);
            sql = "delete from[Directory]; ";
            ExecSql(sql);
            sql = "delete from[Exchange]; ";
            ExecSql(sql);
            sql = "delete from[Files]; ";
            ExecSql(sql);
            sql = "delete from[Inventory]; ";
            ExecSql(sql);
            sql = "delete from[Listener]; ";
            ExecSql(sql);
            sql = "delete from[MultiLocationFiles]; ";
            ExecSql(sql);
            sql = "delete from[Outlook]; ";
            ExecSql(sql);
            sql = "delete from[ZipFile]; ";
            ExecSql(sql);
        }
        /// <summary>
        /// Creates the tables.
        /// </summary>
        public void CreateTables()
        {
            string sql = @"CREATE TABLE[ZipFile] (
                 [RowNbr] integer PRIMARY KEY AUTOINCREMENT
                , [DirID] int NULL
                , [FileID] int NULL
                , [FQN] nvarchar(1000) NOT NULL COLLATE NOCASE
                , [EmailAttachment] bit DEFAULT(0) NULL
                , [SuccessfullyProcessed] bit DEFAULT(0) NULL
                , [fSize] bigint NULL
                , [CreateDate] datetime NOT NULL
                , [LastAccessDate] datetime NULL
                , [NumberOfZipFiles] int NULL
                , [ParentGuid] nvarchar(50) NULL COLLATE NOCASE
                , [InWork] bit DEFAULT(0) NULL
                , [FileHash] nvarchar(50) NULL COLLATE NOCASE
                )";

            ExecSql(sql);

            sql = @"CREATE TABLE[Outlook] (
                 [RowID] integer PRIMARY KEY AUTOINCREMENT
                , [sKey] nvarchar(500) NOT NULL COLLATE NOCASE
                , [KeyExists] bit DEFAULT(1) NULL
                );";
            ExecSql(sql);

            sql = @"CREATE TABLE[MultiLocationFiles] (
                 [LocID] integer PRIMARY KEY AUTOINCREMENT
                , [DirID] int NOT NULL
                , [FileID] int NOT NULL
                , [FileHash] nvarchar(50) NOT NULL COLLATE NOCASE
                ); ";
            ExecSql(sql);

            sql = @"CREATE TABLE[Listener] (
                 [FQN] nvarchar(2000) NOT NULL COLLATE NOCASE
                , [Uploaded] int DEFAULT(0) NOT NULL
                , CONSTRAINT[sqlite_autoindex_Listener_1] PRIMARY KEY([FQN])
                );";
            ExecSql(sql);

            sql = @"CREATE TABLE[Inventory] (
                     [InvID] integer PRIMARY KEY AUTOINCREMENT
                    , [DirID] int NOT NULL
                    , [FileID] int NOT NULL
                    , [FileExist] bit DEFAULT(1) NULL
                    , [FileSize] bigint NULL
                    , [CreateDate] datetime NULL
                    , [LastUpdate] datetime NULL
                    , [LastArchiveUpdate] datetime NULL
                    , [ArchiveBit] bit NULL
                    , [NeedsArchive] bit NULL
                    , [FileHash] nvarchar(50) NULL COLLATE NOCASE
                    ); ";
            ExecSql(sql);

            sql = @"CREATE TABLE[Files] (
                 [FileID] integer PRIMARY KEY AUTOINCREMENT
                , [FileName] nvarchar(254) NOT NULL COLLATE NOCASE
                , [FileHash] nvarchar(50) NULL COLLATE NOCASE
                ); ";
            ExecSql(sql);

            sql = @"CREATE TABLE[Exchange] (
                 [sKey] nvarchar(200) NOT NULL COLLATE NOCASE
                , [RowID] int identity  NOT NULL
                , [KeyExists] bit DEFAULT(1) NULL
                , CONSTRAINT[sqlite_autoindex_Exchange_1] PRIMARY KEY([sKey])
                ); ";
            ExecSql(sql);

            sql = @"CREATE TABLE[Directory] (
                    [DirID] integer PRIMARY KEY AUTOINCREMENT
                    , [DirName] nvarchar(1000) NOT NULL COLLATE NOCASE
                    , [UseArchiveBit] bit NOT NULL
                    , [DirHash] nvarchar(50) NULL COLLATE NOCASE
                    );";
            ExecSql(sql);

            sql = @"CREATE TABLE[ContactsArchive] (
                 [RowID] integer PRIMARY KEY AUTOINCREMENT
                , [Email1Address] nvarchar(100) NOT NULL COLLATE NOCASE
                , [FullName] nvarchar(100) NOT NULL COLLATE NOCASE
                ); ";
            ExecSql(sql);

            sql = @"CREATE UNIQUE INDEX[ZipFile_PI_IDZipFile] ON[ZipFile] ([DirID] ASC,[FileID] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[ZipFile_PI_HashZipFile] ON[ZipFile] ([FileHash] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Outlook_Outlook_PI_Outlook01] ON[Outlook] ([RowID] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Outlook_Outlook_PI_Outlook02] ON[Outlook] ([KeyExists] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Outlook_Outlook_UK_Outlook] ON[Outlook] ([sKey] ASC); ";
            ExecSql(sql);
            sql = @"CREATE UNIQUE INDEX[MultiLocationFiles_MultiLocationFiles_PI_DirFile] ON[MultiLocationFiles] ([DirID] ASC,[FileID] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[MultiLocationFiles_MultiLocationFiles_PI_MultiLocationFilesHash] ON[MultiLocationFiles] ([FileHash] ASC); ";
            ExecSql(sql);
            sql = @"CREATE UNIQUE INDEX[Inventory_PI_DirFileID] ON[Inventory] ([DirID] ASC,[FileID] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Inventory_PI_NeedsArchive] ON[Inventory] ([NeedsArchive] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Inventory_PI_Hash] ON[Inventory] ([FileHash] ASC); ";
            ExecSql(sql);
            sql = @"CREATE UNIQUE INDEX[Files_PI_FileName] ON[Files] ([FileName] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Files_PI_HashFiles] ON[Files] ([FileHash] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Exchange_PI_Exchange02] ON[Exchange] ([KeyExists] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Exchange_PI_Exchange01] ON[Exchange] ([RowID] ASC); ";
            ExecSql(sql);
            sql = @"CREATE INDEX[Directory_PI_HashDir] ON[Directory] ([DirHash] ASC); ";
            ExecSql(sql);
            sql = @"CREATE UNIQUE INDEX[Directory_UK_DirName] ON[Directory] ([DirName] ASC); ";
            ExecSql(sql);
            sql = @"CREATE UNIQUE INDEX[ContactsArchive_PI_ContactsArchive] ON[ContactsArchive] ([Email1Address] ASC,[FullName] ASC); ";
            ExecSql(sql);

        }

    }
}

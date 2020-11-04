using System;
using MODI;

namespace EcmArchiver
{
    static class liteDB
    {
        public class Zip_Store
        {
            private int RowNbr;
            private int DirID;
            private int FileID;
            private string FQN;
            private bool EmailAttachment;
            private bool SuccessfullyProcessed;
            private long fSize;
            private DateTime CreateDate;
            private DateTime LastAccessDate;
            private int NumberOfZipFiles;
            private string ParentGuid;
            private bool InWork;
            private string FileHash;
        }

        public class DirFilesID_Store
        {
            private string FQN;
            private DateTime LastArchiveDate;
            private long FileLength;
            private DateTime LastModDate;
        }

        public class Directory_Store
        {
            private string DirName;
            private int DirID;
            private bool UseArchiveBit;
            private string DirHash;
            private DateTime LastArchiveDate;
        }

        public class Exts_Storage
        {
            private string Extension;
            private int Verified;
        }

        public class FileNeedProcessing_Storage
        {
            private int RowID;
            private string FQN;
            private int LineID;
            private DateTime LastProcessDate;
            private int FileCompleted;
        }

        public class Files_Storage
        {
            private int FileID;
            private string FileName;
            private string FileHash;
        }

        public class Inventory_Storage
        {
            private int InvID;
            private int DirID;
            private int FileID;
            private bool FileExist;
            private long FileSize;
            private DateTime CreateDate;
            private DateTime LastUpdate;
            private DateTime LastArchiveUpdate;
            private bool ArchiveBit;
            private bool NeedsArchive;
            private string FileHash;
        }

        public class ZipFile_Storage
        {
            private int RowNbr;
            private int DirID;
            private int FileID;
            private string FQN;
            private bool EmailAttachment;
            private bool SuccessfullyProcessed;
            private long fSize;
            private DateTime CreateDate;
            private DateTime LastAccessDate;
            private int NumberOfZipFiles;
            private string ParentGuid;
            private bool InWork;
            private string FileHash;
        }

        public class Outlook_Store
        {
            private int RowID;
            private string sKey;
            private bool KeyExists;
        }

        public class ContactsArchive_Store
        {
            private int RowID;
            private string Email1Address;
            private string FullName;
        }

        // **********************************************

        public class DirListener_Store
        {
            private int RowID;
            private string ListenerFileName;
            private int LastIdProcessed;
            private DateTime LastProcessDate;
            private int FileCanBeDropped;
            private DateTime RowCreateDate;
        }

        public class FileNeedProcessing_Store
        {
            private int RowID;
            private string ContainingFile;
            private string FQN;
            private int LineID;
            private DateTime LastProcessDate;
            private int FileApplied;
            private DateTime RowCreateDate;
        }

        public class ProcessedListenerFiles_sTORE
        {
            private int RowID;
            private string ListenerFileName;
            private DateTime RowCreateDate;
        }
    }
}
using global::System;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsARCHIVEHISTCONTENTTYPE
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string ArchiveID = "";
        private string Directory = "";
        private string FileType = "";
        private string NbrFilesArchived = "";


        // ** Generate the SET methods 
        public void setArchiveid(ref string val)
        {
            if (val.Length == 0)
            {
                val = Guid.NewGuid().ToString();
            }

            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Archiveid' cannot be NULL: 2100.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ArchiveID = val;
        }

        public void setDirectory(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Directory' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Directory = val;
        }

        public void setFiletype(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Filetype' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FileType = val;
        }

        public void setNbrfilesarchived(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            NbrFilesArchived = val;
        }



        // ** Generate the GET methods 
        public string getArchiveid()
        {
            if (Strings.Len(ArchiveID) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("GET: Field 'Archiveid' cannot be NULL: 2200.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ArchiveID);
        }

        public string getDirectory()
        {
            if (Strings.Len(Directory) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("GET: Field 'Directory' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Directory);
        }

        public string getFiletype()
        {
            if (Strings.Len(FileType) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("GET: Field 'Filetype' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FileType);
        }

        public string getNbrfilesarchived()
        {
            if (Strings.Len(NbrFilesArchived) == 0)
            {
                NbrFilesArchived = "null";
            }

            return NbrFilesArchived;
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (ArchiveID.Length == 0)
                return false;
            if (Directory.Length == 0)
                return false;
            if (FileType.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (ArchiveID.Length == 0)
                return false;
            if (Directory.Length == 0)
                return false;
            if (FileType.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ArchiveHistContentType(";
            s = s + "ArchiveID,";
            s = s + "Directory,";
            s = s + "FileType,";
            s = s + "NbrFilesArchived) values (";
            s = s + "'" + ArchiveID + "'" + ",";
            s = s + "'" + Directory + "'" + ",";
            s = s + "'" + FileType + "'" + ",";
            s = s + NbrFilesArchived + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ArchiveHistContentType set ";
            s = s + "ArchiveID = '" + getArchiveid() + "'" + ", ";
            s = s + "Directory = '" + getDirectory() + "'" + ", ";
            s = s + "FileType = '" + getFiletype() + "'" + ", ";
            s = s + "NbrFilesArchived = " + getNbrfilesarchived();
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "ArchiveID,";
            s = s + "Directory,";
            s = s + "FileType,";
            s = s + "NbrFilesArchived ";
            s = s + " FROM ArchiveHistContentType";
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the Select One Row method 
        public SqlDataReader SelectOne(string WhereClause)
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "ArchiveID,";
            s = s + "Directory,";
            s = s + "FileType,";
            s = s + "NbrFilesArchived ";
            s = s + " FROM ArchiveHistContentType";
            s = s + WhereClause;
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the DELETE method 
        public bool Delete(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            WhereClause = " " + WhereClause;
            s = " Delete from ArchiveHistContentType";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ArchiveHistContentType";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK111(string ArchiveID, string Directory, string FileType)
        {
            int B = 0;
            string TBL = "ArchiveHistContentType";
            string WC = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK111

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK111(string ArchiveID, string Directory, string FileType)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveHistContentType";
            string WC = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK111

        /// Build Index Where Caluses
        public string wc_PK111(string ArchiveID, string Directory, string FileType)
        {
            string WC = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'";
            return WC;
        }     // ** wc_PK111

        // ** Generate the SET methods 

    }
}
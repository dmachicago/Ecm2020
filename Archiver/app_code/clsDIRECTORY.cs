using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsDIRECTORY
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string IncludeSubDirs = "";
        private string FQN = "";
        private string DB_ID = "";
        private string VersionFiles = "";
        private string ckMetaData = "";
        private string ckPublic = "";
        private string ckDisableDir = "";
        private string QuickRefEntry = "0";
        private string OcrDirectory = "";
        private string OcrPdf = "";
        private bool ArchiveBit = false;
        private string DeleteOnArchive = "";

        // DeleteOnArchive
        // ** Generate the SET methods 
        public void setDeleteOnArchive(ref string val)
        {
            DeleteOnArchive = val;
        }

        public void setSkipIfArchiveBit(ref string val)
        {
            if (val.ToUpper().Equals("TRUE"))
            {
                ArchiveBit = true;
            }
            else
            {
                ArchiveBit = false;
            }
        }

        public void setOcrPdf(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            OcrPdf = val;
        }

        public void setOcrDirectory(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            OcrDirectory = val;
        }

        public void setUserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setQuickRefEntry(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            QuickRefEntry = val;
        }

        public void setIncludesubdirs(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            IncludeSubDirs = val;
        }

        public void setFqn(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Fqn' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FQN = val;
        }

        public void setDb_id(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "ECM.Library";
                // messagebox.show("SET: Field 'Db_id' cannot be NULL.")
                // Return
            }

            val = UTIL.RemoveSingleQuotes(val);
            DB_ID = val;
        }

        public void setVersionfiles(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            VersionFiles = val;
        }

        public void setCkmetadata(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ckMetaData = val;
        }

        public void setCkpublic(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ckPublic = val;
        }

        public void setCkdisabledir(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ckDisableDir = val;
        }



        // ** Generate the GET methods 
        public string getUserid()
        {
            if (Strings.Len(UserID) == 0)
            {
                MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getIncludesubdirs()
        {
            if (IncludeSubDirs.ToUpper().Equals("TRUE"))
            {
                IncludeSubDirs = "Y";
            }

            if (IncludeSubDirs.ToUpper().Equals("FALSE"))
            {
                IncludeSubDirs = "N";
            }

            if (IncludeSubDirs.ToUpper().Equals("1"))
            {
                IncludeSubDirs = "Y";
            }

            if (IncludeSubDirs.ToUpper().Equals("0"))
            {
                IncludeSubDirs = "N";
            }

            return UTIL.RemoveSingleQuotes(IncludeSubDirs);
        }

        public string getFqn()
        {
            if (Strings.Len(FQN) == 0)
            {
                MessageBox.Show("GET: Field 'Fqn' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FQN);
        }

        public string getDb_id()
        {
            if (Strings.Len(DB_ID) == 0)
            {
                // messagebox.show("GET: Field 'Db_id' cannot be NULL.")
                return "ECM.Library";
            }

            return UTIL.RemoveSingleQuotes(DB_ID);
        }

        public string getVersionfiles()
        {
            if (VersionFiles.ToUpper().Equals("TRUE"))
            {
                VersionFiles = "Y";
            }

            if (VersionFiles.ToUpper().Equals("FALSE"))
            {
                VersionFiles = "N";
            }

            if (VersionFiles.ToUpper().Equals("1"))
            {
                VersionFiles = "Y";
            }

            if (VersionFiles.ToUpper().Equals("0"))
            {
                VersionFiles = "N";
            }

            return UTIL.RemoveSingleQuotes(VersionFiles);
        }

        public string getCkmetadata()
        {
            if (ckMetaData.ToUpper().Equals("TRUE"))
            {
                ckMetaData = "Y";
            }

            if (ckMetaData.ToUpper().Equals("FALSE"))
            {
                ckMetaData = "N";
            }

            if (ckMetaData.ToUpper().Equals("1"))
            {
                ckMetaData = "Y";
            }

            if (ckMetaData.ToUpper().Equals("0"))
            {
                ckMetaData = "N";
            }

            return UTIL.RemoveSingleQuotes(ckMetaData);
        }

        public string getCkpublic()
        {
            if (ckPublic.ToUpper().Equals("TRUE"))
            {
                ckPublic = "Y";
            }

            if (ckPublic.ToUpper().Equals("FALSE"))
            {
                ckPublic = "N";
            }

            if (ckPublic.ToUpper().Equals("1"))
            {
                ckPublic = "Y";
            }

            if (ckPublic.ToUpper().Equals("0"))
            {
                ckPublic = "N";
            }

            return UTIL.RemoveSingleQuotes(ckPublic);
        }

        public string getCkdisabledir()
        {
            return UTIL.RemoveSingleQuotes(ckDisableDir);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (FQN.Length == 0)
                return false;
            if (DB_ID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (UserID.Length == 0)
                return false;
            if (FQN.Length == 0)
                return false;
            if (DB_ID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            if (QuickRefEntry.Length == 0)
            {
                QuickRefEntry = "0";
            }

            if (OcrDirectory.Length == 0)
            {
                MessageBox.Show("OcrDirectory must be set to either Y or N");
            }

            FQN = FQN.Replace("'", "`");
            bool b = false;
            string s = "";
            s = s + " INSERT INTO Directory(";
            s = s + "UserID,";
            s = s + "IncludeSubDirs,";
            s = s + "FQN,";
            s = s + "DB_ID,";
            s = s + "VersionFiles,";
            s = s + "ckMetaData,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir, QuickRefEntry, OcrDirectory, OcrPdf, ArchiveSkipBit, DeleteOnArchive) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + IncludeSubDirs + "'" + ",";
            s = s + "'" + FQN + "'" + ",";
            s = s + "'" + DB_ID + "'" + ",";
            s = s + "'" + VersionFiles + "'" + ",";
            s = s + "'" + ckMetaData + "'" + ",";
            s = s + "'" + ckPublic + "'" + ",";
            s = s + "'" + ckDisableDir + "'" + ",";
            s = s + "'" + QuickRefEntry + "'" + ",";
            s = s + "'" + OcrDirectory + "'" + ",";
            s = s + "'" + OcrPdf + "'" + ",";
            if (ArchiveBit == true)
            {
                s = s + "1" + ",";
            }
            else
            {
                s = s + "0" + ",";
            }

            s = s + "'" + DeleteOnArchive + "')";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause, string OcrDirectory)
        {
            bool b = false;
            string s = "";
            if (OcrDirectory.Length == 0)
            {
                MessageBox.Show("OcrDirectory must be set to either Y or N");
            }

            if (Strings.Len(WhereClause) == 0)
                return false;
            string ckDisableDir = getCkdisabledir();
            if (ckDisableDir.ToUpper() == "TRUE")
            {
                ckDisableDir = "Y";
            }

            if (ckDisableDir.ToUpper() == "FALSE")
            {
                ckDisableDir = "N";
            }

            if (ckDisableDir.ToUpper() == "1")
            {
                ckDisableDir = "Y";
            }

            if (ckDisableDir.ToUpper() == "0")
            {
                ckDisableDir = "N";
            }

            s = "";
            s = s + " update Directory set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "IncludeSubDirs = '" + getIncludesubdirs() + "'" + ", ";
            s = s + "FQN = '" + getFqn() + "'" + ", ";
            s = s + "VersionFiles = '" + getVersionfiles() + "'" + ", ";
            s = s + "ckMetaData = '" + getCkmetadata() + "'" + ", ";
            s = s + "ckPublic = '" + getCkpublic() + "'" + ", ";
            s = s + "ckDisableDir = '" + ckDisableDir + "',";
            s = s + "OcrDirectory = '" + OcrDirectory + "',";
            s = s + "OcrPdf = '" + OcrPdf + "',";
            if (ArchiveBit == true)
            {
                s = s + "ArchiveSkipBit = 1, ";
            }
            else
            {
                s = s + "ArchiveSkipBit = 0, ";
            }

            s = s + "DeleteOnArchive = '" + DeleteOnArchive + "'";
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
            s = s + "UserID,";
            s = s + "IncludeSubDirs,";
            s = s + "FQN,";
            s = s + "DB_ID,";
            s = s + "VersionFiles,";
            s = s + "ckMetaData,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir ";
            s = s + " FROM Directory";
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
            s = s + "UserID,";
            s = s + "IncludeSubDirs,";
            s = s + "FQN,";
            s = s + "DB_ID,";
            s = s + "VersionFiles,";
            s = s + "ckMetaData,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir ";
            s = s + " FROM Directory";
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
            s = " Delete from Directory";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from Directory";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PKII2(string FQN, string UserID)
        {
            int B = 0;
            string TBL = "Directory";
            string WC = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PKII2

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PKII2(string FQN, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "Directory";
            string WC = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PKII2

        /// Build Index Where Caluses
        public string wc_PKII2(string FQN, string UserID)
        {
            string WC = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PKII2
    }
}
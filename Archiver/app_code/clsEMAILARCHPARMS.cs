using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEMAILARCHPARMS
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string ArchiveEmails = "";
        private string RemoveAfterArchive = "";
        private string SetAsDefaultFolder = "";
        private string ArchiveAfterXDays = "";
        private string RemoveAfterXDays = "";
        private string RemoveXDays = "";
        private string ArchiveXDays = "";
        private string FolderName = "";
        private string DB_ID = "";
        private string ArchiveOnlyIfRead = "";
        private string isSysDefault = "";




        // ** Generate the SET methods 
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

        public void setIsSysDefault(string Val)
        {
            Val = UTIL.RemoveSingleQuotes(Val);
            isSysDefault = Val;
        }

        public void setArchiveemails(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveEmails = val;
        }

        public void setRemoveafterarchive(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            RemoveAfterArchive = val;
        }

        public void setSetasdefaultfolder(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SetAsDefaultFolder = val;
        }

        public void setArchiveafterxdays(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveAfterXDays = val;
        }

        public void setRemoveafterxdays(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            RemoveAfterXDays = val;
        }

        public void setRemovexdays(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            RemoveXDays = val;
        }

        public void setArchivexdays(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            ArchiveXDays = val;
        }

        public void setFoldername(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Foldername' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FolderName = val;
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

        public void setArchiveonlyifread(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveOnlyIfRead = val;
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

        public string getArchiveemails()
        {
            return UTIL.RemoveSingleQuotes(ArchiveEmails);
        }

        public string getRemoveafterarchive()
        {
            return UTIL.RemoveSingleQuotes(RemoveAfterArchive);
        }

        public string getSetasdefaultfolder()
        {
            return UTIL.RemoveSingleQuotes(SetAsDefaultFolder);
        }

        public string getArchiveafterxdays()
        {
            return UTIL.RemoveSingleQuotes(ArchiveAfterXDays);
        }

        public string getRemoveafterxdays()
        {
            return UTIL.RemoveSingleQuotes(RemoveAfterXDays);
        }

        public string getRemovexdays()
        {
            if (Strings.Len(RemoveXDays) == 0)
            {
                RemoveXDays = "null";
            }

            return RemoveXDays;
        }

        public string getArchivexdays()
        {
            if (Strings.Len(ArchiveXDays) == 0)
            {
                ArchiveXDays = "null";
            }

            return ArchiveXDays;
        }

        public string getFoldername()
        {
            if (Strings.Len(FolderName) == 0)
            {
                MessageBox.Show("GET: Field 'Foldername' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FolderName);
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

        public string getArchiveonlyifread()
        {
            return UTIL.RemoveSingleQuotes(ArchiveOnlyIfRead);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (FolderName.Length == 0)
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
            if (FolderName.Length == 0)
                return false;
            if (DB_ID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert(string FileDirectory)
        {
            FileDirectory = UTIL.RemoveSingleQuotes(FileDirectory);
            bool b = false;
            string s = "";
            s = s + " INSERT INTO EmailArchParms(";
            s = s + "UserID,";
            s = s + "ArchiveEmails,";
            s = s + "RemoveAfterArchive,";
            s = s + "SetAsDefaultFolder,";
            s = s + "ArchiveAfterXDays,";
            s = s + "RemoveAfterXDays,";
            s = s + "RemoveXDays,";
            s = s + "ArchiveXDays,";
            s = s + "FolderName,";
            s = s + "DB_ID,";
            s = s + "ArchiveOnlyIfRead,isSysDefault, FileDirectory) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + ArchiveEmails + "'" + ",";
            s = s + "'" + RemoveAfterArchive + "'" + ",";
            s = s + "'" + SetAsDefaultFolder + "'" + ",";
            s = s + "'" + ArchiveAfterXDays + "'" + ",";
            s = s + "'" + RemoveAfterXDays + "'" + ",";
            s = s + RemoveXDays + ",";
            if (ArchiveXDays.Trim().Length == 0)
            {
                ArchiveXDays = "30";
            }

            s = s + ArchiveXDays + ",";
            s = s + "'" + FolderName + "'" + ",";
            s = s + "'" + DB_ID + "'" + ",";
            s = s + "'" + ArchiveOnlyIfRead + "', ";
            s = s + isSysDefault + ", ";
            s = s + "'" + FileDirectory + "')";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update EmailArchParms set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "ArchiveEmails = '" + getArchiveemails() + "'" + ", ";
            s = s + "RemoveAfterArchive = '" + getRemoveafterarchive() + "'" + ", ";
            s = s + "SetAsDefaultFolder = '" + getSetasdefaultfolder() + "'" + ", ";
            s = s + "ArchiveAfterXDays = '" + getArchiveafterxdays() + "'" + ", ";
            s = s + "RemoveAfterXDays = '" + getRemoveafterxdays() + "'" + ", ";
            s = s + "RemoveXDays = " + getRemovexdays() + ", ";
            s = s + "ArchiveXDays = " + getArchivexdays() + ", ";
            s = s + "FolderName = '" + getFoldername() + "'" + ", ";
            s = s + "DB_ID = '" + getDb_id() + "'" + ", ";
            s = s + "ArchiveOnlyIfRead = '" + getArchiveonlyifread() + "', ";
            s = s + "isSysDefault = " + isSysDefault + " ";
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
            s = s + "ArchiveEmails,";
            s = s + "RemoveAfterArchive,";
            s = s + "SetAsDefaultFolder,";
            s = s + "ArchiveAfterXDays,";
            s = s + "RemoveAfterXDays,";
            s = s + "RemoveXDays,";
            s = s + "ArchiveXDays,";
            s = s + "FolderName,";
            s = s + "DB_ID,";
            s = s + "ArchiveOnlyIfRead ";
            s = s + " FROM EmailArchParms";
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
            s = s + "ArchiveEmails,";
            s = s + "RemoveAfterArchive,";
            s = s + "SetAsDefaultFolder,";
            s = s + "ArchiveAfterXDays,";
            s = s + "RemoveAfterXDays,";
            s = s + "RemoveXDays,";
            s = s + "ArchiveXDays,";
            s = s + "FolderName,";
            s = s + "DB_ID,";
            s = s + "ArchiveOnlyIfRead ";
            s = s + " FROM EmailArchParms";
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
            s = " Delete from EmailArchParms";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from EmailArchParms";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK5EmailArchParms(string FolderName, string UserID)
        {
            int B = 0;
            string TBL = "EmailArchParms";
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK5EmailArchParms


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK5EmailArchParms(string FolderName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "EmailArchParms";
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK5EmailArchParms


        /// Build Index Where Caluses
        public string wc_PK5EmailArchParms(string FolderName, string UserID)
        {
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK5EmailArchParms
    }
}
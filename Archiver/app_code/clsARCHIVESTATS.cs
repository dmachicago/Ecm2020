using global::System;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsARCHIVESTATS : clsDatabaseARCH
    {
        // ** DIM the selected table columns 
        // Dim DBARCH As New clsDatabaseARCH

        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string ArchiveStartDate = "";
        private string Status = "";
        private string Successful = "";
        private string ArchiveType = "";
        private string TotalEmailsInRepository = "";
        private string TotalContentInRepository = "";
        private string UserID = "";
        private string ArchiveEndDate = "";
        private string StatGuid = "";
        private string EntrySeq = "";


        // ** Generate the SET methods 
        public void setArchivestartdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveStartDate = val;
        }

        public void setStatus(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Status' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Status = val;
        }

        public void setSuccessful(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Successful = val;
        }

        public void setArchivetype(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Archivetype' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ArchiveType = val;
        }

        public void setTotalemailsinrepository(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            TotalEmailsInRepository = val;
        }

        public void setTotalcontentinrepository(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            TotalContentInRepository = val;
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

        public void setArchiveenddate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveEndDate = val;
        }

        public void setStatguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Statguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            StatGuid = val;
        }



        // ** Generate the GET methods 
        public string getArchivestartdate()
        {
            return UTIL.RemoveSingleQuotes(ArchiveStartDate);
        }

        public string getStatus()
        {
            if (Strings.Len(Status) == 0)
            {
                MessageBox.Show("GET: Field 'Status' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Status);
        }

        public string getSuccessful()
        {
            return UTIL.RemoveSingleQuotes(Successful);
        }

        public string getArchivetype()
        {
            if (Strings.Len(ArchiveType) == 0)
            {
                MessageBox.Show("GET: Field 'Archivetype' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ArchiveType);
        }

        public string getTotalemailsinrepository()
        {
            if (Strings.Len(TotalEmailsInRepository) == 0)
            {
                TotalEmailsInRepository = "null";
            }

            return TotalEmailsInRepository;
        }

        public string getTotalcontentinrepository()
        {
            if (Strings.Len(TotalContentInRepository) == 0)
            {
                TotalContentInRepository = "null";
            }

            return TotalContentInRepository;
        }

        public string getUserid()
        {
            if (Strings.Len(UserID) == 0)
            {
                MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getArchiveenddate()
        {
            return UTIL.RemoveSingleQuotes(ArchiveEndDate);
        }

        public string getStatguid()
        {
            if (Strings.Len(StatGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Statguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(StatGuid);
        }

        public string getEntryseq()
        {
            if (Strings.Len(EntrySeq) == 0)
            {
                MessageBox.Show("GET: Field 'Entryseq' cannot be NULL.");
                return "";
            }

            if (Strings.Len(EntrySeq) == 0)
            {
                EntrySeq = "null";
            }

            return EntrySeq;
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (Status.Length == 0)
                return false;
            if (ArchiveType.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            if (StatGuid.Length == 0)
                return false;
            if (EntrySeq.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (Status.Length == 0)
                return false;
            if (ArchiveType.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            if (StatGuid.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ArchiveStats(";
            s = s + "ArchiveStartDate,";
            s = s + "Status,";
            s = s + "Successful,";
            s = s + "ArchiveType,";
            s = s + "TotalEmailsInRepository,";
            s = s + "TotalContentInRepository,";
            s = s + "UserID,";
            s = s + "ArchiveEndDate,";
            s = s + "StatGuid) VALUES (";
            s = s + "'" + ArchiveStartDate + "'" + ",";
            s = s + "'" + Status + "'" + ",";
            s = s + "'" + Successful + "'" + ",";
            s = s + "'" + ArchiveType + "'" + ",";
            s = s + TotalEmailsInRepository + ",";
            s = s + TotalContentInRepository + ",";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + ArchiveEndDate + "'" + ",";
            s = s + "'" + StatGuid + "'";
            s = s + EntrySeq + ")";
            return ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ArchiveStats set ";
            s = s + "ArchiveStartDate = '" + getArchivestartdate() + "'" + ", ";
            s = s + "Status = '" + getStatus() + "'" + ", ";
            s = s + "Successful = '" + getSuccessful() + "'" + ", ";
            s = s + "ArchiveType = '" + getArchivetype() + "'" + ", ";
            s = s + "TotalEmailsInRepository = " + getTotalemailsinrepository() + ", ";
            s = s + "TotalContentInRepository = " + getTotalcontentinrepository() + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "ArchiveEndDate = '" + getArchiveenddate() + "'" + ", ";
            s = s + "StatGuid = '" + getStatguid() + "'" + " ";
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            SqlDataReader rsData;
            s = s + " SELECT ";
            s = s + "ArchiveStartDate,";
            s = s + "Status,";
            s = s + "Successful,";
            s = s + "ArchiveType,";
            s = s + "TotalEmailsInRepository,";
            s = s + "TotalContentInRepository,";
            s = s + "UserID,";
            s = s + "ArchiveEndDate,";
            s = s + "StatGuid,";
            s = s + "EntrySeq ";
            s = s + " FROM ArchiveStats";
            string CS = setConnStr();
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(s, CONN);
            rsData = command.ExecuteReader();
            return rsData;
        }


        // ** Generate the Select One Row method 
        public SqlDataReader SelectOne(string WhereClause)
        {
            bool b = false;
            string s = "";
            SqlDataReader rsData;
            s = s + " SELECT ";
            s = s + "ArchiveStartDate,";
            s = s + "Status,";
            s = s + "Successful,";
            s = s + "ArchiveType,";
            s = s + "TotalEmailsInRepository,";
            s = s + "TotalContentInRepository,";
            s = s + "UserID,";
            s = s + "ArchiveEndDate,";
            s = s + "StatGuid,";
            s = s + "EntrySeq ";
            s = s + " FROM ArchiveStats";
            s = s + WhereClause;
            string CS = setConnStr();
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(s, CONN);
            rsData = command.ExecuteReader();
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
            s = " Delete from ArchiveStats";
            s = s + WhereClause;
            b = ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ArchiveStats";
            b = ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PI01_ArchiveStats(string ArchiveType, string Status, string UserID)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI01_ArchiveStats

        public int cnt_PI02_ArchiveStats(string Status, string UserID)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI02_ArchiveStats

        public int cnt_PI03_ArchiveStats(DateTime ArchiveStartDate, string ArchiveType, string UserID)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveStartDate = '" + Conversions.ToString(ArchiveStartDate) + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI03_ArchiveStats

        public int cnt_PI04_ArchiveStats(string ArchiveType, string UserID)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI04_ArchiveStats

        public int cnt_PI05_ArchiveStats(int EntrySeq)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where EntrySeq = " + EntrySeq;
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI05_ArchiveStats

        public int cnt_PK_ArchiveStats(string StatGuid)
        {
            int B = 0;
            string TBL = "ArchiveStats";
            string WC = "Where StatGuid = '" + StatGuid + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_ArchiveStats

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PI01_ArchiveStats(string ArchiveType, string Status, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI01_ArchiveStats

        public SqlDataReader getRow_PI02_ArchiveStats(string Status, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI02_ArchiveStats

        public SqlDataReader getRow_PI03_ArchiveStats(DateTime ArchiveStartDate, string ArchiveType, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveStartDate = '" + Conversions.ToString(ArchiveStartDate) + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI03_ArchiveStats

        public SqlDataReader getRow_PI04_ArchiveStats(string ArchiveType, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI04_ArchiveStats

        public SqlDataReader getRow_PI05_ArchiveStats(int EntrySeq)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where EntrySeq = " + EntrySeq;
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI05_ArchiveStats

        public SqlDataReader getRow_PK_ArchiveStats(string StatGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveStats";
            string WC = "Where StatGuid = '" + StatGuid + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_ArchiveStats

        /// Build Index Where Caluses
        public string wc_PI01_ArchiveStats(string ArchiveType, string Status, string UserID)
        {
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PI01_ArchiveStats

        public string wc_PI02_ArchiveStats(string Status, string UserID)
        {
            string WC = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PI02_ArchiveStats

        public string wc_PI03_ArchiveStats(DateTime ArchiveStartDate, string ArchiveType, string UserID)
        {
            string WC = "Where ArchiveStartDate = '" + Conversions.ToString(ArchiveStartDate) + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PI03_ArchiveStats

        public string wc_PI04_ArchiveStats(string ArchiveType, string UserID)
        {
            string WC = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PI04_ArchiveStats

        public string wc_PI05_ArchiveStats(int EntrySeq)
        {
            string WC = "Where EntrySeq = " + EntrySeq;
            return WC;
        }     // ** wc_PI05_ArchiveStats

        public string wc_PK_ArchiveStats(string StatGuid)
        {
            string WC = "Where StatGuid = '" + StatGuid + "'";
            return WC;
        }     // ** wc_PK_ArchiveStats
    }
}
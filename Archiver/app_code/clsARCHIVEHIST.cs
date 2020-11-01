using global::System;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsARCHIVEHIST
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private string ArchiveID = "";
        private string ArchiveDate = "";
        private string NbrFilesArchived = "";
        private string UserGuid = "";


        // ** Generate the SET methods 
        public void setArchiveid(ref string val)
        {
            if (val.Length == 0)
            {
                val = Guid.NewGuid().ToString();
            }

            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Archiveid' cannot be NULL.: 2300");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ArchiveID = val;
        }

        public void setArchivedate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ArchiveDate = val;
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

        public void setUserguid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserGuid = val;
        }



        // ** Generate the GET methods 
        public string getArchiveid()
        {
            if (Strings.Len(ArchiveID) == 0)
            {
                MessageBox.Show("GET: Field 'Archiveid' cannot be NULL: 2400.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ArchiveID);
        }

        public string getArchivedate()
        {
            return UTIL.RemoveSingleQuotes(ArchiveDate);
        }

        public string getNbrfilesarchived()
        {
            if (Strings.Len(NbrFilesArchived) == 0)
            {
                NbrFilesArchived = "null";
            }

            return NbrFilesArchived;
        }

        public string getUserguid()
        {
            return UTIL.RemoveSingleQuotes(UserGuid);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (ArchiveID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (ArchiveID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ArchiveHist(";
            s = s + "ArchiveID,";
            s = s + "ArchiveDate,";
            s = s + "NbrFilesArchived,";
            s = s + "UserGuid) values (";
            s = s + "'" + ArchiveID + "'" + ",";
            s = s + "'" + ArchiveDate + "'" + ",";
            s = s + NbrFilesArchived + ",";
            s = s + "'" + UserGuid + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ArchiveHist set ";
            s = s + "ArchiveID = '" + getArchiveid() + "'" + ", ";
            s = s + "ArchiveDate = '" + getArchivedate() + "'" + ", ";
            s = s + "NbrFilesArchived = " + getNbrfilesarchived() + ", ";
            s = s + "UserGuid = '" + getUserguid() + "'";
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
            s = s + "ArchiveDate,";
            s = s + "NbrFilesArchived,";
            s = s + "UserGuid ";
            s = s + " FROM ArchiveHist";
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
            s = s + "ArchiveDate,";
            s = s + "NbrFilesArchived,";
            s = s + "UserGuid ";
            s = s + " FROM ArchiveHist";
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
            s = " Delete from ArchiveHist";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ArchiveHist";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK110(string ArchiveID)
        {
            int B = 0;
            string TBL = "ArchiveHist";
            string WC = "Where ArchiveID = '" + ArchiveID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK110

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK110(string ArchiveID)
        {
            SqlDataReader rsData = null;
            string TBL = "ArchiveHist";
            string WC = "Where ArchiveID = '" + ArchiveID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK110

        /// Build Index Where Caluses
        public string wc_PK110(string ArchiveID)
        {
            string WC = "Where ArchiveID = '" + ArchiveID + "'";
            return WC;
        }     // ** wc_PK110

        // ** Generate the SET methods 

    }
}
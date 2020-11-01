using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsACTIVESEARCHGUIDS
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string DocGuid = "";
        private string SeqNO = "";


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

        public void setDocguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Docguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            DocGuid = val;
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

        public string getDocguid()
        {
            if (Strings.Len(DocGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Docguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(DocGuid);
        }

        public string getSeqno()
        {
            if (Strings.Len(SeqNO) == 0)
            {
                MessageBox.Show("GET: Field 'Seqno' cannot be NULL.");
                return "";
            }

            if (Strings.Len(SeqNO) == 0)
            {
                SeqNO = "null";
            }

            return SeqNO;
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (DocGuid.Length == 0)
                return false;
            if (SeqNO.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (UserID.Length == 0)
                return false;
            if (DocGuid.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ActiveSearchGuids(";
            s = s + "UserID,";
            s = s + "DocGuid) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + DocGuid + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ActiveSearchGuids set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "DocGuid = '" + getDocguid() + "'" + ", ";
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            SqlDataReader rsData;
            s = s + " SELECT ";
            s = s + "UserID,";
            s = s + "DocGuid,";
            s = s + "SeqNO ";
            s = s + " FROM ActiveSearchGuids";
            string CS = DBARCH.setConnStr();     // DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
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
            s = s + "UserID,";
            s = s + "DocGuid,";
            s = s + "SeqNO ";
            s = s + " FROM ActiveSearchGuids";
            s = s + WhereClause;
            string CS = DBARCH.setConnStr();     // DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
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
            s = " Delete from ActiveSearchGuids";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ActiveSearchGuids";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PI01_ActiveSearchGuids(int SeqNO, string UserID)
        {
            int B = 0;
            string TBL = "ActiveSearchGuids";
            string WC = "Where SeqNO = " + SeqNO + " and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI01_ActiveSearchGuids

        public int cnt_PK_ActiveSearchGuids(string DocGuid, string UserID)
        {
            int B = 0;
            string TBL = "ActiveSearchGuids";
            string WC = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_ActiveSearchGuids

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PI01_ActiveSearchGuids(int SeqNO, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ActiveSearchGuids";
            string WC = "Where SeqNO = " + SeqNO + " and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI01_ActiveSearchGuids

        public SqlDataReader getRow_PK_ActiveSearchGuids(string DocGuid, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ActiveSearchGuids";
            string WC = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_ActiveSearchGuids

        /// Build Index Where Caluses
        public string wc_PI01_ActiveSearchGuids(int SeqNO, string UserID)
        {
            string WC = "Where SeqNO = " + SeqNO + " and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PI01_ActiveSearchGuids

        public string wc_PK_ActiveSearchGuids(string DocGuid, string UserID)
        {
            string WC = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK_ActiveSearchGuids

        // ** Generate the SET methods 

    }
}
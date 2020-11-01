using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsAVAILFILETYPES
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string ExtCode = "";


        // ** Generate the SET methods 
        public void setExtcode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Extcode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ExtCode = val;
        }



        // ** Generate the GET methods 
        public string getExtcode()
        {
            if (Strings.Len(ExtCode) == 0)
            {
                MessageBox.Show("GET: Field 'Extcode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ExtCode);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (ExtCode.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (ExtCode.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO AvailFileTypes(";
            s = s + "ExtCode) values (";
            s = s + "'" + ExtCode + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update AvailFileTypes set ";
            s = s + "ExtCode = '" + getExtcode() + "'";
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
            s = s + "ExtCode ";
            s = s + " FROM AvailFileTypes";
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
            s = s + "ExtCode ";
            s = s + " FROM AvailFileTypes";
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
            s = " Delete from AvailFileTypes";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from AvailFileTypes";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PKI7(string ExtCode)
        {
            int B = 0;
            string TBL = "AvailFileTypes";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PKI7

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PKI7(string ExtCode)
        {
            SqlDataReader rsData = null;
            string TBL = "AvailFileTypes";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PKI7

        /// Build Index Where Caluses
        public string wc_PKI7(string ExtCode)
        {
            string WC = "Where ExtCode = '" + ExtCode + "'";
            return WC;
        }     // ** wc_PKI7

        // ** Generate the SET methods 

    }
}
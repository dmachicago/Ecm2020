using global::System.Data.SqlClient;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsDbARCHS
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string DB_ID = "";
        private string DB_CONN_STR = "";


        // ** Generate the SET methods 
        public void setDb_id(string val)
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

        public void setDb_conn_str(string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            DB_CONN_STR = val;
        }



        // ** Generate the GET methods 
        public string getDb_id()
        {
            if (Strings.Len(DB_ID) == 0)
            {
                // messagebox.show("GET: Field 'Db_id' cannot be NULL.")
                return "ECM.Library";
            }

            return UTIL.RemoveSingleQuotes(DB_ID);
        }

        public string getDb_conn_str()
        {
            return UTIL.RemoveSingleQuotes(DB_CONN_STR);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (DB_ID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (DB_ID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO Databases(";
            s = s + "DB_ID,";
            s = s + "DB_CONN_STR) values (";
            s = s + "'" + DB_ID + "'" + ",";
            s = s + "'" + DB_CONN_STR + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update Databases set ";
            s = s + "DB_ID = '" + getDb_id() + "'" + ", ";
            s = s + "DB_CONN_STR = '" + getDb_conn_str() + "'";
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
            s = s + "DB_ID,";
            s = s + "DB_CONN_STR ";
            s = s + " FROM Databases";
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
            s = s + "DB_ID,";
            s = s + "DB_CONN_STR ";
            s = s + " FROM Databases";
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
            s = " Delete from Databases";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize(string WhereClause)
        {
            bool b = false;
            string s = "";
            s = s + " Delete from Databases";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }
    }
}
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsRUNPARMS
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string Parm = "";
        private string ParmValue = "";
        private string UserID = "";




        // ** Generate the SET methods 
        public void setParm(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Parm' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Parm = val;
        }

        public void setParmvalue(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ParmValue = val;
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






        // ** Generate the GET methods 
        public string getParm()
        {
            if (Strings.Len(Parm) == 0)
            {
                MessageBox.Show("GET: Field 'Parm' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Parm);
        }

        public string getParmvalue()
        {
            return UTIL.RemoveSingleQuotes(ParmValue);
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






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (Parm.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (Parm.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO RunParms(";
            s = s + "Parm,";
            s = s + "ParmValue,";
            s = s + "UserID) values (";
            s = s + "'" + getParm() + "'" + ",";
            s = s + "'" + getParmvalue() + "'" + ",";
            s = s + "'" + UserID + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update RunParms set ";
            // s = s + "Parm = '" + getParm() + "'" + ", "
            s = s + "ParmValue = '" + getParmvalue() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'";
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
            s = s + "Parm,";
            s = s + "ParmValue,";
            s = s + "UserID ";
            s = s + " FROM RunParms";
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
            s = s + "Parm,";
            s = s + "ParmValue,";
            s = s + "UserID ";
            s = s + " FROM RunParms ";
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
            s = " Delete from RunParms ";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from RunParms ";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PKI8(string Parm, string UserID)
        {
            int B = 0;
            string TBL = "RunParms";
            string WC = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PKI8


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PKI8(string Parm, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "RunParms";
            string WC = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData is null)
            {
                return null;
            }

            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PKI8


        /// Build Index Where Caluses
        public string wc_PKI8(string Parm, string UserID)
        {
            string WC = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PKI8


        // ** Generate the SET methods 


    }
}
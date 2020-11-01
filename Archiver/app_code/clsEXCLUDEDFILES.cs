using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEXCLUDEDFILES
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private string UserID = "";
        private string ExtCode = "";
        private string FQN = "";




        // ** Generate the SET methods 
        public void setUserid(string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setExtcode(string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Extcode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ExtCode = val;
        }

        public void setFqn(string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Fqn' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FQN = val;
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

        public string getExtcode()
        {
            if (Strings.Len(ExtCode) == 0)
            {
                MessageBox.Show("GET: Field 'Extcode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ExtCode);
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






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (ExtCode.Length == 0)
                return false;
            if (FQN.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (UserID.Length == 0)
                return false;
            if (ExtCode.Length == 0)
                return false;
            if (FQN.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ExcludedFiles(";
            s = s + "UserID,";
            s = s + "ExtCode,";
            s = s + "FQN) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + ExtCode + "'" + ",";
            s = s + "'" + FQN + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ExcludedFiles set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "ExtCode = '" + getExtcode() + "'" + ", ";
            s = s + "FQN = '" + getFqn() + "'";
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
            s = s + "ExtCode,";
            s = s + "FQN ";
            s = s + " FROM ExcludedFiles";
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
            s = s + "ExtCode,";
            s = s + "FQN ";
            s = s + " FROM ExcludedFiles";
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
            s = " Delete from ExcludedFiles";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize(string WhereClause)
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ExcludedFiles";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }

        public bool DeleteExisting(string UID, string FQN)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            bool b = false;
            string s = "";
            s = s + " delete from ExcludedFiles ";
            s = s + " where [UserID] = '" + UID + "'  and [FQN] = '" + FQN + "' ";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }

        public bool DeleteExisting(string UID, string FQN, string ExtCode)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            bool b = false;
            string s = "";
            s = s + " delete FROM [ExcludedFiles]";
            s = s + " where [UserID] = '" + UID + "'";
            s = s + " and  [ExtCode] = '" + ExtCode + "'";
            s = s + " and [FQN] = '" + FQN + "'";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }
    }
}
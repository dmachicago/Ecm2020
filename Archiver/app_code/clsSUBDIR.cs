using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsSUBDIR
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string SUBFQN = "";
        private string FQN = "";
        private string ckPublic = "";
        private string ckDisableDir = "";
        private string OcrDirectory = "";




        // ** Generate the SET methods 
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

        public void setSubfqn(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Subfqn' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SUBFQN = val;
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

        public string getSubfqn()
        {
            if (Strings.Len(SUBFQN) == 0)
            {
                MessageBox.Show("GET: Field 'Subfqn' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SUBFQN);
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

        public string getCkpublic()
        {
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
            if (SUBFQN.Length == 0)
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
            if (SUBFQN.Length == 0)
                return false;
            if (FQN.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            if (OcrDirectory.Length == 0)
            {
                MessageBox.Show("OcrDirectory  must be set to either Y or N");
            }

            bool b = false;
            string s = "";
            s = s + " INSERT INTO SubDir(";
            s = s + "UserID,";
            s = s + "SUBFQN,";
            s = s + "FQN,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir,OcrDirectory) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + SUBFQN + "'" + ",";
            s = s + "'" + FQN + "'" + ",";
            s = s + "'" + ckPublic + "'" + ",";
            s = s + "'" + ckDisableDir + "'" + ",";
            s = s + "'" + OcrDirectory + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (OcrDirectory.Length == 0)
            {
                MessageBox.Show("OcrDirectory  must be set to either Y or N");
            }

            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update SubDir set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "SUBFQN = '" + getSubfqn() + "'" + ", ";
            s = s + "FQN = '" + getFqn() + "'" + ", ";
            s = s + "ckPublic = '" + getCkpublic() + "'" + ", ";
            s = s + "ckDisableDir = '" + getCkdisabledir() + "'";
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
            s = s + "SUBFQN,";
            s = s + "FQN,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir ";
            s = s + " FROM SubDir";
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
            s = s + "SUBFQN,";
            s = s + "FQN,";
            s = s + "ckPublic,";
            s = s + "ckDisableDir ";
            s = s + " FROM SubDir";
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
            s = " Delete from SubDir";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from SubDir";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PKI14(string FQN, string SUBFQN, string UserID)
        {
            int B = 0;
            string TBL = "SubDir";
            string WC = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PKI14


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PKI14(string FQN, string SUBFQN, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "SubDir";
            string WC = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PKI14


        /// Build Index Where Caluses
        public string wc_PKI14(string FQN, string SUBFQN, string UserID)
        {
            string WC = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PKI14
    }
}
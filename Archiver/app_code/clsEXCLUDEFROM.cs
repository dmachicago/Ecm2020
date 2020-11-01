using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEXCLUDEFROM
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string FromEmailAddr = "";
        private string SenderName = "";
        private string UserID = "";




        // ** Generate the SET methods 
        public void setFromemailaddr(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Fromemailaddr' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FromEmailAddr = val;
        }

        public void setSendername(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Sendername' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SenderName = val;
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
        public string getFromemailaddr()
        {
            if (Strings.Len(FromEmailAddr) == 0)
            {
                MessageBox.Show("GET: Field 'Fromemailaddr' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FromEmailAddr);
        }

        public string getSendername()
        {
            if (Strings.Len(SenderName) == 0)
            {
                MessageBox.Show("GET: Field 'Sendername' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SenderName);
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
            if (FromEmailAddr.Length == 0)
                return false;
            if (SenderName.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (FromEmailAddr.Length == 0)
                return false;
            if (SenderName.Length == 0)
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
            s = s + " INSERT INTO ExcludeFrom(";
            s = s + "FromEmailAddr,";
            s = s + "SenderName,";
            s = s + "UserID) values (";
            s = s + "'" + FromEmailAddr + "'" + ",";
            s = s + "'" + SenderName + "'" + ",";
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
            s = s + " update ExcludeFrom set ";
            s = s + "FromEmailAddr = '" + getFromemailaddr() + "'" + ", ";
            s = s + "SenderName = '" + getSendername() + "'" + ", ";
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
            s = s + "FromEmailAddr,";
            s = s + "SenderName,";
            s = s + "UserID ";
            s = s + " FROM ExcludeFrom";
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
            s = s + "FromEmailAddr,";
            s = s + "SenderName,";
            s = s + "UserID ";
            s = s + " FROM ExcludeFrom";
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
            s = " Delete from ExcludeFrom";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ExcludeFrom";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
        {
            int B = 0;
            string TBL = "ExcludeFrom";
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_Pi01_ExcludeFrom

        public int cnt_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
        {
            int B = 0;
            string TBL = "ExcludeFrom";
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_ExcludeFrom


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ExcludeFrom";
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_Pi01_ExcludeFrom

        public SqlDataReader getRow_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "ExcludeFrom";
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_ExcludeFrom


        /// Build Index Where Caluses
        public string wc_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
        {
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_Pi01_ExcludeFrom

        public string wc_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
        {
            string WC = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK_ExcludeFrom
    }
}
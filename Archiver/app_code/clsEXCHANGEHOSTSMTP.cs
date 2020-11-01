using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEXCHANGEHOSTSMTP
    {
        public clsEXCHANGEHOSTSMTP()
        {

            // ** DIM the selected table columns 

            ConnStr = DBARCH.setConnStr();
        }

        private string ConnStr;     // DBARCH.getGateWayConnStr(gGateWayID)
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private clsDataGrid DG = new clsDataGrid();
        private string HostNameIp = "";
        private string UserLoginID = "";
        private string LoginPw = "";
        private string DisplayName = "";


        // ** Generate the SET methods 
        public void setHostnameip(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Hostnameip' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            HostNameIp = val;
        }

        public void setUserloginid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userloginid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserLoginID = val;
        }

        public void setLoginpw(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Loginpw' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LoginPw = val;
        }

        public void setDisplayname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Displayname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            DisplayName = val;
        }



        // ** Generate the GET methods 
        public string getHostnameip()
        {
            if (Strings.Len(HostNameIp) == 0)
            {
                MessageBox.Show("GET: Field 'Hostnameip' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(HostNameIp);
        }

        public string getUserloginid()
        {
            if (Strings.Len(UserLoginID) == 0)
            {
                MessageBox.Show("GET: Field 'Userloginid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserLoginID);
        }

        public string getLoginpw()
        {
            if (Strings.Len(LoginPw) == 0)
            {
                MessageBox.Show("GET: Field 'Loginpw' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(LoginPw);
        }

        public string getDisplayname()
        {
            if (Strings.Len(DisplayName) == 0)
            {
                MessageBox.Show("GET: Field 'Displayname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(DisplayName);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (HostNameIp.Length == 0)
                return false;
            if (UserLoginID.Length == 0)
                return false;
            if (LoginPw.Length == 0)
                return false;
            if (DisplayName.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (HostNameIp.Length == 0)
                return false;
            if (UserLoginID.Length == 0)
                return false;
            if (LoginPw.Length == 0)
                return false;
            if (DisplayName.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ExchangeHostSmtp(";
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "DisplayName) values (";
            s = s + "'" + HostNameIp + "'" + ",";
            s = s + "'" + UserLoginID + "'" + ",";
            s = s + "'" + LoginPw + "'" + ",";
            s = s + "'" + DisplayName + "'" + ")";
            return DBARCH.ExecuteSql(s, ConnStr, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ExchangeHostSmtp set ";
            s = s + "HostNameIp = '" + getHostnameip() + "'" + ", ";
            s = s + "UserLoginID = '" + getUserloginid() + "'" + ", ";
            s = s + "LoginPw = '" + getLoginpw() + "'" + ", ";
            s = s + "DisplayName = '" + getDisplayname() + "'";
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return DBARCH.ExecuteSql(s, ConnStr, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "DisplayName ";
            s = s + " FROM ExchangeHostSmtp";
            // ** s=s+ "ORDERBY xxxx"
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
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "DisplayName ";
            s = s + " FROM ExchangeHostSmtp";
            s = s + WhereClause;
            // ** s=s+ "ORDERBY xxxx"
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
            s = " Delete from ExchangeHostSmtp";
            s = s + WhereClause;
            b = DBARCH.ExecuteSql(s, ConnStr, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ExchangeHostSmtp";
            b = DBARCH.ExecuteSql(s, ConnStr, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
        {
            int B = 0;
            string TBL = "ExchangeHostSmtp";
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_ExchangeHostSmtp

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
        {
            SqlDataReader rsData = null;
            string TBL = "ExchangeHostSmtp";
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_ExchangeHostSmtp

        /// Build Index Where Caluses
        public string wc_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
        {
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'";
            return WC;
        }     // ** wc_PK_ExchangeHostSmtp

        // ** Generate the SET methods 

    }
}
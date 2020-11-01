using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsUSERS
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string UserName = "";
        private string EmailAddress = "";
        private string UserPassword = "";
        private string Admin = "";
        private string isActive = "";
        private string UserLoginID = "";




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

        public void setUsername(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Username' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserName = val;
        }

        public void setEmailaddress(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            EmailAddress = val;
        }

        public void setUserpassword(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserPassword = val;
        }

        public void setAdmin(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Admin = val;
        }

        public void setIsactive(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isActive = val;
        }

        public void setUserloginid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserLoginID = val;
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

        public string getUsername()
        {
            if (Strings.Len(UserName) == 0)
            {
                MessageBox.Show("GET: Field 'Username' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserName);
        }

        public string getEmailaddress()
        {
            return UTIL.RemoveSingleQuotes(EmailAddress);
        }

        public string getUserpassword()
        {
            return UTIL.RemoveSingleQuotes(UserPassword);
        }

        public string getAdmin()
        {
            return UTIL.RemoveSingleQuotes(Admin);
        }

        public string getIsactive()
        {
            return UTIL.RemoveSingleQuotes(isActive);
        }

        public string getUserloginid()
        {
            return UTIL.RemoveSingleQuotes(UserLoginID);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (UserName.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (UserID.Length == 0)
                return false;
            if (UserName.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO Users(";
            s = s + "UserID,";
            s = s + "UserName,";
            s = s + "EmailAddress,";
            s = s + "UserPassword,";
            s = s + "Admin,";
            s = s + "isActive,";
            s = s + "UserLoginID) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + UserName + "'" + ",";
            s = s + "'" + EmailAddress + "'" + ",";
            s = s + "'" + UserPassword + "'" + ",";
            s = s + "'" + Admin + "'" + ",";
            s = s + "'" + isActive + "'" + ",";
            s = s + "'" + UserLoginID + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update Users set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "UserName = '" + getUsername() + "'" + ", ";
            s = s + "EmailAddress = '" + getEmailaddress() + "'" + ", ";
            s = s + "UserPassword = '" + getUserpassword() + "'" + ", ";
            s = s + "Admin = '" + getAdmin() + "'" + ", ";
            s = s + "isActive = '" + getIsactive() + "'" + ", ";
            s = s + "UserLoginID = '" + getUserloginid() + "'";
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
            s = s + "UserName,";
            s = s + "EmailAddress,";
            s = s + "UserPassword,";
            s = s + "Admin,";
            s = s + "isActive,";
            s = s + "UserLoginID ";
            s = s + " FROM Users";
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
            s = s + "UserName,";
            s = s + "EmailAddress,";
            s = s + "UserPassword,";
            s = s + "Admin,";
            s = s + "isActive,";
            s = s + "UserLoginID ";
            s = s + " FROM Users";
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
            s = " Delete from Users";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from Users";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK41(string UserID)
        {
            int B = 0;
            string TBL = "Users";
            string WC = "Where UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK41

        public int cnt_UK_LoginID(string UserLoginID)
        {
            int B = 0;
            string TBL = "Users";
            string WC = "Where UserLoginID = '" + UserLoginID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UK_LoginID


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK41(string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "Users";
            string WC = "Where UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK41

        public SqlDataReader getRow_UK_LoginID(string UserLoginID)
        {
            SqlDataReader rsData = null;
            string TBL = "Users";
            string WC = "Where UserLoginID = '" + UserLoginID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UK_LoginID


        /// Build Index Where Caluses
        public string wc_PK41(string UserID)
        {
            string WC = "Where UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK41

        public string wc_UK_LoginID(string UserLoginID)
        {
            string WC = "Where UserLoginID = '" + UserLoginID + "'";
            return WC;
        }     // ** wc_UK_LoginID


        // ** Generate the SET methods 


    }
}
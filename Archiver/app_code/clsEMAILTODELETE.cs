using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEMAILTODELETE
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string EmailGuid = "";
        private string StoreID = "";
        private string UserID = "";
        private string MessageID = "";




        // ** Generate the SET methods 
        public void setEmailguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Emailguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            EmailGuid = val;
        }

        public void setStoreid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Storeid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            StoreID = val;
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

        public void setMessageid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            MessageID = val;
        }






        // ** Generate the GET methods 
        public string getEmailguid()
        {
            if (Strings.Len(EmailGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Emailguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(EmailGuid);
        }

        public string getStoreid()
        {
            if (Strings.Len(StoreID) == 0)
            {
                MessageBox.Show("GET: Field 'Storeid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(StoreID);
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

        public string getMessageid()
        {
            return UTIL.RemoveSingleQuotes(MessageID);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (EmailGuid.Length == 0)
                return false;
            if (StoreID.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (EmailGuid.Length == 0)
                return false;
            if (StoreID.Length == 0)
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
            s = s + " INSERT INTO EmailToDelete(";
            s = s + "EmailGuid,";
            s = s + "StoreID,";
            s = s + "UserID,";
            s = s + "MessageID) values (";
            s = s + "'" + EmailGuid + "'" + ",";
            s = s + "'" + StoreID + "'" + ",";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + MessageID + "'" + ")";

            // log.WriteToArchiveLog("clsEMAILTODELETE: Insert : Marked for delete email '" + EmailGuid + "'")

            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update EmailToDelete set ";
            s = s + "EmailGuid = '" + getEmailguid() + "'" + ", ";
            s = s + "StoreID = '" + getStoreid() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "MessageID = '" + getMessageid() + "'";
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
            s = s + "EmailGuid,";
            s = s + "StoreID,";
            s = s + "UserID,";
            s = s + "MessageID ";
            s = s + " FROM EmailToDelete";
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
            s = s + "EmailGuid,";
            s = s + "StoreID,";
            s = s + "UserID,";
            s = s + "MessageID ";
            s = s + " FROM EmailToDelete";
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
            s = " Delete from EmailToDelete";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from EmailToDelete";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 


        // ** Generate Index ROW Queries 


        /// Build Index Where Caluses
    }
}
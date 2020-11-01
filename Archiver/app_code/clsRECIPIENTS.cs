using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsRECIPIENTS
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string Recipient = "";
        private string EmailGuid = "";
        private string TypeRecp = "";




        // ** Generate the SET methods 
        public void setRecipient(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Recipient' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Recipient = val;
        }

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

        public void setTyperecp(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            TypeRecp = val;
        }






        // ** Generate the GET methods 
        public string getRecipient()
        {
            if (Strings.Len(Recipient) == 0)
            {
                MessageBox.Show("GET: Field 'Recipient' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Recipient);
        }

        public string getEmailguid()
        {
            if (Strings.Len(EmailGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Emailguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(EmailGuid);
        }

        public string getTyperecp()
        {
            return UTIL.RemoveSingleQuotes(TypeRecp);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (Recipient.Length == 0)
                return false;
            if (EmailGuid.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (Recipient.Length == 0)
                return false;
            if (EmailGuid.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO Recipients(";
            s = s + "Recipient,";
            s = s + "EmailGuid,";
            s = s + "TypeRecp) values (";
            s = s + "'" + Recipient + "'" + ",";
            s = s + "'" + EmailGuid + "'" + ",";
            s = s + "'" + TypeRecp + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update Recipients set ";
            s = s + "Recipient = '" + getRecipient() + "'" + ", ";
            s = s + "EmailGuid = '" + getEmailguid() + "'" + ", ";
            s = s + "TypeRecp = '" + getTyperecp() + "'";
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
            s = s + "Recipient,";
            s = s + "EmailGuid,";
            s = s + "TypeRecp ";
            s = s + " FROM Recipients";
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
            s = s + "Recipient,";
            s = s + "EmailGuid,";
            s = s + "TypeRecp ";
            s = s + " FROM Recipients";
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
            s = " Delete from Recipients";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from Recipients";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK32A(string EmailGuid, string Recipient)
        {
            Recipient = UTIL.RemoveSingleQuotes(Recipient);
            int B = 0;
            string TBL = "Recipients";
            string WC = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK32A


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK32A(string EmailGuid, string Recipient)
        {
            SqlDataReader rsData = null;
            string TBL = "Recipients";
            string WC = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK32A


        /// Build Index Where Caluses
        public string wc_PK32A(string EmailGuid, string Recipient)
        {
            string WC = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'";
            return WC;
        }     // ** wc_PK32A
    }
}